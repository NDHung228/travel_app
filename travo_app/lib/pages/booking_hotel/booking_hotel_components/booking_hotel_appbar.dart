import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';

class BookingHotelAppBar extends StatelessWidget {
  final int index;
  const BookingHotelAppBar({Key? key, required this.index});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 4,
      width: width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImageConstant.backgroundImg,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: width * 0.05, top: height * 0.07),
        child: Column(
          children: [
            Row(
              children: [
                Navigator.canPop(context)
                    ? CommonIconButton(
                        color: const Color(0xFF232323),
                        icon: Icons.arrow_back,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : const SizedBox(),
                SizedBox(
                  width: width * 0.15,
                ),
                Center(
                  child: CommonText(
                    text: 'Check out',
                    color: ColorConstant.whiteColor,
                    fontWeight: FontWeight.bold,
                    size: 30,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            Row(
              children: [
                rowAppBar(1, 'Book and Review'),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  width: width * 0.05,
                  height: height * 0.0025,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                rowAppBar(2, 'Payment'),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  width: width * 0.05,
                  height: height * 0.0025,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    shape: BoxShape.rectangle,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                rowAppBar(3, 'Confirm')
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rowAppBar(int atIndex, String title) {
    return Row(
      children: [
        Container(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: index == atIndex ? ColorConstant.whiteColor : Colors.grey,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
              child: CommonText(
            text: '$atIndex',
            color: index == atIndex
                ? ColorConstant.primaryColor
                : ColorConstant.whiteColor,
            fontWeight: FontWeight.bold,
            size: 14,
          )),
        ),
        const SizedBox(
          width: 5,
        ),
        CommonText(
          text: title,
          color: ColorConstant.whiteColor,
          size: 12,
          fontWeight: index == atIndex ? FontWeight.bold : FontWeight.w400,
        ),
      ],
    );
  }
}
