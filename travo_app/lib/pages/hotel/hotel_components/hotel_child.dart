import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HotelChild extends StatelessWidget {
  final Hotel hotel;
  const HotelChild({
    super.key,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final l10n = AppLocalizations.of(context);

    return Card(
      child: Column(children: [
        Stack(children: [
          GestureDetector(
            onTap: () {},
            child: CachedNetworkImage(
              imageUrl: hotel.image,
              fit: BoxFit.fill,
              placeholder: (context, url) => AspectRatio(
                aspectRatio: (640) / 480,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.favorite,
                  color: ColorConstant.whiteColor,
                )),
          ),
        ]),
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.05),
          child: CommonText(
            text: hotel.name,
            size: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            const Icon(
              Icons.location_on,
              color: Color(0xFFF77777),
            ),
            CommonText(
              text: ' ${hotel.location} -',
              size: 12,
              color: Color(0xFF313131),
            ),
            Expanded(
              child: CommonText(
                text: '${hotel.location_description}',
                size: 10,
                color: Colors.grey,
              ),
            )
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            const Icon(
              Icons.star,
              color: Color(0xFFFFC107),
            ),
            CommonText(
              text: '${hotel.rating} ',
              size: 12,
              color: const Color(0xFF313131),
            ),
            CommonText(
              text: '(${hotel.total_review} reviews)',
              size: 12,
              color: Colors.grey,
            ),
            const SizedBox(width: 150),
            InkWell(
              onTap: () {
                context.push(RoutName.reviewHotel,extra: hotel.hotelId );
              },
              child: CommonText(
                text: l10n!.see_all,
                color: ColorConstant.tealColor,
              ),
            )
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.1),
          child: Row(
            children: [
              for (int i = 0; i < width / 22; i++) // Creates 5 squares
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  width: width * 0.025, // Adjust width and height as needed
                  height: height * 0.0025,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E5E5),
                    shape: BoxShape.rectangle, // Use rectangle for squares
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          children: [
            SizedBox(
              width: width * 0.05,
            ),
            Column(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      const WidgetSpan(
                        child: Icon(
                          Icons.attach_money,
                          color: Color(0xFF313131),
                          size: 24,
                        ),
                      ),
                      TextSpan(
                        text: '${hotel.price}',
                        style: const TextStyle(
                          color: Color(0xFF313131),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                CommonText(text: '/night')
              ],
            ),
            SizedBox(
              width: width * 0.2,
            ),
            CommonTextButton(
                text: 'Book a room',
                onPressed: () {
                  context.push(RoutName.detailHotelRouteName, extra: hotel);
                },
                buttonWidth: width * 0.35,
                textSize: 15),
          ],
        ),
        SizedBox(
          height: height * 0.02,
        ),
      ]),
    );
  }
}
