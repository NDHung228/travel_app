import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonIconText extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const CommonIconText(
      {super.key,
      required this.icon,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonIcon(
          icon: icon,
          color: ColorConstant.primaryColor,
          size: 25,
        ),
        CommonText(
          text: '$title: ',
          fontWeight: FontWeight.w500,
          size: 15,
        ),
        CommonText(text: '$content ',
        size: 15,
        ),
      ],
    );
  }
}
