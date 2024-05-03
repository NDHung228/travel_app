import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/country_phone_constant.dart';
import 'package:travo_app/constant/utils/image_constant.dart';
import 'package:travo_app/models/card_model.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final dateController = TextEditingController();
  final cvvController = TextEditingController();
  final countryController = TextEditingController(
      text: CountryPhoneConstant.countryToPhonePrefix.keys.first);
  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    dateController.dispose();
    cvvController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CommonTopContainer(title: 'Add Card', content: ''),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: width * 0.1, vertical: height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: cardNumberController,
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            const BorderSide(color: ColorConstant.whiteColor),
                      ),
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: ColorConstant
                                .lavenderColor, // Customize the color as needed
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Image.asset(ImageConstant.visaImg),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.4,
                        child: CommonTextField(
                          controller: dateController,
                          hintText: 'Exp. Date',
                          obscureText: false,
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.1,
                      ),
                      SizedBox(
                        width: width * 0.3,
                        child: CommonTextField(
                          controller: cvvController,
                          hintText: 'CVV',
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.85,
                    decoration: BoxDecoration(
                        color: ColorConstant
                            .whiteColor, // Set background color here
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: ColorConstant.whiteColor)),
                    child: DropdownMenu<String>(
                      controller: countryController,
                      width: width * 0.85,
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      label: const Text('Country'),
                      onSelected: (String? country) {
                        countryController.text = country!;
                      },
                      dropdownMenuEntries: CountryPhoneConstant
                          .countryToPhonePrefix.keys
                          .map<DropdownMenuEntry<String>>(
                        (String country) {
                          return DropdownMenuEntry<String>(
                            value: country,
                            label: country,
                            enabled: country != 'Grey',
                            style: MenuItemButton.styleFrom(
                                // foregroundColor: ColorConstant.whiteColor,
                                ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  CommonTextButton(
                    text: 'Add Card',
                    onPressed: () {
                      CardModel card = CardModel(
                        name: nameController.text,
                        cardNumber: cardNumberController.text,
                        date: dateController.text,
                        cvv: cvvController.text,
                        country: countryController.text,
                      );

                      context.pop(card);
                    },
                    buttonWidth: width * 0.9,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
