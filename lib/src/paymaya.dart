import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'models/models.dart';
import 'models/payment_status/payment_status.dart';
import 'widget/checkout_page.dart';
import 'widget/single_payment_page.dart';

final _argumentError =
    ArgumentError('Initialize PayMaya SDK using PayMayaSDK.init');

/// {@template paymayasdk}
///z
/// This SDK is a mirror of [PayMayaSDK-JS](https://github.com/PayMaya/PayMaya-JS-SDK-v2).
///
/// The author chose this because other SDK uses WebView and that is not ideal
/// for this package.
///
/// Example:
///
/// ```dart
///
/// final paymayaSdk = PayMayaSDK.init('pk-5123sdas', isSandbox: true);
/// ```
/// {@endtemplate}
abstract class PayMayaSDK {
  /// {@macro paymayasdk}
  /// This method initializes SDK.
  /// It must be run before other methods.
  ///
  /// Throws [ArgumentError] when invoking other methods
  /// without running `init()`.
  /// If you want to customize your authentication process.
  /// you can pass `http` as your client and have different implementation.
  /// ```dart
  /// class _PayMayaHttp extends BaseClient {
  ///   _PayMayaHttp(this.publicKey);
  ///   final String publicKey;
  ///   final Client _client = Client();
  ///   @override
  ///   Future<StreamedResponse> send(BaseRequest request) {
  ///     final bytes = utf8.encode(publicKey);
  ///     final base64Str = base64.encode(bytes);
  ///    final headers = {
  ///       'Content-Type': 'application/json',
  ///       'Authorization': 'Basic $base64Str',
  ///     };
  ///     request.headers.addAll(headers);
  ///     return _client.send(request);
  ///   }
  /// }
  /// ```
  ///

  factory PayMayaSDK.init(
    String publicKey, {
    bool isSandbox = true,
    BaseClient? http,
  }) {
    return _PayMayaSDK(publicKey, isSandbox, http);
  }

  ///
  bool get hasPublicKey => false;

  /// Use this to request request link from PayMaya API.
  /// Be sure to read the documentation
  /// [here](https://s3-us-west-2.amazonaws.com/developers.paymaya.com.pg/pay-by-paymaya/index.html#basic-authorization)
  @visibleForTesting
  Future<Map<String, dynamic>> genericRequestFn(
      {required Map<String, dynamic> requestBody, required String url}) {
    throw ArgumentError('Initialize Paymaya SDK using PayMayaSDK.init');
  }

  /// ### Warning: THIS WILL ONLY WORK ON WEB
  /// This method assigns a listener for credit card form method
  /// [createdCreditCardForm]
  /// - whenever the user fills all the information required
  /// (cvc, credit card number and expiry date) and then tokenizes that data,
  /// a `callback` will be fired with payment token.
  @visibleForTesting
  void addTransactionHandler(
      Map<String, dynamic> event, void Function(String args) callback) {
    throw ArgumentError('Initialize PayMaya SDK using PayMayaSDK.init');
  }

  /// Consider using [navigateToCheckout] for easier integration.
  ///
  /// This method redirects the user to PayMaya Checkout, where the user can
  /// finalize his/her payment.
  ///
  /// This method returns a url which you will have to use whatever technique
  /// you can use(url_launcher, webview, or iframe).
  Future<PaymayaResponse> createCheckOut(PaymayaCheckout checkout) {
    throw _argumentError;
  }

  /// creates a wallet link
  /// that allows charging to a PayMaya account.
  Future<PaymayaResponse> createWalletLink(
      CreateWalletObject createWalletObject) {
    throw _argumentError;
  }

  /// creates a single payment redirection,
  /// allowing the user to finalize the transaction.
  Future<PaymayaResponse> createSinglePayment(
      PaymayaSinglePayment createSinglePayment) {
    throw _argumentError;
  }

  /// ### Not suitable for production. IF you have suggestions, give us a PR.
  /// should only be called when it navigates to a new page
  /// and fills up the credit card form.
  @visibleForTesting
  Future<String> createdCreditCardForm() {
    throw _argumentError;
  }

  /// Processes your transaction automatically
  /// to use this in all platforms, consider doing this.
  ///
  Future<PaymentStatus> navigateToCheckout(
      BuildContext context, PaymayaCheckout checkout) {
    throw _argumentError;
  }

