import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class CommonPromoCode extends StatelessWidget {
  final String? promoCode;
  const CommonPromoCode({super.key, this.promoCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorConstant.lavenderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [CommonText(text: 'Promo Code : ${promoCode}')],
            ),
          ],
        ),
      ),
    );
  }
}
