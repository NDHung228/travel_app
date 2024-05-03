import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/booking_flight_model.dart';
import 'package:travo_app/pages/booking_hotel/booking_hotel_components/booking_hotel_appbar.dart';
import 'package:travo_app/routes/route_name.dart';

class PaymentFlightScreen extends StatelessWidget {
  final BookingFlight bookingFlight;
  const PaymentFlightScreen({super.key, required this.bookingFlight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BookingHotelAppBar(
            index: 2,
          ),
          paymentBody(context)
        ],
      ),
    );
  }

  Widget paymentBody(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final ValueNotifier<String> typePayment = ValueNotifier('');

    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20, top: height * 0.2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            miniMarket(height, width, typePayment),
            SizedBox(
              height: height * 0.02,
            ),
            credit(height, width, typePayment, () {
              context.push(RoutName.addCardRouteName);
            }),
            SizedBox(
              height: height * 0.02,
            ),
            bankTransfer(height, width, typePayment),
            SizedBox(
              height: height * 0.02,
            ),
            CommonTextButton(
              text: 'Done',
              onPressed: () {
                bookingFlight.typePayment = typePayment.value;

                context.push(RoutName.confirmFlight, extra: bookingFlight);
              },
              buttonWidth: width * 0.9,
            )
          ],
        ),
      ),
    );
  }

  Card miniMarket(
      double height, double width, ValueNotifier<String> typePayment) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: InkWell(
          onTap: () {
            typePayment.value = 'Mini Market';
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFF77777).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.store,
                    size: 20,
                    color: Color(0xFFF77777),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.1,
              ),
              CommonText(
                text: 'Mini Market',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: width * 0.25,
              ),
              ValueListenableBuilder<String>(
                valueListenable: typePayment,
                builder: (context, value, child) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: value == 'Mini Market'
                          ? Colors.green
                          : ColorConstant.lavenderColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card credit(double height, double width, ValueNotifier<String> typePayment,
      VoidCallback onTap) {
    return Card(
      child: InkWell(
        onTap: () {
          typePayment.value = 'Credit / Debit Card';
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.01,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF77777).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.store,
                        size: 20,
                        color: Color(0xFFF77777),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.1,
                  ),
                  CommonText(
                    text: 'Credit / Debit Card',
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    width: width * 0.13,
                  ),
                  ValueListenableBuilder<String>(
                    valueListenable: typePayment,
                    builder: (context, value, child) {
                      return Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: value == 'Credit / Debit Card'
                              ? Colors.green
                              : ColorConstant.lavenderColor,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: width * 0.4,
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
                        text: 'Add Card',
                        color: ColorConstant.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card bankTransfer(
      double height, double width, ValueNotifier<String> typePayment) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.01,
        ),
        child: InkWell(
          onTap: () {
            typePayment.value = 'Bank Transfer';
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ColorConstant.tealColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: const Center(
                  child: Icon(
                    Icons.account_balance,
                    size: 20,
                    color: ColorConstant.tealColor,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.1,
              ),
              CommonText(
                text: 'Bank Transfer',
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                width: width * 0.22,
              ),
              ValueListenableBuilder<String>(
                valueListenable: typePayment,
                builder: (context, value, child) {
                  return Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: value == 'Bank Transfer'
                          ? Colors.green
                          : ColorConstant.lavenderColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
