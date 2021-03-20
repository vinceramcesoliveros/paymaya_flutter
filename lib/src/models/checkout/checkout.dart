import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../amount/amount.dart';
import '../buyer/buyers.dart';
import '../item/item.dart';
import '../redirect_urls/redirect_url.dart';

class PaymayaCheckout {
  final PaymayaAmount totalAmount;
  final PaymayaBuyer buyer;
  final List<PaymayaItem> items;
  final PaymayaRedirectUrls redirectUrl;
  final String requestReferenceNumber;
  final Map<String, Object>? metadata;
  PaymayaCheckout({
    required this.totalAmount,
    required this.buyer,
    required this.items,
    required this.redirectUrl,
    required this.requestReferenceNumber,
    this.metadata,
  });
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
    return 'PaymayaCheckout(totalAmount: $totalAmount, buyer: $buyer, items: $items, redirectUrl: $redirectUrl, requestReferenceNumber: $requestReferenceNumber, metadata: $metadata)';
  }

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

  String toJson() => json.encode(toMap());

  factory PaymayaCheckout.fromJson(String source) =>
      PaymayaCheckout.fromMap(json.decode(source));

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
}
