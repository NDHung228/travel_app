import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travo_app/common_widgets/common_icon_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

class RoundTripScreen extends StatelessWidget {
  const RoundTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(children: [
          cardFrom(AppLocalizations.of(context)!.from, 'Jakarta',
              Icons.airplanemode_active_rounded),
          cardTo(
              AppLocalizations.of(context)!.to, 'Surabaya', Icons.location_on),
          cardDeparture(AppLocalizations.of(context)!.departure, AppLocalizations.of(context)!.select_date,
              Icons.date_range),
          cardReturn(AppLocalizations.of(context)!.return_date,AppLocalizations.of(context)!.select_date,
              Icons.date_range),
          cardPassengers(AppLocalizations.of(context)!.passengers,
              '1 Passenger', Icons.person),
          cardClass(AppLocalizations.of(context)!.passengers, 'Economy',
              Icons.class_),
          const SizedBox(
            height: 10,
          ),
          CommonTextButton(
            text: AppLocalizations.of(context)!.search,
            onPressed: () {},
            buttonWidth: double.infinity,
          )
        ]),
      ),
    );
  }

  Widget cardFrom(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CommonIcon(
                icon: icon,
                color: ColorConstant.primaryColor,
              ),
              Column(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardTo(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              Column(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 1),
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: ColorConstant.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              CommonIcon(
                icon: icon,
                color: ColorConstant.coralColor,
                size: 20,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget cardDeparture(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorConstant.coralColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: ColorConstant.coralColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cardReturn(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorConstant.coralColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: ColorConstant.coralColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cardPassengers(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorConstant.coralColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: ColorConstant.coralColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget cardClass(String title, String content, IconData icon) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: ColorConstant.tealColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              icon,
              color: ColorConstant.tealColor,
              size: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              CommonText(
                text: title,
                color: const Color(0xFF636363),
                size: 12,
              ),
              CommonText(
                text: content,
                fontWeight: FontWeight.w500,
                size: 15,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
