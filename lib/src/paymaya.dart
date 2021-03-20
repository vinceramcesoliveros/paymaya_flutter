import 'dart:convert';
import 'package:http/http.dart';

import 'models/models.dart';

abstract class PayMayaSDK {
  factory PayMayaSDK.init(String publicKey, [bool isSandbox = true]) {
    return _PayMayaSDK(publicKey, isSandbox);
  }

  Future<String> genericRequestFn(
      {required Map<String, dynamic> requestBody, required String url}) {
    throw UnimplementedError("Initialize Paymaya SDK using PayMayaSDK.init");
  }

  void addTransactionHandler(
      Map<String, dynamic> event, void Function(String args) callback) {
    throw UnimplementedError('Initialize PayMaya SDK using PayMayaSDK.init');
  }

  Future<String> createCheckOut(PaymayaCheckout checkout) {
    throw UnimplementedError('Initialize PayMaya SDK using PayMayaSDK.init');
  }

  Future<String> createWalletLink(CreateWalletObject createWalletObject) {
    throw UnimplementedError('Initialize PayMaya SDK using PayMayaSDK.init');
  }

  Future<String> createSinglePayment(PaymayaSinglePayment createSinglePayment) {
    throw UnimplementedError('Initialize PayMaya SDK using PayMayaSDK.init');
  }

  Future<String> createCreditCardForm() {
    throw UnimplementedError('Initialize PayMaya SDK using PayMayaSDK.init');
  }
}

class _PayMayaSDK implements PayMayaSDK {
  late String apiUrl;
  late final String publicKey;
  late final bool isSandbox;
  late String formUrl;
  late String eventOrigin;
  _PayMayaSDK(
    this.publicKey,
    this.isSandbox,
  ) {
    if (this.isSandbox) {
      this.apiUrl = 'https://pg-sandbox.paymaya.com';
      this.formUrl =
          'https://paymayajs-staging.s3.amazonaws.com/dist/index.html';
      this.eventOrigin = 'https://paymayajs-staging.s3.amazonaws.com';
    } else {
      this.apiUrl = 'https://pg.paymaya.com';
      this.formUrl = 'https://paymayajs.s3.amazonaws.com/dist/index.html';
      this.eventOrigin = 'https://paymayajs.s3.amazonaws.com';
    }
  }

  void _checkIfInitialize() {
    if (publicKey == '' || apiUrl == '' || formUrl == '' || eventOrigin == '') {
      throw 'You must first run init() method!';
    }
  }

  @override
  Future<String> createCheckOut(PaymayaCheckout checkout) async {
    try {
      _checkIfInitialize();
      final body = checkout.toMap();
      final response = await genericRequestFn(
          requestBody: body, url: '/checkout/v1/checkouts');
      return response;
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
      throw e;
    }
  }

  @override
  Future<String> createCreditCardForm() {
    throw UnimplementedError();
  }

  @override
  Future<String> createSinglePayment(
      PaymayaSinglePayment createSinglePayment) async {
    try {
      _checkIfInitialize();
      final body = createSinglePayment.toMap();
      final response = await genericRequestFn(
        requestBody: body,
        url: '/payby/v2/paymaya/payments',
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> createWalletLink(CreateWalletObject createWalletObject) async {
    try {
      _checkIfInitialize();
      final response = await genericRequestFn(
          requestBody: createWalletObject.toMap(),
          url: '/payby/v2/paymaya/link');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> genericRequestFn(
      {required Map<String, dynamic> requestBody, required String url}) async {
    final _http = _PayMayaHttp(publicKey);
    final response = await _http.post(
      Uri.parse("$apiUrl$url"),
      body: jsonEncode(requestBody),
    );
    final json = jsonDecode(response.body);

    if (response.statusCode != 200 || json['redirectUrl'] == null) {
      throw json;
    }
    return json['redirectUrl'];
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
