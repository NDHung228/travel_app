import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/common_widgets/common_icon_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/hotel.model.dart';
import 'package:travo_app/routes/route_name.dart';

class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailScreen({Key? key, required this.hotel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
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
          top: 50,
          right: 20,
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: width * 0.1,
              height: height * 0.05,
              decoration: BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.favorite,
                color: Color(0xFFF5DCDC),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
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
        DraggableScrollableSheet(
          initialChildSize: 0.75,
          minChildSize: 0.05,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: ColorConstant.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.35, vertical: height * 0.025),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 75,
                          height: 5,
                          decoration: const BoxDecoration(
                            color: ColorConstant.blackColor,
                            shape:
                                BoxShape.rectangle, // Use rectangle for squares
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: hotel.name,
                            size: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Color(0xFF313131),
                                size: 24,
                              ),
                              CommonText(
                                text: hotel.price.toString(),
                                size: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              CommonText(
                                text: '/night',
                                size: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFFF77777),
                          ),
                          Expanded(
                            child: CommonText(
                              text: ' ${hotel.location}',
                              size: 12,
                              color: Color(0xFF313131),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.005),
                        child: Row(
                          children: [
                            for (int i = 0; i < width / 17; i++)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                width: width *
                                    0.025, // Adjust width and height as needed
                                height: height * 0.0025,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5E5E5),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Row(
                        children: [
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
                          SizedBox(
                            width: width * 0.5,
                          ),
                          CommonText(
                            text: 'See All',
                            color: ColorConstant.indigoColor,
                            size: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: width * 0.005),
                        child: Row(
                          children: [
                            for (int i = 0; i < width / 17; i++)
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                width: width *
                                    0.025, // Adjust width and height as needed
                                height: height * 0.0025,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE5E5E5),
                                  shape: BoxShape.rectangle,
                                ),
                              ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      CommonText(
                        text: 'Information',
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      CommonText(
                        text: hotel.information,
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          childOfInf(
                              'Restaurant',
                              const Icon(Icons.restaurant_menu_outlined),
                              ColorConstant.primaryColor),
                          childOfInf('Wifi', Icon(Icons.wifi),
                              const Color(0xFFFF9C57)),
                          childOfInf(
                              'Currency Exchange',
                              const Icon(Icons.currency_exchange_outlined),
                              const Color(0xFFF97674)),
                          childOfInf(
                              '24-hour Front Desk',
                              const Icon(Icons.desk_rounded),
                              const Color(0xFF34C9BD)),
                          childOfInf('More', const Icon(Icons.more_horiz),
                              const Color(0xFF2D3143))
                        ],
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      CommonText(
                        text: 'Location',
                        size: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      CommonText(
                        text: hotel.location_description,
                        size: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: height * 0.009,
                      ),
                      Image.asset(
                        ImageConstant.mapImg,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BlocProvider(
                        create: (context) => RoomBloc(),
                        child: CommonTextButton(
                          text: 'Select Room',
                          onPressed: () {

                            context.push(RoutName.roomRouteName,extra: hotel.hotelId);
                          },
                          buttonWidth: width * 0.9,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget childOfInf(String text, Icon icon, Color color) {
    return Expanded(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon.icon,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11.0),
            child: CommonText(
              text: text,
              size: 10,
            ),
          ),
        ],
      ),
    );
  }
}
