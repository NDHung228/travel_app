import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/forgot_password_bloc/forgot_password_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/constant/utils/validator_constant.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/routes/route_name.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final AuthCases userRepository = AuthCases();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: ColorConstant.backgroundColor,
            child: BlocProvider(
              create: (context) => ForgotPasswordBloc(userRepo: userRepository),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height / 4.7,
                    child: const CommonTopContainer(
                        title: 'Forgot ',
                        content:
                            'You’ll get messages soon on your e-mail address'),
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
                        validator: ValidatorConstant.validateEmail),
                  ),
                  SizedBox(
                    height: height / 80,
                  ),
                  BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                    builder: (context, state) {
                      if (state is ForgotPasswordFailure) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:
                        BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text('Please check your email'),
                          ));
                          context.push(RoutName.signInRouteName);
                        }
                      },
                      builder: (context, state) {
                        return state is ForgotPasswordProcess
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CommonTextButton(
                                text: 'Send',
                                onPressed: () {
                                  // Dispatch ForgotPasswordRequired event
                                  context
                                      .read<ForgotPasswordBloc>()
                                      .add(ForgotPasswordRequired(
                                        email: emailController.text,
                                      ));
                                },
                                buttonWidth: width,
                                buttonHeight: 55,
                              );
                      },
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
