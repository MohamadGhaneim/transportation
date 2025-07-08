import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:transportation/pages/payment/payment_intent.dart';

Future<bool> makePayment(int trip_id ,double amount) async {
  try {
    final clientSecret = await createPaymentIntent( trip_id , (amount * 100).toInt());
    if (clientSecret == null) return false;

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Smart Bus',
      ),
    );

    await Stripe.instance.presentPaymentSheet();
    
    return true;
  } catch (e) {
    print("Payment failed: $e");
    return false;
  }
}
