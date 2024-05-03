import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/routes/route_name.dart';

class RoomChild extends StatelessWidget {
  final Room room;
  final bool checkout;
  const RoomChild({Key? key, required this.room, this.checkout = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.05, vertical: height * 0.01),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: room.name,
                      size: 20,
                      fontWeight: FontWeight.w500,
                    ),
                    CommonText(text: 'Room Size: 30 m2 '),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    CommonText(text: room.typePrice)
                  ],
                ),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set the desired border radius here
                    child: CachedNetworkImage(
                      imageUrl: room.image,
                      fit: BoxFit.fill,
                      placeholder: (context, url) => AspectRatio(
                        aspectRatio: (640) / 480,
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            services(),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              children: [
                for (int i = 0; i < width / 14; i++)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    width: width * 0.02,
                    height: height * 0.0025,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE5E5E5),
                      shape: BoxShape.rectangle,
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                            text: '${room.price}',
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
                checkout
                    ? CommonText(text: '1 room')
                    : CommonTextButton(
                        text: 'Choose',
                        onPressed: () {
                          context.push(RoutName.bookingHotelRouteName,
                              extra: room);
                        },
                        buttonWidth: width * 0.35,
                        textSize: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget services() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: room.services.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: ColorConstant.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      getIconForService(room.services[index]),
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: CommonText(
                    text: room.services[index],
                    size: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData getIconForService(String service) {
    switch (service) {
      case 'Free Wifi':
        return Icons.wifi;
      case 'Non Refundable':
        return Icons.block;
      case 'Free Breakfast':
        return Icons.free_breakfast;
      case 'Non Smoking':
        return Icons.smoking_rooms;
      default:
        return Icons.info; // Default icon if service is not recognized
    }
  }
}
