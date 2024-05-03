import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:travo_app/common_widgets/common_contact_detail.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_promo_code.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/flight_utils/flight_utils.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/contact_detail_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/booking_flight_components/appbar_booking_flight.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/pages/booking_flight/payment_booking_flight/booking_flight_components/passenger_seat_flight.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/routes/route_name.dart';

class BookReviewFlight extends StatefulWidget {
  final BookingFlight bookingFlight;
  final Flight flight;
  const BookReviewFlight(
      {super.key, required this.bookingFlight, required this.flight});

  @override
  State<BookReviewFlight> createState() => _BookReviewFlightState();
}

class _BookReviewFlightState extends State<BookReviewFlight> {
  late final ValueNotifier<List<ContactDetail>> _listContactNotifier;
  late final BookingFlight bookingFlight;
  late final Flight flight;
  late final ValueNotifier<String?> _promoCodeNotifier;

  @override
  void initState() {
    _listContactNotifier = ValueNotifier<List<ContactDetail>>([]);
    bookingFlight = widget.bookingFlight;
    flight = widget.flight;
    _promoCodeNotifier = ValueNotifier<String>('');
    updateBookingFlight();
    super.initState();
  }

  void updateBookingFlight() {
    bookingFlight.from = flight.fromPlace;
    bookingFlight.to = flight.toPlace;
    bookingFlight.flightNumber = flight.flightNumber;
    bookingFlight.airLine = flight.airline;
    bookingFlight.hourTime =
        FlightUtils.formatTime(flight.arriveTime.toString());
    bookingFlight.dateTime =
        FlightUtils.formatDate(flight.departureTime.toString());
  }

  @override
  void dispose() {
    _listContactNotifier.dispose();
    _promoCodeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AppBarBookingFlight(index: 1),
            BlocProvider(
              create: (context) =>
                  AuthenticationBloc(userRepository: AuthCases()),
              child: cardDetailFlight(l10n!),
            ),
            childOfBookAndReview(
              Icons.person,
              ColorConstant.primaryColor,
              'Contact Details',
              'Add Contact',
              height,
              width,
              () async {
                if (_listContactNotifier.value.length <
                    widget.bookingFlight.listSeat!.length) {
                  ContactDetail? dataContact =
                      await context.push(RoutName.addContactRouteName);
                  if (dataContact != null) {
                    _listContactNotifier.value = [
                      ..._listContactNotifier.value,
                      dataContact
                    ];
                  }
                }
              },
              true,
              _listContactNotifier,
            ),
            // PassengerSeatsFlight(bookingFlight: widget.bookingFlight,),
            childOfBookAndReview(
              Icons.percent_rounded,
              ColorConstant.coralColor,
              'Promo Code',
              'Add Promo Code',
              height,
              width,
              () async {
                double? promoCode =
                    await context.push(RoutName.addPromoCodeRouteName);
                if (promoCode != null) {
                  _promoCodeNotifier.value =
                      (promoCode * 100).toInt().toString() + '%';
                  bookingFlight.promoCode = promoCode;
                }
              },
              false,
              _listContactNotifier,
            ),
            CommonTextButton(
              text: l10n.payment,
              onPressed: () {
                if (bookingFlight.listSeat!.length ==
                    bookingFlight.passengers) {
                  context.push(RoutName.paymentFlight, extra: bookingFlight);
                }
              },
              buttonWidth: width * 0.9,
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget childOfBookAndReview(
    IconData icon,
    Color colorIcon,
    String title,
    String content,
    double height,
    double width,
    VoidCallback onTap,
    bool contact,
    ValueNotifier<List<ContactDetail>> listContactNotifier,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: colorIcon.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Icon(
                      icon,
                      color: colorIcon,
                    ),
                  ),
                  const SizedBox(width: 20),
                  CommonText(
                    text: title,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              contact
                  ? ValueListenableBuilder<List<ContactDetail>>(
                      valueListenable: listContactNotifier,
                      builder: (context, listContact, _) {
                        return Column(
                          children: listContact
                              .map((contactDetail) => CommonContactDetail(
                                  contactDetail: contactDetail))
                              .toList(),
                        );
                      },
                    )
                  : ValueListenableBuilder<String?>(
                      valueListenable: _promoCodeNotifier,
                      builder: (context, promoCode, _) {
                        return CommonPromoCode(promoCode: promoCode,);
                      },
                    ),
              SizedBox(height: height * 0.01),
              Container(
                height: 50,
                width: width * 0.6,
                decoration: BoxDecoration(
                  color: ColorConstant.lavenderColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: InkWell(
                  onTap: onTap,
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      CommonText(
                        text: content,
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDetailFlight(AppLocalizations l10n) {  
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
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
                          text: bookingFlight.from!,
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
                        const CommonIcon(
                          icon: Icons.airplanemode_active,
                          size: 20,
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
                          text: flight.toPlace,
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
                        FlightUtils.getImagePath(flight.airline),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: l10n.air_line),
                          const SizedBox(
                            height: 5,
                          ),
                          CommonText(
                            text: flight.airline,
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
                            text: bookingFlight.name!,
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
                            text: FlightUtils.formatDate(
                                flight.arriveTime.toString()),
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
                            text: flight.flightNumber,
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
                          for (var seat in bookingFlight.listSeat!)
                            CommonText(
                              text: FlightUtils.formatTime(
                                  flight.arriveTime.toString()),
                              fontWeight: FontWeight.w500,
                              size: 15,
                            ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: l10n.seat),
                          for (var seat in bookingFlight.listSeat!)
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
                          for (var seat in bookingFlight.listSeat!)
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
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                        text: '\$${bookingFlight.price!.toInt()}',
                        size: 25,
                        fontWeight: FontWeight.w500,
                      ),
                      CommonText(
                          text:
                              '${bookingFlight.listSeat!.length} ${l10n.passengers}')
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
