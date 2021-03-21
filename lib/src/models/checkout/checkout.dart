import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../amount/amount.dart';
import '../buyer/buyers.dart';
import '../item/item.dart';
import '../redirect_urls/redirect_url.dart';

/// {@template checkout}
/// Paymaya single checkout object
/// Example:
/// ```dart
///   final checkout = PaymayaCheckout(
///     totalAmount: totalAmount,
///     buyer: buyer,
///     items: items,
///     redirectUrl: redirectUrls, /// success,failure,cancel
///     requestReferenceNumber: requestReferenceNumber,
///     metadata: {},
///   );
/// ```
/// {@endtemplate}
class PaymayaCheckout {
  ///{@macro checkout}
  const PaymayaCheckout({
    required this.totalAmount,
    required this.buyer,
    required this.items,
    required this.redirectUrl,
    required this.requestReferenceNumber,
    this.metadata,
  });

  ///{@macro checkout}
  factory PaymayaCheckout.fromMap(Map<String, dynamic> map) {
    return PaymayaCheckout(
      totalAmount: PaymayaAmount.fromMap(map['totalAmount']),
      buyer: PaymayaBuyer.fromMap(map['buyer']),
      items: List<PaymayaItem>.from(
          map['items']?.map((x) => PaymayaItem.fromMap(x)) ?? const []),
      redirectUrl: PaymayaRedirectUrls.fromMap(map['redirectUrl']),
      requestReferenceNumber: map['requestReferenceNumber'] ?? '',
      metadata: Map<String, Object>.from(map['metadata'] ?? const {}),
    );
  }

  ///{@macro checkout}
  factory PaymayaCheckout.fromJson(String source) =>
      PaymayaCheckout.fromMap(json.decode(source));

  /// {@macro checkout}
  PaymayaCheckout copyWith({
    PaymayaAmount? totalAmount,
    PaymayaBuyer? buyer,
    List<PaymayaItem>? items,
    PaymayaRedirectUrls? redirectUrl,
    String? requestReferenceNumber,
    Map<String, Object>? metadata,
  }) {
    return PaymayaCheckout(
      totalAmount: totalAmount ?? this.totalAmount,
      buyer: buyer ?? this.buyer,
      items: items ?? this.items,
      redirectUrl: redirectUrl ?? this.redirectUrl,
      requestReferenceNumber:
          requestReferenceNumber ?? this.requestReferenceNumber,
      metadata: metadata ?? this.metadata,
    );
  }

  ///Checkout total amount
  final PaymayaAmount totalAmount;

  /// Checkout Buyer info
  final PaymayaBuyer buyer;

  /// Checkout Items.
  ///
  /// See [PaymayaItem] for details.
  final List<PaymayaItem> items;

  /// Your redirect url to be sent in paymaya
  /// and receive its transaction status.
  final PaymayaRedirectUrls redirectUrl;

  /// the [requestReferenceNumber] is a secret number provided by PayMaya
  final String requestReferenceNumber;

  /// Other metadata fields are found
  /// [here](https://s3-us-west-2.amazonaws.com/developers.paymaya.com.pg/pay-by-paymaya/index.html#features)
  /// This field is subject for discussion whether it will be a dart object
  /// or just a [Map] variable.
  final Map<String, Object>? metadata;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaCheckout &&
        other.totalAmount == totalAmount &&
        other.buyer == buyer &&
        listEquals(other.items, items) &&
        other.redirectUrl == redirectUrl &&
        other.requestReferenceNumber == requestReferenceNumber &&
        mapEquals(other.metadata, metadata);
  }

  @override
  int get hashCode {
    return totalAmount.hashCode ^
        buyer.hashCode ^
        items.hashCode ^
        redirectUrl.hashCode ^
        requestReferenceNumber.hashCode ^
        metadata.hashCode;
  }

  @override
  String toString() {
    return '''PaymayaCheckout(
      totalAmount: $totalAmount, 
      buyer: $buyer, 
      items: $items, 
      redirectUrl: $redirectUrl, 
      requestReferenceNumber: $requestReferenceNumber, 
      metadata: $metadata
      )
      ''';
  }

  ///{@macro checkout}
  /// converts [PaymayaCheckout] to [Map]
  Map<String, dynamic> toMap() {
    return {
      'totalAmount': totalAmount.toMap(),
      'buyer': buyer.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'redirectUrl': redirectUrl.toMap(),
      'requestReferenceNumber': requestReferenceNumber,
      'metadata': metadata,
    };
  }

  ///{@macro checkout}
  String toJson() => json.encode(toMap());
}
