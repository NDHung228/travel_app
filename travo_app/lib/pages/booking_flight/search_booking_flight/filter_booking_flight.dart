import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/booking_flight_bloc/booking_flight_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/models/search_flight_model.dart';
import 'package:travo_app/routes/route_name.dart';

class FilterBookingFlight extends StatefulWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  final ValueNotifier<RangeValues> transitNotifier;
  final ValueNotifier<RangeValues> budgetNotifier;
  final ValueNotifier<String> sortNotifier;
  final BookingFlightBloc flightBloc;
  const FilterBookingFlight(
      {super.key,
      required this.selectedIndexNotifier,
      required this.transitNotifier,
      required this.budgetNotifier,
      required this.sortNotifier,
      required this.flightBloc});

  @override
  State<FilterBookingFlight> createState() => _FilterBookingFlightState();
}

class _FilterBookingFlightState extends State<FilterBookingFlight> {
 

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.35, vertical: height * 0.025),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: 75,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: ColorConstant.blackColor,
                    shape: BoxShape.rectangle, // Use rectangle for squares
                  ),
                ),
              ),
              CommonText(
                text: AppLocalizations.of(context)!.choose_filter,
                size: 20,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CommonText(
                text: AppLocalizations.of(context)!.transit,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton(
                    context,
                    title: AppLocalizations.of(context)!.one_way,
                    index: 0,
                  ),
                  buildButton(
                    context,
                    title: AppLocalizations.of(context)!.round_trip,
                    index: 1,
                  ),
                  buildButton(
                    context,
                    title: AppLocalizations.of(context)!.multi_city,
                    index: 2,
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CommonText(
                text: AppLocalizations.of(context)!.transit_duration,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              rangeSlider(widget.transitNotifier, 10, 10),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CommonText(
                text: AppLocalizations.of(context)!.budget,
                size: 16,
                fontWeight: FontWeight.w500,
              ),
              rangeSlider(widget.budgetNotifier, 300, 10),
              SizedBox(
                height: height * 0.02,
              ),
              cardElement(AppLocalizations.of(context)!.facilities,
                  Icons.luggage, ColorConstant.coralColor, () {
                context.push(RoutName.filterFacilitiesFlightRouteName);
              }, ValueNotifier<String>('')),
              SizedBox(
                height: height * 0.02,
              ),
              cardElement(AppLocalizations.of(context)!.sort_by,
                  Icons.arrow_downward, ColorConstant.tealColor, () async {
                widget.sortNotifier.value = await context.push(
                        RoutName.sortFlightRouteName,
                        extra: widget.sortNotifier) ??
                    '';
              }, widget.sortNotifier),
              SizedBox(
                height: height * 0.02,
              ),
              CommonTextButton(
                text: AppLocalizations.of(context)!.apply,
                onPressed: () {
                  SearchFlightModel searchFlightModel = SearchFlightModel(
                      sort: widget.sortNotifier.value,
                      startPrice: widget.budgetNotifier.value.start,
                      endPrice: widget.budgetNotifier.value.end,
                      startTime: widget.transitNotifier.value.start.toInt(),
                      endTime: widget.transitNotifier.value.end.toInt());
                  widget.flightBloc.add(SearchFlightRequired(searchFlightModel));
                  context.pop();
                },
                buttonWidth: double.maxFinite,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              CommonTextButton(
                text: AppLocalizations.of(context)!.reset,
                onPressed: () {},
                buttonWidth: double.maxFinite,
                backgroundColor: const Color.fromARGB(255, 227, 225, 225),
                textColor: ColorConstant.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rangeSlider(
      ValueNotifier<RangeValues> notifier, double max, int divisions) {
    return ValueListenableBuilder<RangeValues>(
      valueListenable: notifier,
      builder: (context, values, child) {
        return RangeSlider(
          values: values,
          max: max,
          divisions: divisions,
          labels: RangeLabels(
            values.start.round().toString(),
            values.end.round().toString(),
          ),
          onChanged: (RangeValues newValues) {
            notifier.value = newValues;
          },
        );
      },
    );
  }

  Widget cardElement(String text, IconData icon, Color colorIcon,
      VoidCallback onTap, ValueNotifier<String> content) {
    return SizedBox(
      height: 80,
      child: Card(
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorIcon.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: colorIcon,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              CommonText(
                text: text,
                fontWeight: FontWeight.w500,
              ),
              ValueListenableBuilder(
                valueListenable: content,
                builder: ((context, value, child) {
                  return CommonText(
                    text: ' $value',
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context,
      {required String title, required int index}) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        final isSelected = index == selectedIndex;
        return CommonTextButton(
          buttonWidth: 120,
          buttonHeight: 50,
          text: title,
          onPressed: () {
            widget.selectedIndexNotifier.value = index;
            // onIndexChanged(index); // Call the callback function
          },
          backgroundColor: isSelected
              ? ColorConstant.coralColor
              : ColorConstant.lavenderColor,
          textColor:
              isSelected ? ColorConstant.whiteColor : const Color(0xFF6022AB),
          textSize: 12,
        );
      },
    );
  }
}
