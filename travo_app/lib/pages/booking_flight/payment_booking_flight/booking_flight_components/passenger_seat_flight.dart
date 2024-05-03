import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/models/booking_flight_model.dart';

class PassengerSeatsFlight extends StatelessWidget {
  final BookingFlight bookingFlight;
  const PassengerSeatsFlight({super.key, required this.bookingFlight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: l10n!.passenger_seat,
              fontWeight: FontWeight.w500,
              size: 20,
            ),
            for (var seat in bookingFlight.listSeat!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CommonText(text: '${l10n.seat}: '),
                        CommonText(
                          text: seat.position!,
                          fontWeight: FontWeight.w500,
                          size: 15,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CommonText(text: '${l10n.passport}: '),
                      ],
                    ),
                  ],
                ),
              ),
            Center(
                child: CommonTextButton(text: l10n.change, onPressed: () {})),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
    );
  }
}
