import 'package:flutter/material.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final VoidCallback? onPressed;

  const CommonIcon(
      {Key? key,
      required this.icon,
      this.color = ColorConstant.blackColor,
      this.size = 16,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: size,
      icon: Icon(
        icon,
        color: color,
      ),
    );
  }
}
