import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  ValueNotifier<bool> flagNotifier = ValueNotifier<bool>(true);
  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 50);
      secondHalf = widget.text.substring(50, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  void dispose() {
    flagNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : ValueListenableBuilder(
              valueListenable: flagNotifier,
              builder: (context, value, child) {
                return Column(
                  children: <Widget>[
                    CommonText(
                        text: flagNotifier.value
                            ? (firstHalf + "...")
                            : (firstHalf + secondHalf)),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CommonText(
                            text: flagNotifier.value ? "See More" : "See Less",
                            color: const Color(0xFF636363),
                          )
                        ],
                      ),
                      onTap: () {
                        flagNotifier.value = !flagNotifier.value;
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
