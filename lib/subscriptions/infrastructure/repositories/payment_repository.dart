import 'package:chapa_tu_bus_app/subscriptions/domain/entities/credit_card.dart';

class PaymentRepository {
  Future<void> addCreditCard(CreditCard creditCard) async {
    // Implement your logic to add the credit card to your data source
    // (e.g., database, API, etc.)
    await Future.delayed(const Duration(seconds: 1));
    print('Credit card added: ${creditCard.cardNumberHidden}');
  }
}