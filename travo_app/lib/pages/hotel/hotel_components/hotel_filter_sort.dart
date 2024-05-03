import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class HotelFilterSort extends StatefulWidget {
  const HotelFilterSort({super.key});

  @override
  State<HotelFilterSort> createState() => _HotelFilterSortState();
}

class _HotelFilterSortState extends State<HotelFilterSort> {
  late final ValueNotifier<String> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<String>('');
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          CommonTopContainer(title: l10n.sort_by, content: ''),
          const SizedBox(
            height: 10,
          ),
          elementWidget(l10n.lowest_price),
          elementWidget(l10n.highest_price),
          elementWidget(l10n.highest_popularity),
          elementWidget(l10n.highest_rating),

            const SizedBox(
            height: 50,
          ),
          CommonTextButton(
            text: l10n.apply,
            onPressed: () {
              if (_valueNotifier.value.isNotEmpty) {
                context.pop(_valueNotifier.value);
              }
            },
            buttonWidth: 350,
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
          _valueNotifier.value = content;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonText(
              text: content,
              size: 15,
            ),
            ValueListenableBuilder(
              valueListenable: _valueNotifier,
              builder: ((context, value, child) {
                return Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _valueNotifier.value == content
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
