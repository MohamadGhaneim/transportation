import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:transportation/pages/payment/payment_intent.dart';

Future<bool> makePayment(double amount) async {
  try {
    final clientSecret = await createPaymentIntent(amount * 100);
    if (clientSecret == null) return false;

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Smart Bus',
      ),
    );

    await Stripe.instance.presentPaymentSheet();
    print("Payment successful");
    return true;
  } catch (e) {
    print("Payment failed: $e");
    return false;
  }
}
