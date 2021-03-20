import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:paymaya_flutter/paymaya_flutter.dart';

import 'amount.dart';
import 'redirect_url.dart';

class PaymayaSinglePayment {
  final PaymayaRedirectUrls redirectUrl;
  final SinglePaymentAmount totalAmount;
  final String requestReferenceNumber;
  final Map<String, dynamic> metadata;
  const PaymayaSinglePayment({
    required this.redirectUrl,
    required this.totalAmount,
    required this.requestReferenceNumber,
    this.metadata = const {},
  });

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
    return 'PaymayaSinglePayment(redirectUrl: $redirectUrl, totalAmount: $totalAmount, requestReferenceNumber: $requestReferenceNumber, metadata: $metadata)';
  }

  Map<String, dynamic> toMap() {
    return {
      'redirectUrl': redirectUrl.toMap(),
      'totalAmount': totalAmount.toMap(),
      'requestReferenceNumber': requestReferenceNumber,
      'metadata': metadata,
    };
  }

  factory PaymayaSinglePayment.fromMap(Map<String, dynamic> map) {
    return PaymayaSinglePayment(
      redirectUrl: PaymayaRedirectUrls.fromMap(map['redirectUrl']),
      totalAmount: SinglePaymentAmount.fromMap(map['totalAmount']),
      requestReferenceNumber: map['requestReferenceNumber'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaSinglePayment.fromJson(String source) =>
      PaymayaSinglePayment.fromMap(json.decode(source));
}
