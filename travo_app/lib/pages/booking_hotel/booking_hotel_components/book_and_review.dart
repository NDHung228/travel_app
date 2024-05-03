import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_contact_detail.dart';
import 'package:travo_app/common_widgets/common_promo_code.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/booking_hotel_model.dart';
import 'package:travo_app/models/contact_detail_model.dart';
import 'package:travo_app/models/room_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_date.dart';
import 'package:travo_app/pages/room/room_components.dart/room_child.dart';
import 'package:travo_app/routes/route_name.dart';

class BookAndReview extends StatefulWidget {
  final Room room;
  const BookAndReview({Key? key, required this.room}) : super(key: key);

  @override
  State<BookAndReview> createState() => _BookAndReviewState();
}

class _BookAndReviewState extends State<BookAndReview> {
  late final ValueNotifier<List<ContactDetail>> _listContactNotifier;
  late final ValueNotifier<DateTime?> _startDateNotifier;
  late final ValueNotifier<DateTime?> _endDateNotifier;
  BookingHotel bookingHotel = BookingHotel();
  late final ValueNotifier<String?> _promoCodeNotifier;

  @override
  void initState() {
    _listContactNotifier = ValueNotifier<List<ContactDetail>>([]);
    _startDateNotifier = ValueNotifier<DateTime?>(null);
    _endDateNotifier = ValueNotifier<DateTime?>(null);
    _promoCodeNotifier = ValueNotifier<String>('');
    super.initState();
  }

  @override
  void dispose() {
    _listContactNotifier.dispose();
    _startDateNotifier.dispose();
    _endDateNotifier.dispose();
    _promoCodeNotifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: height * 0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RoomChild(
              room: widget.room,
              checkout: true,
            ),
            childOfBookAndReview(
              Icons.person,
              ColorConstant.primaryColor,
              'Contact Details',
              'Add Contact',
              height,
              width,
              () async {
                ContactDetail? dataContact =
                    await context.push(RoutName.addContactRouteName);
                if (dataContact != null) {
                  _listContactNotifier.value = [
                    ..._listContactNotifier.value,
                    dataContact
                  ];
                }
              },
              true,
              _listContactNotifier,
            ),
            childOfBookAndReview(
              Icons.percent_rounded,
              ColorConstant.coralColor,
              'Promo Code',
              'Add Promo Code',
              height,
              width,
              () async {
                double? promoCode =
                    await context.push(RoutName.addPromoCodeRouteName);
                if (promoCode != null) {
                  _promoCodeNotifier.value =
                      (promoCode * 100).toInt().toString() + '%';
                  bookingHotel.promo_code = promoCode;
                }
              },
              false,
              _listContactNotifier,
            ),
            Card(
              child: BookingDate(
                  startDateNotifier: _startDateNotifier,
                  endDateNotifier: _endDateNotifier),
            ),
            SizedBox(height: height * 0.05),
            CommonTextButton(
              text: 'Payment',
              onPressed: () {
                bookingHotel.date_start = _startDateNotifier.value!.toString();
                bookingHotel.date_end = _endDateNotifier.value!.toString();
                bookingHotel.hotel = widget.room.hotelId;
                bookingHotel.guest = _listContactNotifier.value;
                bookingHotel.room = widget.room.roomId;

                context.push(RoutName.paymentRouteName, extra: bookingHotel);
              },
              buttonWidth: width * 0.9,
            ),
            SizedBox(height: height * 0.05),
          ],
        ),
      ),
    );
  }

  Card childOfBookAndReview(
    IconData icon,
    Color colorIcon,
    String title,
    String content,
    double height,
    double width,
    VoidCallback onTap,
    bool contact,
    ValueNotifier<List<ContactDetail>> listContactNotifier,
  ) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.01),
            Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: colorIcon.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(
                    icon,
                    color: colorIcon,
                  ),
                ),
                const SizedBox(width: 20),
                CommonText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: height * 0.03),
            contact
                ? ValueListenableBuilder<List<ContactDetail>>(
                    valueListenable: listContactNotifier,
                    builder: (context, listContact, _) {
                      return Column(
                        children: listContact
                            .map((contactDetail) => CommonContactDetail(
                                contactDetail: contactDetail))
                            .toList(),
                      );
                    },
                  )
                : ValueListenableBuilder<String?>(
                    valueListenable: _promoCodeNotifier,
                    builder: (context, promoCode, _) {
                      return CommonPromoCode(
                        promoCode: promoCode,
                      );
                    },
                  ),
            SizedBox(height: height * 0.01),
            Container(
              height: 50,
              width: width * 0.6,
              decoration: BoxDecoration(
                color: ColorConstant.lavenderColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorConstant.whiteColor,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    CommonText(
                      text: content,
                      color: ColorConstant.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * 0.03),
          ],
        ),
      ),
    );
  }
}
