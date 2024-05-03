import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travo_app/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:travo_app/blocs/list_payment/list_payment_bloc.dart';
import 'package:travo_app/blocs/room_bloc/room_bloc.dart';
import 'package:travo_app/common_widgets/common_bottom_navigation_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travo_app/common_widgets/common_top_container_widget.dart';
import 'package:travo_app/common_widgets/skeleton.dart';
import 'package:travo_app/pages/list_payment/list_payment_components/list_payment_flight.dart';
import 'package:travo_app/pages/list_payment/list_payment_components/list_payment_room.dart';
import 'package:travo_app/repo/auth_repo/auth_cases.dart';

class ListPaymentScreen extends StatefulWidget {
  const ListPaymentScreen({super.key});

  @override
  State<ListPaymentScreen> createState() => _ListPaymentScreenState();
}

class _ListPaymentScreenState extends State<ListPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(userRepository: AuthCases()),
        ),
        BlocProvider(
          create: (context) => ListPaymentBloc(),
        ),
      ],
      child: const ListPayment(),
    );
  }
}

class ListPayment extends StatefulWidget {
  const ListPayment({super.key});

  @override
  State<ListPayment> createState() => _ListPaymentState();
}

class _ListPaymentState extends State<ListPayment>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final email;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabSelection);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (_tabController.index == 1) {
      context.read<ListPaymentBloc>().add(GetListPaymentFlightRequired(email));
    } else {
      context.read<ListPaymentBloc>().add(GetListPaymentRoomRequired(email));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Authenticated) {
            email = state.user!.email!;
            context
                .read<ListPaymentBloc>()
                .add(GetListPaymentRoomRequired(email));

            return Column(
              children: [
                CommonTopContainer(
                    title: AppLocalizations.of(context)!.payment, content: ''),
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: l10n!.room),
                    Tab(text: l10n.flight),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      BlocBuilder<ListPaymentBloc, ListPaymentState>(
                        builder: (context, state) {
                          if (state is ListPaymentRoomLoaded) {
                            return BlocProvider(
                              create: (context) => RoomBloc(),
                              child: ListPaymentRoom(
                                listBookingRoom: state.bookingHotel,
                              ),
                            );
                          }

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Skeleton(
                                  height: 300,
                                  width: 300,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // list payment flight
                      BlocBuilder<ListPaymentBloc, ListPaymentState>(
                        builder: (context, state) {
                          if (state is ListPaymentFlightLoaded) {
                            return BlocProvider(
                                create: (context) => RoomBloc(),
                                child: ListPaymentFlight(
                                  listBookingFlight: state.listBookingFlight,
                                ));
                          }

                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Skeleton(
                                  height: 300,
                                  width: 300,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: const CommonBottomNavigationBar(
        index: 2,
      ),
    );
  }
}
