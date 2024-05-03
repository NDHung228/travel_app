import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';

import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/validator_constant.dart';
import 'package:travo_app/pages/auth/components/facebook_google_widget.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/routes/route_name.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  ValueNotifier<bool> isObscurePassword = ValueNotifier<bool>(true);
  ValueNotifier<bool> isSavePass = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    isObscurePassword.dispose();
    isSavePass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final AuthCases userRepository = AuthCases();

    return Scaffold(
      body: Container(
        color: ColorConstant.backgroundColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocProvider(
              create: (context) => SignInBloc(userRepo: userRepository),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 4.7,
                    child: const CommonTopContainer(
                        title: 'Login', content: 'Hi,Welcome back'),
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
                      validator: ValidatorConstant.validateEmail,
                    ),
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
                    height: height / 80,
                  ),
                  BlocBuilder<SignInBloc, SignInState>(
                    builder: (context, state) {
                      if (state is SignInFailure) {
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
                    height: height / 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder<bool>(
                            valueListenable: isSavePass,
                            builder: (context, bool value, Widget? child) {
                              return GestureDetector(
                                onTap: () {
                                  isSavePass.value = !isSavePass.value;
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      value: isSavePass.value,
                                      onChanged: (value) {
                                        isSavePass.value = !isSavePass.value;
                                      },
                                      activeColor: ColorConstant.whiteColor,
                                    ),
                                    CommonText(
                                        text: 'Remember me',
                                        size: 14,
                                        height: 1.037),
                                  ],
                                ),
                              );
                            }),
                        TextButton(
                          onPressed: () {
                            context.push(RoutName.forgotPasswordRouteName);
                          },
                          child: CommonText(
                              text: 'Forgot password?',
                              size: 14,
                              height: 1.037),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<SignInBloc, SignInState>(
                      builder: (context, state) {
                        return state is SignInProcess
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CommonTextButton(
                                text: 'Log In',
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<SignInBloc>().add(
                                        SignInRequired(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            isSavePass: isSavePass.value));
                                  }
                                },
                                buttonWidth: width,
                                buttonHeight: 55,
                              );
                      },
                    ),
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
                              text: 'or log in with',
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
                    height: height / 10,
                    child: const FacebookGoogleWidget(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText(
                            text: 'Don\'t have an account?',
                            size: 14,
                            height: 1.037),
                        GestureDetector(
                          onTap: () {
                            context.push(RoutName.signUpRouteName);
                          },
                          child: CommonText(
                            text: ' Sign Up',
                            color: ColorConstant.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
