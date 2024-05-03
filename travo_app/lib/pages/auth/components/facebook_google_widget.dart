import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class FacebookGoogleWidget extends StatelessWidget {
  const FacebookGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: ColorConstant.backgroundColor,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width / 2.5,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://www.google.com/s2/favicons?sz=64&domain=google.com',
                        height: 30.0,
                        width: 30.0,
                      ),
                      const SizedBox(width: 10),
                      CommonText(
                        size: 15,
                        text: 'Google',
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: width / 20),
              SizedBox(
                width: width / 2.5,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: Color(0xFF3C5A9A), // Background color for Facebook
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          10.0), // Adjust padding as needed
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(FontAwesomeIcons.facebookF,
                                  color: ColorConstant.whiteColor, size: 16.0)),
                          const SizedBox(width: 10),
                          CommonText(
                            size: 15,
                            text: 'Facebook',
                            color: ColorConstant.whiteColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
