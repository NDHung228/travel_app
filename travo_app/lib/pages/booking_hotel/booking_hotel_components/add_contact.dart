import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_text_filed.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/validator_constant.dart';
import 'package:travo_app/models/contact_detail_model.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCases userRepository = AuthCases();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => SignInBloc(userRepo: userRepository),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CommonTopContainer(title: 'Contact Details', content: ''),
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
                        validator: ValidatorConstant.validateName,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CommonTextField(
                          controller: phoneController,
                          hintText: 'Phone Number',
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          validator: ValidatorConstant.validatePhone),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      CommonTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          validator: ValidatorConstant.validateEmail),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      CommonText(
                        text: 'E-ticket will be sent to your E-mail',
                        color: const Color(0xFF636363),
                        size: 10,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      BlocBuilder<SignInBloc, SignInState>(
                        builder: (context, state) {
                          return CommonTextButton(
                            text: 'Done',
                            onPressed: () {
                              final contactDetails = ContactDetail(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                              );
                              if (_formKey.currentState!.validate()) {
                                context.pop(contactDetails);
                              }
                            },
                            buttonWidth: width * 0.9,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
