import 'package:flutter/material.dart';
import 'package:travo_app/common_widgets/common_icon_text.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/contact_detail_model.dart';

class CommonContactDetail extends StatelessWidget {
  final ContactDetail contactDetail;
  const CommonContactDetail({super.key, required this.contactDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorConstant.lavenderColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            CommonIconText(
                icon: Icons.person, title: 'Name', content: contactDetail.name),
            CommonIconText(
                icon: Icons.phone,
                title: 'Phone Number',
                content: contactDetail.phone),
            CommonIconText(
                icon: Icons.email,
                title: 'Email',
                content: contactDetail.email),
          ],
        ),
      ),
    );
  }
}
