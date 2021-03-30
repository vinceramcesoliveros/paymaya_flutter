import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:paymaya_flutter/paymaya_flutter.dart';

import 'amount.dart';
import 'redirect_url.dart';

/// {@template singlepayment}
/// Single payment without the info of what the customer bought.
/// It is as simple pay money method for quick transactions.
/// ```dart
/// final payment = PaymayaSinglePayment(
///   redirectUrl: RedirectUrl(...),
///   totalAmount: SinglePaymentAmount(...),
///   requestReferenceNumber: '65593',
/// );
/// ```
/// {@endtemplate}
class PaymayaSinglePayment {
  /// {@macro singlepayment}
  const PaymayaSinglePayment({
    required this.redirectUrl,
    required this.totalAmount,
    required this.requestReferenceNumber,
    this.metadata = const {},
  });

  /// {@macro singlepayment}
  factory PaymayaSinglePayment.fromMap(Map<String, dynamic> map) {
    return PaymayaSinglePayment(
      redirectUrl: PaymayaRedirectUrls.fromMap(map['redirectUrl']),
      totalAmount: SinglePaymentAmount.fromMap(map['totalAmount']),
      requestReferenceNumber: map['requestReferenceNumber'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  /// {@macro singlepayment}
  factory PaymayaSinglePayment.fromJson(String source) =>
      PaymayaSinglePayment.fromMap(json.decode(source));

  /// your redirect urls
  final PaymayaRedirectUrls redirectUrl;

  /// total amount including currency and details
  final SinglePaymentAmount totalAmount;

  /// you request reference number.
  final String requestReferenceNumber;

  /// metadata for single payment
  final Map<String, dynamic> metadata;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaSinglePayment &&
        other.redirectUrl == redirectUrl &&
        other.totalAmount == totalAmount &&
        other.requestReferenceNumber == requestReferenceNumber &&
        mapEquals(other.metadata, metadata);
  }

  @override
  int get hashCode {
    return redirectUrl.hashCode ^
        totalAmount.hashCode ^
        requestReferenceNumber.hashCode ^
        metadata.hashCode;
  }

  /// {@macro singlepayment}
  PaymayaSinglePayment copyWith({
    PaymayaRedirectUrls? redirectUrl,
    SinglePaymentAmount? totalAmount,
    String? requestReferenceNumber,
    Map<String, dynamic>? metadata,
  }) {
    return PaymayaSinglePayment(
      redirectUrl: redirectUrl ?? this.redirectUrl,
      totalAmount: totalAmount ?? this.totalAmount,
      requestReferenceNumber:
          requestReferenceNumber ?? this.requestReferenceNumber,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  String toString() {
    return '''PaymayaSinglePayment(
      redirectUrl: $redirectUrl, 
      totalAmount: $totalAmount, 
      requestReferenceNumber: $requestReferenceNumber, 
      metadata: $metadata)''';
  }

  /// converts to [Map]
  Map<String, dynamic> toMap() {
    return {
      'redirectUrl': redirectUrl.toMap(),
      'totalAmount': totalAmount.toMap(),
      'requestReferenceNumber': requestReferenceNumber,
      'metadata': metadata,
    };
  }

  /// converts [Map] to [String] json
  String toJson() => json.encode(toMap());
}