  /// Handles your payment automatically.
  ///
  Future<PaymentStatus> navigateToPayment(
      BuildContext context, PaymayaSinglePayment checkout) {
    throw ArgumentError('Initialize PayMaya SDK using PayMayaSDK.init');
  }
}

class _PayMayaSDK implements PayMayaSDK {
  _PayMayaSDK(
    this.publicKey,
    this.isSandbox,
    BaseClient? http,
  ) {
    _http = http ?? _PayMayaHttp(publicKey);
    if (isSandbox) {
      apiUrl = 'https://pg-sandbox.paymaya.com';
      formUrl = 'https://paymayajs-staging.s3.amazonaws.com/dist/index.html';
      eventOrigin = 'https://paymayajs-staging.s3.amazonaws.com';
    } else {
      apiUrl = 'https://pg.paymaya.com';
      formUrl = 'https://paymayajs.s3.amazonaws.com/dist/index.html';
      eventOrigin = 'https://paymayajs.s3.amazonaws.com';
    }
  }

  late String apiUrl;
  late final String publicKey;
  late final bool isSandbox;
  late String formUrl;
  late String eventOrigin;
  late BaseClient _http;
  void _checkIfInitialize() {
    if ((publicKey.isEmpty)) {
      throw ArgumentError('Public Key must not be empty');
    }
  }

  @override
  Future<Map<String, dynamic>> genericRequestFn(
      {required Map<String, dynamic> requestBody, required String url}) async {
    final response = await _http.post(
      Uri.parse('$apiUrl$url'),
      body: jsonEncode(requestBody),
    );
    final Map<String, dynamic> json = jsonDecode(response.body);
    print(json);
    if (response.statusCode != 200 || json['redirectUrl'] == null) {
      throw Exception(json.toString());
    }
    return json;
  }

  @override
  Future<PaymayaResponse> createCheckOut(PaymayaCheckout checkout) async {
    try {
      _checkIfInitialize();
      final body = checkout.toMap();
      final response = await genericRequestFn(
          requestBody: body, url: '/checkout/v1/checkouts');
      return PaymayaResponse.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void addTransactionHandler(
      Map<String, dynamic> event, void Function(String args) callback) async {
    try {
      _checkIfInitialize();
      if (event['origin'] == eventOrigin) {
        final json = jsonDecode(event['data']);
        callback(json['paymentTokenid']);
      }
    } catch (e) {
      throw ArgumentError(e);
    }
  }

  @override
  Future<String> createdCreditCardForm() {
    throw ArgumentError();
  }

  @override
  Future<PaymayaResponse> createSinglePayment(
      PaymayaSinglePayment createSinglePayment) async {
    try {
      _checkIfInitialize();
      final body = createSinglePayment.toMap();
      final response = await genericRequestFn(
        requestBody: body,
        url: '/payby/v2/paymaya/payments',
      );
      return PaymayaResponse.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaymayaResponse> createWalletLink(
      CreateWalletObject createWalletObject) async {
    try {
      _checkIfInitialize();
      final response = await genericRequestFn(
          requestBody: createWalletObject.toMap(),
          url: '/payby/v2/paymaya/link');
      return PaymayaResponse.fromMap(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  bool get hasPublicKey => publicKey.isNotEmpty;

  @override
  Future<PaymentStatus> navigateToCheckout(
      BuildContext context, PaymayaCheckout checkout) async {
    final response = await createCheckOut(checkout);
    final PaymentStatus status = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return PaymayaCheckoutPage(
            url: response.redirectUrl,
            redirectUrls: checkout.redirectUrl,
          );
        },
      ),
    );
    return status;
  }

  @override
  Future<PaymentStatus> navigateToPayment(
      BuildContext context, PaymayaSinglePayment singlePayment) async {
    final response = await createSinglePayment(singlePayment);
    final PaymentStatus status = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) {
          return PaymayaSinglePaymentPage(
            url: response.redirectUrl,
            redirectUrls: singlePayment.redirectUrl,
          );
        },
      ),
    );
    return status;
  }
}

class _PayMayaHttp extends BaseClient {
  _PayMayaHttp(this.publicKey);
  final String publicKey;
  final Client _client = Client();

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    final bytes = utf8.encode(publicKey);
    final base64Str = base64.encode(bytes);

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic $base64Str',
    };
    request.headers.addAll(headers);
    return _client.send(request);
  }
}
