import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/flight_utils/flight_utils.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/routes/route_name.dart';

class BodyConfirmFlight extends StatefulWidget {
  final BookingFlight bookingFlight;

  const BodyConfirmFlight({super.key, required this.bookingFlight});

  @override
  State<BodyConfirmFlight> createState() => _BodyConfirmFlightState();
}

class _BodyConfirmFlightState extends State<BodyConfirmFlight> {
  late double priceInitial;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceInitial = widget.bookingFlight.price!;
    calCulateTotalPrice();
  }

  void calCulateTotalPrice() {
    if (widget.bookingFlight.promoCode != null) {
      widget.bookingFlight.price =
          widget.bookingFlight.price! * widget.bookingFlight.promoCode!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        cardDetailFlight(l10n!, context, priceInitial),
        const SizedBox(
          height: 20,
        ),
        cardPrice(l10n, context, priceInitial),
        const SizedBox(
          height: 20,
        ),
        bankTransfer(height, width,
            ValueNotifier<String>(widget.bookingFlight.typePayment ?? "")),
        const SizedBox(
          height: 20,
        ),
        CommonTextButton(
          text: l10n.payment,
          onPressed: () {
            calCulateTotalPrice();
            context
                .read<BookingFlightBloc>()
                .add(BookingFlightRequired(widget.bookingFlight));

            context.go(RoutName.listPaymentRouteName);
          },
          buttonWidth: 350,
        ),
      ],
    );
  }

  Widget cardPrice(
      AppLocalizations l10n, BuildContext context, double priceInitial) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                    text: '${widget.bookingFlight.listSeat!.length} ' +
                        l10n.passengers),
                CommonText(
                  text: '\$${priceInitial.toInt()}',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: l10n.insurance),
                CommonText(
                  text: '-',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(text: l10n.promo),
                CommonText(
                  text: widget.bookingFlight.promoCode != null
                      ? '${(widget.bookingFlight.promoCode! * 100).toInt()}%'
                      : '-',
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < MediaQuery.of(context).size.width / 14; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    width: MediaQuery.of(context).size.width * 0.02,
                    height: MediaQuery.of(context).size.height * 0.0025,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E5E5),
                      shape: BoxShape.rectangle,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  text: l10n.total,
                  fontWeight: FontWeight.w500,
                  size: 20,
                ),
                CommonText(
                  text: '\$${widget.bookingFlight.price!.toInt()}',
                  fontWeight: FontWeight.w500,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Widget cardDetailFlight(
      AppLocalizations l10n, BuildContext context, double priceInitial) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: widget.bookingFlight.from!,
                      fontWeight: FontWeight.w500,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 30,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: ColorConstant.blackColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    const RotatedBox(
                      quarterTurns: 1,
                      child: CommonIcon(
                        icon: Icons.airplanemode_active,
                        size: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 30,
                      height: 2,
                      decoration: const BoxDecoration(
                        color: ColorConstant.blackColor,
                        shape: BoxShape.rectangle,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    CommonText(
                      text: widget.bookingFlight.to!,
                      fontWeight: FontWeight.w500,
                      size: 20,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < MediaQuery.of(context).size.width / 14;
                      i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: MediaQuery.of(context).size.width * 0.02,
                      height: MediaQuery.of(context).size.height * 0.0025,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    FlightUtils.getImagePath(widget.bookingFlight.airLine!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.air_line),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: widget.bookingFlight.airLine!,
                        fontWeight: FontWeight.w500,
                        size: 15,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.passengers),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: widget.bookingFlight.name!,
                        fontWeight: FontWeight.w500,
                        size: 15,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.date),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: widget.bookingFlight.dateTime!,
                        fontWeight: FontWeight.w500,
                        size: 15,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.gate),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: widget.bookingFlight.flightNumber!,
                        fontWeight: FontWeight.w500,
                        size: 15,
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.flight_no),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: 'NNS24',
                        fontWeight: FontWeight.w500,
                        size: 15,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.boarding_time),
                      for (var seat in widget.bookingFlight.listSeat!)
                        CommonText(
                          text: widget.bookingFlight.hourTime!,
                          fontWeight: FontWeight.w500,
                          size: 15,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.seat),
                      for (var seat in widget.bookingFlight.listSeat!)
                        CommonText(
                          text: seat.position!,
                          fontWeight: FontWeight.w500,
                          size: 15,
                        ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.class_flight),
                      for (var seat in widget.bookingFlight.listSeat!)
                        CommonText(
                          text: seat.typeClass!,
                          fontWeight: FontWeight.w500,
                          size: 15,
                        )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0;
                      i < MediaQuery.of(context).size.width / 14;
                      i++)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: MediaQuery.of(context).size.width * 0.02,
                      height: MediaQuery.of(context).size.height * 0.0025,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE5E5E5),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(ImageConstant.barCode),
                ),
              ),
              CommonText(text: '1234 5678 90AS 6543 21CV'),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
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
                    text: widget.bookingFlight.typePayment!,
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
