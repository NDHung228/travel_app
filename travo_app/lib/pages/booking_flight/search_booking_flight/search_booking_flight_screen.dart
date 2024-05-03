import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/multi_city.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/one_way.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/top_search_flight.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/round_trip.dart';

class SearchBookingFlightScreen extends StatefulWidget {
  const SearchBookingFlightScreen({Key? key}) : super(key: key);

  @override
  _SearchBookingFlightScreenState createState() =>
      _SearchBookingFlightScreenState();
}

class _SearchBookingFlightScreenState extends State<SearchBookingFlightScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonTopContainer(
            title: AppLocalizations.of(context)!.book_flight,
            content: '',
          ),
          TopSearchFlight(
            selectedIndexNotifier: ValueNotifier<int>(0),
            onIndexChanged: (index) {
              if (index == 0) {
                _pageController.jumpToPage(0);
              } else if (index == 1) {
                _pageController.jumpToPage(1);
              } else if (index == 2) {
                _pageController.jumpToPage(2);
              }
            },
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                BlocProvider(
                  create: (context) => BookingFlightBloc(),
                  child: const OneWayScreen(),
                ),
                const RoundTripScreen(),
                const MultiCityScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
