import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/skeleton.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/models/flight_model.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import Flutter Bloc Import BookingFlightBloc
import 'package:intl/intl.dart';

class BodySearchResultFlight extends StatefulWidget {
  final BookingFlight bookingFlight;
  const BodySearchResultFlight({Key? key, required this.bookingFlight});

  @override
  State<BodySearchResultFlight> createState() => _BodySearchResultFlightState();
}

class _BodySearchResultFlightState extends State<BodySearchResultFlight> {
  @override
  void initState() {
    super.initState();
    context.read<BookingFlightBloc>().add(ListFlightRequired());
  }

  String getImagePath(String airline) {
    switch (airline) {
      case 'AirAsia':
        return ImageConstant.AirAsia;
      case 'LionAir':
        return ImageConstant.LionAir;
      case 'BatikAir':
        return ImageConstant.BatikAir;
      case 'Garuna':
        return ImageConstant.Garuna;
      case 'Citilink':
        return ImageConstant.Citilink;
      default:
        return ImageConstant.flightsImg; // Default image for unknown airlines
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: height * 0.2),
      child: BlocBuilder<BookingFlightBloc, BookingFlightState>(
        builder: (context, state) {
          if (state is GetListFlightLoaded || state is SearchFlightLoaded) {
            List<Flight> listFlight = (state is GetListFlightLoaded)
                ? state.listFlight
                : (state as SearchFlightLoaded).listFlight;
            return SingleChildScrollView(
              child: Column(
                children: listFlight.map((flight) {
                  return cardFlight(context, flight);
                }).toList(),
              ),
            );
          }
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child:  Skeleton(
                  height: 200,
                  width: double.maxFinite,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget cardFlight(BuildContext context, Flight flight) {
    DateFormat timeFormat = DateFormat('hh:mm a');
    String formattedDepartureTime = timeFormat.format(flight.departureTime);
    String formattedArriveTime = timeFormat.format(flight.arriveTime);

    return InkWell(
      onTap: () {
        context.push(RoutName.selectSeatRouteName,
            extra: {"flight": flight, "bookingFlight": widget.bookingFlight});
      },
      child: Card(
        child: Row(
          children: [
            Image.asset(
              getImagePath(flight.airline),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              children: [
                for (int i = 0; i < 15; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 1),
                    width: 2,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E5E5),
                      shape: BoxShape.rectangle,
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(text: AppLocalizations.of(context)!.departure),
                const SizedBox(
                  height: 10,
                ),
                CommonText(
                  text: formattedDepartureTime, // Use formatted departure time
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(text: AppLocalizations.of(context)!.flight_no),
                    const SizedBox(
                      height: 10,
                    ),
                    CommonText(
                      text: flight.flightNumber,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(text: AppLocalizations.of(context)!.arrive),
                const SizedBox(
                  height: 10,
                ),
                CommonText(
                  text: formattedArriveTime, // Use formatted arrive time
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 40,
                ),
                CommonText(
                  text: '\$${flight.price}',
                  fontWeight: FontWeight.w500,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
