import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/app_bar_search_result.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/body_search_result_flight.dart';

class SearchResultFlight extends StatefulWidget {
  final BookingFlight bookingFlight;
  const SearchResultFlight({super.key, required this.bookingFlight});

  @override
  State<SearchResultFlight> createState() => _SearchResultFlightState();
}

class _SearchResultFlightState extends State<SearchResultFlight> {
  late BookingFlightBloc _flightBloc;

  @override
  void initState() {
    super.initState();
    _flightBloc = BookingFlightBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocProvider.value(
            value: _flightBloc,
            child: AppBarSearchResult(
              flightBloc: _flightBloc,
            ), // Pass _hotelBloc to HotelAppBar
          ),
          BlocProvider.value(
            value: _flightBloc,
            child: BodySearchResultFlight(bookingFlight: widget.bookingFlight),
          )
        ],
      ),
    );
  }
}
