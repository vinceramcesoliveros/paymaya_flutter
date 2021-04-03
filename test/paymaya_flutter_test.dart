import 'package:flutter_test/flutter_test.dart';
import 'package:paymaya_flutter/paymaya_flutter.dart';
import 'package:paymaya_flutter/src/models/response/response.dart';

import 'fixtures/checkout.dart';
import 'fixtures/constants.dart';
import 'fixtures/single_payment.dart';

void main() {
  PayMayaSDK? sdk;
  group('Not initialized', () {
    setUp(() {
      /// SDK was not initialized;
      sdk = PayMayaSDK.init('');
    });
    test('Throws error when not initialize', () {
      expect(
        () async => await sdk?.createCheckOut(checkout),
        throwsArgumentError,
      );
      expect(() async => await sdk?.createSinglePayment(singlePayment),
          throwsArgumentError);
    });

    tearDown(() {
      sdk = null;
    });
  });
  group('Checkout Initialized', () {
    setUp(() {
      // public key for checkout
      sdk = PayMayaSDK.init(checkoutPublicKey);
    });
    test('Create checkout', () async {
      final response = await sdk?.createCheckOut(checkout);
      expect(
        response,
        isA<PaymayaResponse>(),
        reason: 'Success payment may differ from the response api.',
      );
    });
    test('Create Wallet Link', () {});
  });
  tearDown(() {
    sdk = null;
  });
  group('SinglePayment Initialized', () {
    setUpAll(() {
      sdk = PayMayaSDK.init(singlePaymentKey);
    });
    test('Single Payment', () async {
      final result = await sdk?.createSinglePayment(singlePayment);
      expect(result, isA<PaymayaResponse>());
    });

    tearDown(() {
      sdk = null;
    });
  });

  tearDownAll(() {
    sdk = null;
  });
}
