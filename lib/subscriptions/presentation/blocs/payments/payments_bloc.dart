import 'package:bloc/bloc.dart';
import 'package:chapa_tu_bus_app/subscriptions/domain/entities/credit_card.dart';
import 'package:chapa_tu_bus_app/subscriptions/infrastructure/repositories/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final PaymentRepository _paymentRepository;

  PaymentsBloc(this._paymentRepository) : super(PaymentsInitial()) {
    on<AddCreditCardEvent>((event, emit) async {
      emit(PaymentsLoading());
      try {
        await _paymentRepository.addCreditCard(event.creditCard);
        emit(PaymentsSuccess());
      } catch (e) {
        emit(PaymentsError(e.toString()));
      }
    });
  }
}