import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';

class CommonTopContainer extends StatelessWidget {
  final String title;
  final String content;

  const CommonTopContainer({
    super.key,
    required this.title,
    required this.content,
  });

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
          ), // Replace with your image asset
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(right: width / 1.3, top: height / 20),
            child: Navigator.canPop(context)
                ? CommonIconButton(
                    color: const Color(0xFF232323),
                    icon: Icons.arrow_back,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : const SizedBox(),
          ),
          SizedBox(
            height: height / 40,
          ),
          Center(
            child: CommonText(
              text: title,
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.bold,
              size: 30,
            ),
          ),
          SizedBox(
            height: height / 50,
          ),
          Center(
            child: CommonText(
              text: content,
              color: ColorConstant.whiteColor,
              size: 14,
            ),
          ),
        ],
      ),
    );
  }
}
