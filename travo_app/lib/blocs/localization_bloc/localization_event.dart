part of 'localization_bloc.dart';

sealed class LocalizationEvent extends Equatable {
  const LocalizationEvent();

  @override
  List<Object> get props => [];
}


class UpdateLocalization extends LocalizationEvent {
  final String languageCode;
  const UpdateLocalization(this.languageCode);

    @override
  List<Object> get props => [languageCode];
}