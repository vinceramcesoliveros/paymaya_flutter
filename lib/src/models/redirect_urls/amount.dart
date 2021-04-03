import 'dart:convert';

import 'package:flutter/foundation.dart';

/// {@template singlepayment}
/// Not identical with PaymayaAmount.
///
/// This was intended for SinglePayment method which uses
/// the value as [String] instead of [num]
/// {@endtemplate}
class SinglePaymentAmount {
  ///{@macro singlepayment}
  const SinglePaymentAmount({
    this.currency = 'PHP',
    required this.value,
    this.metadata,
  });

  /// {@macro singlepayment}
  ///
  /// Converts [Map] to [SinglePaymentAmount]
  factory SinglePaymentAmount.fromMap(Map<String, dynamic> map) {
    return SinglePaymentAmount(
      currency: map['currency'] ?? 'PHP',
      value: map['value'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  /// {@macro singlepayment}
  /// Converts [String] to [SinglePaymentAmount]
  factory SinglePaymentAmount.fromJson(String source) =>
      SinglePaymentAmount.fromMap(json.decode(source));

  /// Currency defaults to 'PH'
  final String? currency;

  /// Total Amount of items
  final String value;

  /// See properties [here](https://s3-us-west-2.amazonaws.com/developers.paymaya.com.pg/pay-by-paymaya/index.html#features)
  final Map<String, dynamic>? metadata;

  /// {@macro singlepayment}
  ///
  /// Converts [SinglePaymentAmount] to [Map]
  Map<String, dynamic> toMap() {
    return {
      'currency': currency ?? 'PHP',
      'value': value,
      'metadata': metadata,
    };
  }

  /// {@macro singlepayment}
  /// Converts [Map] to [String]
  String toJson() => json.encode(toMap());

  ///{@macro singlepayment}
  SinglePaymentAmount copyWith({
    String? currency,
    String? value,
    Map<String, dynamic>? metadata,
  }) {
    return SinglePaymentAmount(
      currency: currency ?? this.currency ?? 'PHP',
      value: value ?? this.value,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SinglePaymentAmount &&
        other.currency == currency &&
        other.value == value &&
        mapEquals(other.metadata, metadata);
  }

  @override
  int get hashCode => currency.hashCode ^ value.hashCode ^ metadata.hashCode;

  @override
  String toString() => '''SinglePaymentAmount(
        currency: $currency, 
        value: $value, 
        metadata: $metadata
        )
        ''';
}
