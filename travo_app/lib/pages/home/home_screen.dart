import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:travo_app/blocs/place_bloc/place_bloc.dart';
import 'package:travo_app/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:travo_app/common_widgets/common_bottom_navigation_bar.dart';
import 'package:travo_app/common_widgets/common_text_widget.dart';
import 'package:travo_app/constant/utils/color_constant.dart';
import 'package:travo_app/pages/auth/sign_in_screen.dart';
import 'package:travo_app/pages/home/home_components/home_body_component.dart';
import 'package:travo_app/pages/home/home_components/home_front_component.dart';
import 'package:travo_app/pages/home/home_components/home_top_component.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';
import 'package:travo_app/repo/place_repo/place_impl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AuthCases userRepository = AuthCases();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepository),
        ),
        BlocProvider(
          create: (context) => SignInBloc(userRepo: userRepository),
        ),
      ],
      child: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    var width = MediaQuery.of(context).size.width;
    final PlaceImplement placeImplement = PlaceImplement();

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: BlocProvider.value(
                  value: context.read<AuthenticationBloc>(),
                  child: const HomeTopComponent(),
                )),
                const SliverToBoxAdapter(child: HomeFrontComponent()),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  sliver: SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CommonText(
                          text: l10n!.popular_destination,
                          size: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        CommonText(
                          text: l10n.see_all,
                          color: ColorConstant.indigoColor,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    BlocProvider(
                      create: (context) =>
                          PlaceBloc(placeImPlaceImplement: placeImplement),
                      child: const HomeBodyComponent(),
                    ),
                  ]),
                ),
              ],
            ),
            bottomNavigationBar: const CommonBottomNavigationBar(index: 0),
          );
        } else if (state is UnAuthenticated) {
          return const SignInScreen();
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
