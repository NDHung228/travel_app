import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

// ignore: must_be_immutable
class CommonText extends StatelessWidget {
  Color? color;
  final String text;
  final double size;
  final FontWeight fontWeight;
  double? height;

  CommonText(
      {super.key,
      this.color = ColorConstant.blackColor,
      required this.text,
      this.size = 14,
      this.fontWeight = FontWeight.w400,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.rubik(
        textStyle: TextStyle(
          decoration:  TextDecoration.none,
            color: color,
            fontWeight: fontWeight,
            fontSize: size,
            height: height),
      ),
    );
  }
}
