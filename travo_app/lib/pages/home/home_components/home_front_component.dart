import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/pages/home/home_components/home_front_widget.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeFrontComponent extends StatelessWidget {
  const HomeFrontComponent({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context);

    // listview generate
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.1, vertical: height * 0.05),
      child: Row(
        children: [
          HomeFrontWidget(
            imgUrl: ImageConstant.hotelsImg,
            title: 
            l10n!.hotel,
            color: ColorConstant.coralColor,
            onPressed: () {
              context.push(RoutName.hotelRouteName);
            },
          ),
          SizedBox(
            width: width * 0.05,
          ),
          HomeFrontWidget(
            imgUrl: ImageConstant.flightsImg,
            title: l10n.flight,
            color: ColorConstant.salmonColor,
            onPressed: () {
              context.push(RoutName.searchBookingFlightRouteName);
            },
          ),
          SizedBox(
            width: width * 0.05,
          ),
          HomeFrontWidget(
            imgUrl: ImageConstant.allImg,
            title: l10n.all,
            color: ColorConstant.tealColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
