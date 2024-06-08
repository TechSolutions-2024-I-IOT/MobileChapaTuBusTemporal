part of 'payments_bloc.dart';

sealed class PaymentsEvent extends Equatable {
  const PaymentsEvent();

  @override
  List<Object> get props => [];
}

class AddCreditCardEvent extends PaymentsEvent {
  final CreditCard creditCard;

  const AddCreditCardEvent(this.creditCard);
}
