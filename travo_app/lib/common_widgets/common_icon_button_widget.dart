import 'package:flutter/material.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double iconSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color color;

  const CommonIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.iconSize = 30,
    this.buttonHeight = 32,
    this.buttonWidth = 32,
    this.color = ColorConstant.blackColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Icon(
            icon,
            size: iconSize,
            color: color,
          ),
        ),
      ),
    );
  }
}
