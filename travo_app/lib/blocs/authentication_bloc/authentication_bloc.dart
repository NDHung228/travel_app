import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travo_app/repo/auth_repo/auth_repo.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository userRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.userRepository})
      : super(AuthenticationInitial()) {
    _userSubscription = userRepository.user.listen((user) {
      print('check stream ${user  }');
      add(AuthenticationUserChanged(user));
    });

    on<AuthenticationUserChanged>((event, emit) {
      if (event.user != null) {
        emit(Authenticated(user: event.user));
      } else {
        emit(UnAuthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
