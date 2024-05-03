import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travo_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/country_phone_constant.dart';
import 'package:travo_app/constant/utils/validator_constant.dart';
import 'package:travo_app/models/user_model.dart';
import 'package:travo_app/pages/auth/components/facebook_google_widget.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/routes/route_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final countryController = TextEditingController(
      text: CountryPhoneConstant.countryToPhonePrefix.keys.first);
  final phoneController = TextEditingController(
      text: CountryPhoneConstant.countryToPhonePrefix.values.first);

  ValueNotifier<bool> isObscurePassword = ValueNotifier<bool>(true);
  String? _errorMsg;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    countryController.dispose();
    phoneController.dispose();
    isObscurePassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final AuthCases userRepository = AuthCases();

    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(userRepo: userRepository),
        child: Container(
          color: ColorConstant.backgroundColor,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 4.7,
                    child: const CommonTopContainer(
                        title: 'Sign Up',
                        content: 'Let\'s create your account!'),
                  ),
                  SizedBox(
                    height: height / 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CommonTextField(
                        controller: nameController,
                        hintText: 'Name',
                        obscureText: false,
                        keyboardType: TextInputType.name,
                        errorMsg: _errorMsg,
                        validator: ValidatorConstant.validateName),
                  ),
                  SizedBox(
                    height: height / 35,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        width: width * 0.85,
                        decoration: BoxDecoration(
                            color: ColorConstant
                                .whiteColor, // Set background color here
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: ColorConstant.whiteColor)),
                        child: DropdownMenu<String>(
                          controller: countryController,
                          width: width * 0.85,
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.bold),
                          label: const Text('Country'),
                          onSelected: (String? country) {
                            countryController.text = country!;
                            phoneController.text = CountryPhoneConstant
                                .countryToPhonePrefix[country]!;
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
                      )),
                  SizedBox(
                    height: height / 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CommonTextField(
                        controller: phoneController,
                        hintText: 'Phone Number',
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        errorMsg: _errorMsg,
                        validator: ValidatorConstant.validatePhone),
                  ),
                  SizedBox(
                    height: height / 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CommonTextField(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        errorMsg: _errorMsg,
                        validator: ValidatorConstant.validateEmail),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ValueListenableBuilder<bool>(
                        valueListenable: isObscurePassword,
                        builder: (context, bool value, Widget? child) {
                          return CommonTextField(
                              suffixIcon: ValueListenableBuilder<bool>(
                                valueListenable: isObscurePassword,
                                builder: (context, bool value, Widget? child) {
                                  return IconButton(
                                    onPressed: () {
                                      isObscurePassword.value = !value;
                                    },
                                    icon: isObscurePassword.value
                                        ? const Icon(
                                            CupertinoIcons.eye_slash_fill)
                                        : const Icon(CupertinoIcons.eye_fill),
                                    color: const Color.fromRGBO(0, 0, 0, 0.5),
                                  );
                                },
                              ),
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: isObscurePassword.value,
                              keyboardType: TextInputType.visiblePassword,
                              validator: ValidatorConstant.validatePass);
                        }),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      if (state is SignUpFailure) {
                        return Center(
                          child: CommonText(
                            text: state.errorMsg!,
                            color: ColorConstant.errorColor,
                            size: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              text: 'By continuing, you agree to our ',
                              style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                    color: ColorConstant.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 3),
                              ),
                              children: <TextSpan>[
                                textSpan('Terms and Condition',
                                    ColorConstant.primaryColor),
                                textSpan(' and ', ColorConstant.blackColor),
                                textSpan(' Privacy Policy',
                                    ColorConstant.primaryColor),
                                textSpan(
                                    ' of this app ', ColorConstant.blackColor),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        context.go(RoutName.homeRouteName);
                      }
                    },
                    builder: (context, state) {
                      return state is SignUpProcess
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CommonTextButton(
                                text: 'Sign Up',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    MyUser myUser = MyUser.empty;
                                    myUser = myUser.copyWith(
                                      email: emailController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      country: countryController.text,
                                    );
                                    context.read<SignUpBloc>().add(
                                          SignUpRequired(
                                            user: myUser,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                buttonWidth: width,
                                buttonHeight: 55,
                              ),
                            );
                    },
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: ColorConstant.blackColor,
                          ),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: CommonText(
                              text: 'or sign up with',
                            )),
                        const Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: ColorConstant.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 1000,
                  ),
                  SizedBox(
                    height: height / 10,
                    child: const FacebookGoogleWidget(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextSpan textSpan(String text, Color color) {
    return TextSpan(
      text: text,
      style: GoogleFonts.rubik(
        textStyle: TextStyle(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            height: 1.037),
      ),
    );
  }
}
