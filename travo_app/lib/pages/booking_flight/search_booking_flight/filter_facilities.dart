import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class FilterFacilities extends StatefulWidget {
  const FilterFacilities({super.key});

  @override
  State<FilterFacilities> createState() => _FilterFacilitiesState();
}

class _FilterFacilitiesState extends State<FilterFacilities> {
  ValueNotifier<bool> wifiNotifier = ValueNotifier(false);
  ValueNotifier<bool> baggageNotifier = ValueNotifier(false);
  ValueNotifier<bool> powerNotifier = ValueNotifier(false);
  ValueNotifier<bool> mealNotifier = ValueNotifier(false);

  @override
  void dispose() {
    wifiNotifier.dispose();
    baggageNotifier.dispose();
    powerNotifier.dispose();
    mealNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          CommonTopContainer(
              title: AppLocalizations.of(context)!.facilities, content: ''),
          Padding(
            padding: EdgeInsets.only(left: width * 0.5, top: height * 0.05),
            child: InkWell(
              onTap: () {
                wifiNotifier.value = true;
                baggageNotifier.value = true;
                powerNotifier.value = true;
                mealNotifier.value = true;
              },
              child: CommonText(
                text: AppLocalizations.of(context)!.select_all,
                color: ColorConstant.primaryColor,
                fontWeight: FontWeight.w500,
                size: 16,
              ),
            ),
          ),
          filterChild('Wifi', Icons.wifi, width, height, wifiNotifier),
          filterChild(AppLocalizations.of(context)!.baggage, Icons.luggage,
              width, height, baggageNotifier),
          filterChild(AppLocalizations.of(context)!.power_usb, Icons.power,
              width, height, powerNotifier),
          filterChild(AppLocalizations.of(context)!.in_flight_meal,
              Icons.restaurant, width, height, mealNotifier),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.1, vertical: height * 0.001),
            child: CommonTextButton(
              text: 'Done',
              onPressed: () {},
              buttonWidth: double.maxFinite,
            ),
          )
        ],
      ),
    );
  }

  Widget filterChild(String content, IconData icon, double width, double height,
      ValueNotifier<bool> notifier) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.1, vertical: height * 0.001),
      child: Row(
        children: [
          CommonIcon(
            icon: icon,
            color: ColorConstant.primaryColor,
            size: 20,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: CommonText(text: content),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: notifier,
            builder: (context, value, child) {
              return Checkbox(
                value: value,
                onChanged: (bool? newValue) {
                  notifier.value = newValue ?? false;
                },
                activeColor: Colors.blue,
                checkColor: ColorConstant.lavenderColor,
              );
            },
          )
        ],
      ),
    );
  }
}
