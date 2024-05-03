import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/blocs/seat_flight_bloc/seat_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/pages/booking_flight/select_seat/body_select_seat.dart';

class SelectSeatScreen extends StatefulWidget {
  final Flight flight;
  final BookingFlight bookingFlight;
  const SelectSeatScreen(
      {super.key, required this.flight, required this.bookingFlight});

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  late Flight flight;
  late BookingFlight bookingFlight;

  @override
  void initState() {
    super.initState();
    flight = widget.flight;
    bookingFlight = widget.bookingFlight;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTopContainer(title: l10n.select_seat, content: ''),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BookingFlightBloc(),
              ),
              BlocProvider(
                create: (context) => SeatFlightBloc(
                    listSeatInitial:
                        List.from(widget.flight.seatAvailability!)),
              ),
            ],
            child: BodySelectSeat(
              flight: widget.flight,
              bookingFlight: widget.bookingFlight,
            ),
          )
        ],
      ),
    );
  }
}
