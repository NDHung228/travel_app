import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/localization_bloc/localization_bloc.dart';
import 'package:travo_app/blocs/theme_bloc/theme_bloc.dart';
import 'package:travo_app/routes/route_configure.dart';
import 'package:travo_app/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => LocalizationBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, stateTheme) {
          return BlocBuilder<LocalizationBloc, LocalizationState>(
            builder: (context, stateLocalization) {
              return MaterialApp.router(
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                locale: Locale((stateLocalization is ChangeLocalization)
                    ? stateLocalization.languageCode
                    : 'en'),
                supportedLocales: const [
                  Locale('en'),
                  Locale('vi'),
                  Locale('es')
                ],
                theme: lightMode,
                darkTheme: darkMode,
                themeMode: stateTheme,
                routerConfig: AppRoutes.routes,
                debugShowCheckedModeBanner: false,
              );
            },
          );
        },
      ),
    );
  }
}
