part of 'list_payment_bloc.dart';

sealed class ListPaymentEvent extends Equatable {
  const ListPaymentEvent();

  @override
  List<Object> get props => [];
}

final class GetListPaymentRoomRequired extends ListPaymentEvent {
  final String email;

  const GetListPaymentRoomRequired(this.email);
} 

final class GetListPaymentFlightRequired extends ListPaymentEvent {
  final String email;

  const GetListPaymentFlightRequired(this.email);
}


