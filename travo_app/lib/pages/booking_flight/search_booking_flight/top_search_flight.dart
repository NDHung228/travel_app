import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class TopSearchFlight extends StatefulWidget {
  final ValueNotifier<int> selectedIndexNotifier;
  final Function(int) onIndexChanged; // Add callback function
  const TopSearchFlight({Key? key, required this.selectedIndexNotifier, required this.onIndexChanged}) : super(key: key);

  @override
  State<TopSearchFlight> createState() => _TopSearchFlightState();
}

class _TopSearchFlightState extends State<TopSearchFlight> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
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
    );
  }

  Widget buildButton(BuildContext context, {required String title, required int index}) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.selectedIndexNotifier,
      builder: (context, selectedIndex, child) {
        final isSelected = index == selectedIndex;
        return CommonTextButton(
          text: title,
          onPressed: () {
            widget.selectedIndexNotifier.value = index;
            widget.onIndexChanged(index); // Call the callback function
          },
          backgroundColor: isSelected ? ColorConstant.coralColor : ColorConstant.lavenderColor,
          textColor: isSelected ? ColorConstant.whiteColor : const Color(0xFF6022AB),
          textSize: 14,
        );
      },
    );
  }
}
