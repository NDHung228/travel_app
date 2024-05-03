part of 'localization_bloc.dart';

sealed class LocalizationState extends Equatable {
  const LocalizationState();

  @override
  List<Object> get props => [];
}

final class LocalizationInitial extends LocalizationState {
}

// ignore: must_be_immutable
final class ChangeLocalization extends LocalizationState {
  String languageCode;

  ChangeLocalization(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
