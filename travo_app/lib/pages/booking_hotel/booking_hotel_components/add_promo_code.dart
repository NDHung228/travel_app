import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/promo_model.dart';
import 'package:travo_app/repo/promo_repo/promo_impl.dart';
import 'package:travo_app/repo/promo_repo/promo_repo.dart'; // Assuming you have a Promo model defined

class AddPromoCode extends StatefulWidget {
  const AddPromoCode({Key? key}) : super(key: key);

  @override
  State<AddPromoCode> createState() => _AddPromoCodeState();
}

class _AddPromoCodeState extends State<AddPromoCode> {
  final promoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final PromoRepository _promoService =
      PromoImplement(); // Instantiate the PromoService
  final ValueNotifier<Promo?> _promoInfoNotifier = ValueNotifier<Promo?>(null);
  bool _validateOnSubmit = true;

  String? validator(String? value) {
    if (_validateOnSubmit && (value == null || value.isEmpty)) {
      return 'Please enter a promo code';
    }

    if (_promoInfoNotifier.value == null && _validateOnSubmit) {
      return 'please enter correct promo code';
    }
    // Add additional validation logic if needed
    return null;
  }

  @override
  void dispose() {
    promoController.dispose();
    _promoInfoNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CommonTopContainer(title: 'Promo Code', content: ''),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  validator: validator,
                  // keyboardType: TextInputType,
                  controller: promoController,
                  decoration: InputDecoration(
                    labelText: 'Coupon Code',
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
                    suffixIcon: GestureDetector(
                      onTap: () async {
                        // Call the PromoService to check the promo code
                        _validateOnSubmit = false;

                        if (_formKey.currentState!.validate()) {
                          Promo? promo = await _promoService
                              .checkPromo(promoController.text);

                          _promoInfoNotifier.value = promo;
                        }
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ColorConstant.lavenderColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: CommonText(
                            text: 'Add Code',
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder<Promo?>(
                valueListenable: _promoInfoNotifier,
                builder: (context, promoInfo, _) {
                  if (promoInfo != null) {
                    return Column(
                      children: [
                        Image.network(promoInfo.image!),
                      ],
                    );
                  } else {
                    return const SizedBox(); // Placeholder when no promo info available
                  }
                },
              ),
              const SizedBox(height: 20),
              CommonTextButton(
                text: 'Done',
                onPressed: () {
                        _validateOnSubmit = true;

                  if (_formKey.currentState!.validate()) {
                    context.pop(_promoInfoNotifier.value!.price);
                  }
                },
                buttonWidth: width * 0.9,
              )
            ],
          ),
        ),
      ),
    );
  }
}
