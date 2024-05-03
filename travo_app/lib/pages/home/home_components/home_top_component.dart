import 'package:flutter/material.dart';

import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeTopComponent extends StatefulWidget {
  const HomeTopComponent({Key? key}) : super(key: key);

  @override
  State<HomeTopComponent> createState() => _HomeTopComponentState();
}

class _HomeTopComponentState extends State<HomeTopComponent> {
  final searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context);

    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Positioned(
          child: Container(
            height: height / 3.5,
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
              padding: EdgeInsets.symmetric(
                  vertical: height / 20, horizontal: width / 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: height / 40,
                      ),
                      Center(
                        child: CommonText(
                          text: AppLocalizations.of(context)!.hi,
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
                          text: l10n!.where_you_going,
                          color: ColorConstant.whiteColor,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: CommonIcon(
                              icon: Icons.notifications,
                              color: ColorConstant.whiteColor,
                              size: 20,
                            ),
                          ),
                          Positioned(
                            right: -8,
                            left: 0,
                            bottom: 10,
                            child: CommonIcon(
                              icon: Icons.circle,
                              size: 10,
                              color: ColorConstant.errorColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: width / 50,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: ColorConstant.whiteColor,
                        ),
                        child: Image.asset(ImageConstant.avatarImg),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: height / 4.3,
          left: width * 0.1,
          right: width * 0.1,
          child: CommonTextField(
            prefixIcon: const CommonIcon(
              icon: Icons.search,
              color: ColorConstant.blackColor,
            ),
            controller: searchController,
            hintText: 'Search your destination',
            obscureText: false,
            keyboardType: TextInputType.name,
          ),
        ),
      ],
    );
  }
}
