part of 'payments_bloc.dart';

sealed class PaymentsState extends Equatable {
  const PaymentsState();
  
  @override
  List<Object> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsSuccess extends PaymentsState {}

class PaymentsError extends PaymentsState {
  final String message;

  const PaymentsError(this.message);
}
