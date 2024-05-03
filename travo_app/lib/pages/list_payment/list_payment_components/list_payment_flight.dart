import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/flight_utils/flight_utils.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListPaymentFlight extends StatelessWidget {
  final List<BookingFlight> listBookingFlight;
  const ListPaymentFlight({super.key, required this.listBookingFlight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Expanded(
        child: ListView.builder(
      itemCount: listBookingFlight.length,
      itemBuilder: (context, index) {
        return cardDetailFlight(l10n!, context, listBookingFlight[index]);
      },
    ));
  }

  Widget cardDetailFlight(AppLocalizations l10n, BuildContext context,
      BookingFlight bookingFlight) {
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
                      text: bookingFlight.to!,
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
                    FlightUtils.getImagePath(bookingFlight.airLine!),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(text: l10n.air_line),
                      const SizedBox(
                        height: 5,
                      ),
                      CommonText(
                        text: bookingFlight.airLine!,
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
                        text: bookingFlight.dateTime!,
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
                        text: bookingFlight.flightNumber!,
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
                          text: bookingFlight.hourTime!,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(ImageConstant.barCode),
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonText(
                          text: '${bookingFlight.listSeat!.length} ' +
                              l10n.passengers),
                      CommonText(
                        text: bookingFlight.promoCode == 0
                            ? '\$${bookingFlight.price}'
                            : '\$${(bookingFlight.price! ~/ bookingFlight.promoCode!).toInt()}',
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
                        text: bookingFlight.promoCode != null
                            ? '${(bookingFlight.promoCode! * 100).toInt()}%'
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
                        text: '\$${bookingFlight.price!.toInt()}',
                        fontWeight: FontWeight.w500,
                        size: 20,
                      ),
                    ],
                  ),
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
  }
}
