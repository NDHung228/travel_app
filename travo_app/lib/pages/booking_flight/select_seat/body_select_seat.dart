import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/seat_flight_bloc/seat_flight_bloc.dart';
import 'package:travo_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/models/seat_model.dart';
import 'package:travo_app/pages/booking_flight/one_way_search_flight.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BodySelectSeat extends StatefulWidget {
  final Flight flight;
  final BookingFlight bookingFlight;

  const BodySelectSeat(
      {Key? key, required this.flight, required this.bookingFlight})
      : super(key: key);

  @override
  State<BodySelectSeat> createState() => _BodySelectSeatState();
}

class _BodySelectSeatState extends State<BodySelectSeat> {
  late List<TypeClass> listPassenger;
  late final SignInBloc signInBloc;
  @override
  void initState() {
    super.initState();

    listPassenger = widget.bookingFlight.passengerClasses!;

    signInBloc = SignInBloc(userRepo: AuthCases());
    signInBloc.add(const GetMyUserRequired());
  }

  String calculatePrice(List<Seat> listSeatChosen) {
    if (listSeatChosen.isEmpty) return 0.toString();
    return (widget.flight.price * listSeatChosen.length).toInt().toString();
  }

  void updateNameOfBookingFlight() {
    final userState = signInBloc.state;
    if (userState is GetMyUser) {
      widget.bookingFlight.name = userState.myUser!.name;
      widget.bookingFlight.email = userState.myUser!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    List<dynamic> listSeat = widget.flight.seatAvailability!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Row(
            children: [
              seatPrice(l10n),
              seatClass(l10n, listSeat),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CommonTextButton(
            text: l10n.processed,
            onPressed: () {
              updateNameOfBookingFlight();

              if (widget.bookingFlight.listSeat!.length ==
                  widget.bookingFlight.passengers) {
                context.push(RoutName.bookReviewFlight, extra: {
                  "flight": widget.flight,
                  "bookingFlight": widget.bookingFlight
                });
              }
            },
            buttonWidth: MediaQuery.of(context).size.width * 0.8,
          )
        ],
      ),
    );
  }

  Widget seatClass(AppLocalizations l10n, List<dynamic> listSeat) {
    List<String> seatIdentifiers = ['A', 'B', 'C', 'D', 'E', 'F'];
    return BlocBuilder<SeatFlightBloc, SeatFlightState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              SvgPicture.asset(
                ImageConstant.planeSVG,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * 0.73,
                // height:850,
              ),
              Positioned(
                top: 80,
                left: 75,
                child: SvgPicture.asset(
                  ImageConstant.nosePlane,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 230,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  // Wrap with SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection:
                      Axis.horizontal, // Set scroll direction to horizontal
                  child: Column(
                    children: [
                      CommonText(
                        text: l10n.business_class,
                        fontWeight: FontWeight.w500,
                      ),
                      for (int index = 0; index < listSeat.length; index++)
                        Column(
                          children: [
                            if (index == 1)
                              CommonText(
                                text: l10n.economy_class,
                                fontWeight: FontWeight.w500,
                              ),
                            Column(
                              children: [
                                for (int j = 0;
                                    j < listSeat[index].values.length;
                                    j++)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      for (int i = 0;
                                          i <
                                              listSeat[index]
                                                  .values
                                                  .toList()[j]
                                                  .length;
                                          i++)
                                        Row(
                                          children: [
                                            if (i ==
                                                listSeat[index]
                                                        .values
                                                        .toList()[j]
                                                        .length ~/
                                                    2)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: Container(
                                                  width: 24,
                                                  alignment: Alignment.center,
                                                  child: CommonText(
                                                    text: (j + 1).toString(),
                                                    fontWeight: FontWeight.w500,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            const SizedBox(width: 10),
                                            childSeat(
                                                seatIdentifiers[i],
                                                listSeat[index]
                                                    .values
                                                    .toList()[j][i] as bool,
                                                j,
                                                i,
                                                index,
                                                listSeat,
                                                state is SeatUpdatedState
                                                    ? (state
                                                            as SeatUpdatedState)
                                                        .listSeat
                                                    : []),
                                          ],
                                        ),
                                    ],
                                  ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget childSeat(
    String text,
    bool isActive,
    int indexColumn,
    int indexRow,
    int indexType,
    List<dynamic> listSeat,
    List<Seat> listSeatChosen,
  ) {
    // Check if the current seat is chosen
    bool isChosen = listSeatChosen.any((seat) =>
        seat.index == indexType &&
        seat.row == indexRow &&
        seat.column == indexColumn);

    Color seatColor = isActive
        ? isChosen
            ? ColorConstant.tealColor
            : Colors.white // Chosen seat color: Green, Otherwise: White
        : ColorConstant.lavenderColor; // Inactive seat color

    return InkWell(
      onTap: () {
        BlocProvider.of<SeatFlightBloc>(context).add(SeatClickedEvent(
            indexType,
            indexRow,
            indexColumn,
            listSeat,
            listSeatChosen,
            widget.bookingFlight.passengers!,
            listPassenger));
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: seatColor, // Use the determined seat color
            border: Border.all(color: ColorConstant.lavenderColor),
          ),
          height: 50,
          width: 25,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              CommonText(
                text: isActive == true ? text : '',
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget seatPrice(AppLocalizations l10n) {
    return BlocBuilder<SeatFlightBloc, SeatFlightState>(
      builder: (context, state) {
        String price = ''; // Initialize price

        if (state is SeatUpdatedState) {
          // Calculate the price based on the selected seats
          price = calculatePrice(state.listSeat);
          // Get the seat position and type
          if (state.listSeat.isNotEmpty) {}
        } else {
          price = 0.toString();
        }

        if (state is SeatUpdatedState && state.listSeat.isNotEmpty) {
          widget.bookingFlight.listSeat = state.listSeat;
          widget.bookingFlight.price = double.parse(price);
        }

        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorConstant.tealColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Icon(
                        Icons.microwave_sharp,
                        color: ColorConstant.tealColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CommonText(
                      text: l10n.seat,
                      color: const Color(0xFF636363),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (state is SeatUpdatedState && state.listSeat.isNotEmpty)
                  for (Seat seat in state.listSeat)
                    seatPosition(
                      '${seat.position ?? ""}', // Accessing the position of the current seat
                      seat.typeClass ??
                          "", // Accessing the typeClass of the current seat
                    ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30)
                      .copyWith(bottom: 20),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: ColorConstant.lavenderColor,
                      border:
                          Border.all(color: Colors.grey), // Grey border color
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: Center(
                      child: CommonText(
                        text: '\$' + price, // Display the price dynamically
                        color: ColorConstant.primaryColor,
                        size: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget seatPosition(String content, String typeClass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 35,
          child: CommonText(
            text: content,
            fontWeight: FontWeight.w500,
            size: 24,
            color: ColorConstant.primaryColor,
          ),
        ),
        const SizedBox(width: 20),
        CommonText(
          text: typeClass,
          fontWeight: FontWeight.w500,
          size: 15,
          color: ColorConstant.blackColor,
        ),
      ],
    );
  }
}
