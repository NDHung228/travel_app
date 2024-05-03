import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:travo_app/blocs/booking_hotel_bloc/booking_hotel_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_date.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfirmBookingBody extends StatefulWidget {
  final BookingHotel bookingHotel;

  const ConfirmBookingBody({
    Key? key,
    required this.bookingHotel,
  }) : super(key: key);

  @override
  State<ConfirmBookingBody> createState() => _ConfirmBookingBodyState();
}

class _ConfirmBookingBodyState extends State<ConfirmBookingBody> {
  late Room room;
  late int differenceInDays;
  late double priceInitial;
  late AppLocalizations l10n;

  @override
  void initState() {
    // BlocProvider.of<RoomBloc>(context)
    //     .add(GetRoomRequiredById(roomId: widget.bookingHotel.room ?? ''));

    context
        .read<RoomBloc>()
        .add(GetRoomRequiredById(roomId: widget.bookingHotel.room ?? ''));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    l10n = AppLocalizations.of(context)!;
    final stateRoom = context.watch<RoomBloc>().state;

    if (stateRoom is GetRoomLoadedById) {
      room = stateRoom.room;

      priceInitial = differenceInDays * room.price;
      widget.bookingHotel.price =
          differenceInDays * room.price * (widget.bookingHotel.promo_code ?? 1);
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          final user = state.user;
          widget.bookingHotel.email = user!.email;
          return Padding(
            padding: EdgeInsets.only(right: 20, left: 20, top: height * 0.2),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  roomInformation(height, width),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  feeInformation(height, width),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  bankTransfer(
                      height,
                      width,
                      ValueNotifier<String>(
                          widget.bookingHotel.type_payment ?? "")),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  CommonTextButton(
                    text: 'Pay Now',
                    onPressed: () {
                      context.read<BookingHotelBloc>().add(BookingHotelRequired(
                          bookingHotel: widget.bookingHotel));
                      context.go(RoutName.listPaymentRouteName);
                    },
                    buttonWidth: width * 0.9,
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget roomInformation(double height, double width) {
    DateTime startDate = DateTime.tryParse(widget.bookingHotel.date_start!)!;
    DateTime endDate = DateTime.tryParse(widget.bookingHotel.date_end!)!;

    Duration difference = endDate.difference(startDate);
    differenceInDays = difference.inDays;

    return Card(
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is GetRoomLoadedById) {
            room = state.room;

            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.05, vertical: height * 0.01),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: room.name,
                            size: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          CommonText(text: room.typePrice),
                          Row(
                            children: [
                              const CommonIcon(
                                icon: Icons.bed,
                                color: ColorConstant.coralColor,
                              ),
                              CommonText(text: '2 King Bed')
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10.0), // Set the desired border radius here
                          child: CachedNetworkImage(
                            imageUrl: room.image,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => AspectRatio(
                              aspectRatio: (640) / 480,
                              child: Container(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < width / 14; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: width * 0.02,
                          height: height * 0.0025,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E5E5),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BookingDate(
                    startDateNotifier: ValueNotifier<DateTime?>(
                      widget.bookingHotel.date_start != null ? startDate : null,
                    ),
                    endDateNotifier: ValueNotifier<DateTime?>(
                      widget.bookingHotel.date_end != null ? endDate : null,
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget feeInformation(double height, double width) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is GetRoomLoadedById) {
          room = state.room;
          return Card(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.0, horizontal: width * 0.1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(text: '$differenceInDays Night'),
                      CommonText(text: '\$${priceInitial.toInt()}')
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(text: 'Taxes and Fees'),
                      CommonText(text: 'Free')
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(text: l10n.promo),
                      CommonText(
                        text: widget.bookingHotel.promo_code != null
                            ? '${(widget.bookingHotel.promo_code! * 100).toInt()}%'
                            : '-',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      for (int i = 0; i < width / 16; i++)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: width * 0.02,
                          height: height * 0.0025,
                          decoration: const BoxDecoration(
                            color: Color(0xFFE5E5E5),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: 'Total',
                        fontWeight: FontWeight.w500,
                      ),
                      CommonText(
                        text:
                            '\$${widget.bookingHotel.price!.toInt().toString()}',
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Card bankTransfer(
      double height, double width, ValueNotifier<String> typePayment) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConstant.tealColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.payment,
                    size: 20,
                    color: ColorConstant.tealColor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CommonText(
                    text: widget.bookingHotel.type_payment!,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // Handle change action
                },
                child: CommonText(
                  text: 'Change',
                  color: ColorConstant.indigoColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
