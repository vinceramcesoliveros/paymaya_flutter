import 'package:paymaya_flutter/paymaya_flutter.dart';

import 'constants.dart';

const _amount = SinglePaymentAmount(value: '700', currency: 'PHP');
const singlePayment = PaymayaSinglePayment(
  redirectUrl: redirectUrl,
  totalAmount: _amount,
  requestReferenceNumber: requestReferenceNumber,
);
