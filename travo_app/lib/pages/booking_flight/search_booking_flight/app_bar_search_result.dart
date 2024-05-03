import 'package:flutter/material.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/pages/booking_flight/search_booking_flight/filter_booking_flight.dart';

class AppBarSearchResult extends StatefulWidget {
  final BookingFlightBloc flightBloc;
  const AppBarSearchResult({super.key, required this.flightBloc});

  @override
  State<AppBarSearchResult> createState() => _AppBarSearchResultState();
}

class _AppBarSearchResultState extends State<AppBarSearchResult> {
  final ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  final _transitNotifier = ValueNotifier<RangeValues>(const RangeValues(0, 10));
  final _budgetNotifier = ValueNotifier<RangeValues>(const RangeValues(0, 300));
  final ValueNotifier<String> _sortNotifier = ValueNotifier<String>('');

  @override
  void dispose() {
    selectedIndexNotifier.dispose();
    _transitNotifier.dispose();
    _budgetNotifier.dispose();
    _sortNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 4,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.backgroundImg,
          ), // Replace with your image asset
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Navigator.canPop(context)
                ? CommonIconButton(
                    color: const Color(0xFF232323),
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CommonText(
                      text: 'JKT',
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            width: width * 0.02,
                            height: height * 0.0025,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5E5E5),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                      ],
                    ),
                    const CommonIcon(
                      icon: Icons.airplanemode_active,
                      color: ColorConstant.whiteColor,
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < 3; i++)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            width: width * 0.02,
                            height: height * 0.0025,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE5E5E5),
                              shape: BoxShape.rectangle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CommonText(
                      text: 'SBY',
                      color: ColorConstant.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              ],
            ),
            CommonIconButton(
              color: const Color(0xFF232323),
              icon: Icons.menu,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.8, // Adjust the height as needed
                    child: FilterBookingFlight(
                      flightBloc: widget.flightBloc,
                      budgetNotifier: _budgetNotifier,
                      selectedIndexNotifier: selectedIndexNotifier,
                      transitNotifier: _transitNotifier,
                      sortNotifier: _sortNotifier,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
