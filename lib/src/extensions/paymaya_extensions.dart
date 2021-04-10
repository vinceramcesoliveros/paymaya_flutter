import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymaya_flutter/src/widget/checkout_page.dart';

import '../../paymaya_flutter.dart';
import '../models/payment_status/payment_status.dart';

/// Extension to be used for flutter only
extension PayMayaExtension on PayMayaSDK {
  ///
  Future<PaymentStatus> checkoutPage(
      {required PaymayaCheckout checkout,
      required BuildContext context}) async {
    final result = await createCheckOut(checkout);
    final PaymentStatus status = await Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) {
        return PaymayaCheckoutPage(
          url: result.redirectUrl,
          redirectUrls: checkout.redirectUrl,
        );
      }),
    );

    return status;
  }

  ///
  Future<PaymentStatus> singlePaymentPage({
    required PaymayaSinglePayment singlePayment,
    required BuildContext context,
  }) async {
    final result = await createSinglePayment(singlePayment);
    final PaymentStatus status = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return PaymayaCheckoutPage(
            url: result.redirectUrl,
            redirectUrls: singlePayment.redirectUrl,
          );
        },
      ),
    );
    return status;
  }
}
