import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/hotel_bloc/hotel_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/routes/route_name.dart';

class HotelFilterBottomSheet extends StatefulWidget {
  final ValueNotifier<RangeValues> rangeValuesNotifier;
  final ValueNotifier<String> sortNotifier;

  final HotelBloc hotelBloc;
  final AppLocalizations l10n;

  const HotelFilterBottomSheet({
    Key? key,
    required this.rangeValuesNotifier,
    required this.hotelBloc,
    required this.l10n,
    required this.sortNotifier,
  }) : super(key: key);

  @override
  State<HotelFilterBottomSheet> createState() => _HotelFilterBottomSheetState();
}

class _HotelFilterBottomSheetState extends State<HotelFilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CommonText(
                text: widget.l10n.choose_filter,
                size: 24,
                fontWeight: FontWeight.w500,
              ),
              CommonText(
                text: widget.l10n.budget,
                size: 15,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder<RangeValues>(
                valueListenable: widget.rangeValuesNotifier,
                builder: (context, _currentRangeValues, child) {
                  return RangeSlider(
                    values: _currentRangeValues,
                    max: 1000,
                    divisions: 10,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      widget.rangeValuesNotifier.value = values;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              hotelClass(),
              const SizedBox(
                height: 10,
              ),
              cardElement(Icons.wifi, const Color(0xFFF77777),
                  widget.l10n.facilities, () {}, ValueNotifier<String>('')),
              const SizedBox(
                height: 10,
              ),
              cardElement(
                  Icons.sort, ColorConstant.tealColor, widget.l10n.sort_by,
                  () async {
                widget.sortNotifier.value =
                    await context.push(RoutName.filterSort) ?? '';
              }, widget.sortNotifier),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CommonTextButton(
                  onPressed: () {
                    Future.delayed(const Duration(seconds: 1), () {
                      widget.hotelBloc.add(SearchHotelRequired(
                          startPrice: widget.rangeValuesNotifier.value.start,
                          endPrice: widget.rangeValuesNotifier.value.end,
                          sort: widget.sortNotifier.value));
                      Navigator.pop(context);
                    });
                  },
                  text: widget.l10n.apply,
                  buttonWidth: double.maxFinite,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardElement(IconData icon, Color colorIcon, String text,
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

  Widget hotelClass() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
          text: widget.l10n.hotel_class,
          size: 15,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            for (int i = 0; i < 5; i++)
              const CommonIcon(
                icon: Icons.star,
                color: Color(0xFFFFC107),
                size: 25,
              )
            // Add more stars as needed
          ],
        )
      ],
    );
  }
}
