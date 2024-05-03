import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class SortFlight extends StatefulWidget {
  final ValueNotifier<String> sortNotifier;

  const SortFlight({super.key, required this.sortNotifier});

  @override
  State<SortFlight> createState() => _SortFlightState();
}

class _SortFlightState extends State<SortFlight> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          CommonTopContainer(
              title: AppLocalizations.of(context)!.sort_by, content: ''),
          elementWidget(
            AppLocalizations.of(context)!.earliest_departure,
          ),
          elementWidget(
            AppLocalizations.of(context)!.latest_departure,
          ),
          elementWidget(
            AppLocalizations.of(context)!.earliest_arrive,
          ),
          elementWidget(
            AppLocalizations.of(context)!.latest_arrive,
          ),
          elementWidget(
            AppLocalizations.of(context)!.shortest_duration,
          ),
          elementWidget(
            AppLocalizations.of(context)!.lowest_price,
          ),
          elementWidget(
            AppLocalizations.of(context)!.highest_popularity,
          ),
          SizedBox(
            height: height * 0.05,
          ),
          CommonTextButton(
            text: AppLocalizations.of(context)!.apply,
            onPressed: () {
              if (widget.sortNotifier.value.isNotEmpty) {
                context.pop(widget.sortNotifier.value);
              }
            },
            buttonWidth: width * 0.8,
          )
        ],
      ),
    );
  }

  Widget elementWidget(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: GestureDetector(
        onTap: () {
          widget.sortNotifier.value = content;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: content,
              size: 15,
            ),
            ValueListenableBuilder(
              valueListenable: widget.sortNotifier,
              builder: ((context, value, child) {
                return Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: widget.sortNotifier.value == content
                        ? ColorConstant.tealColor
                        : ColorConstant.lavenderColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
