import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';

class RoomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(200); // Set your preferred height here

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: preferredSize.height, 
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
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
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

            SizedBox(width: width *0.15,),
            Center(
              child: CommonText(
                text: 'Select Room',
                color: ColorConstant.whiteColor,
                fontWeight: FontWeight.bold,
                size: 30,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
