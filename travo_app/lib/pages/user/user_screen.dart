import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travo_app/blocs/localization_bloc/localization_bloc.dart';
import 'package:travo_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travo_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_app/common_widgets/common_bottom_navigation_bar.dart';
import 'package:travo_app/common_widgets/common_text_button_widget.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/models/language_model.dart'; // Import the LanguageModel
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/routes/route_name.dart';
import 'package:travo_app/services/user_service/user_services.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late final TextEditingController  countryController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countryController =
        TextEditingController(text: languageModel.first.language);
    if (context.read<LocalizationBloc>().state is ChangeLocalization) {
      String languageCode =
          (context.read<LocalizationBloc>().state as ChangeLocalization)
              .languageCode;
      countryController.text = UserServices.getLanguageFromCode(languageCode);
    }
  }

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthCases userRepository = AuthCases();
    var width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInBloc(userRepo: userRepository),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => LocalizationBloc(),
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            CommonTopContainer(
                title: AppLocalizations.of(context)!.account, content: ''),
            const SizedBox(
              height: 50,
            ),
            Switch(
              value: context.watch<ThemeBloc>().state == ThemeMode.dark,
              onChanged: (value) {
                context.read<ThemeBloc>().add(ThemeChanged(value));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: width * 0.85,
                decoration: BoxDecoration(
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ColorConstant.whiteColor),
                ),
                child: DropdownMenu<String>(
                  controller: countryController,
                  width: width * 0.85,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  label: Text(AppLocalizations.of(context)!.country),
                  onSelected: (String? country) {
                    countryController.text = country!;
                    final selectedLanguage = languageModel.firstWhere(
                      (lang) => lang.language == country,
                      orElse: () => languageModel.first,
                    );

                    context
                        .read<LocalizationBloc>()
                        .add(UpdateLocalization(selectedLanguage.languageCode));
                  },
                  dropdownMenuEntries: languageModel
                      .map<DropdownMenuEntry<String>>(
                        (language) => DropdownMenuEntry<String>(
                          value: language.language,
                          label: language.language,
                          enabled: language.language != 'Grey',
                          style: MenuItemButton.styleFrom(),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Center(
              child: BlocBuilder<SignInBloc, SignInState>(
                builder: (context, state) {
                  return CommonTextButton(
                    text: 'Log out',
                    onPressed: () {
                      context.read<SignInBloc>().add(const SignOutRequired());
                      context.go(RoutName.homeRouteName);
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CommonBottomNavigationBar(index: 3),
      ),
    );
  }
}
