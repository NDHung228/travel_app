import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color backgroundColor;
  final Color textColor;
  const CommonTextButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.textSize = 16,
      this.buttonHeight = 50,
      this.buttonWidth = 125,
      this.backgroundColor = ColorConstant.primaryColor,
      this.textColor = ColorConstant.whiteColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          onPressed.call();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: backgroundColor,
          foregroundColor: ColorConstant.onPrimaryColor,
        ),
        child: CommonText(
          text: text,
          color: textColor,
          fontWeight: FontWeight.w500,
          size: textSize,
        ),
      ),
    );
  }
}
