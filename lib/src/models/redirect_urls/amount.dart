import 'dart:convert';

import 'package:flutter/foundation.dart';

class SinglePaymentAmount {
  final String currency;
  final String value;
  final Map<String, dynamic>? metadata;
  SinglePaymentAmount({
    required this.currency,
    required this.value,
    this.metadata,
  });

  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'value': value,
      'metadata': metadata,
    };
  }

  factory SinglePaymentAmount.fromMap(Map<String, dynamic> map) {
    return SinglePaymentAmount(
      currency: map['currency'] ?? '',
      value: map['value'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory SinglePaymentAmount.fromJson(String source) =>
      SinglePaymentAmount.fromMap(json.decode(source));

  SinglePaymentAmount copyWith({
    String? currency,
    String? value,
    Map<String, dynamic>? metadata,
  }) {
    return SinglePaymentAmount(
      currency: currency ?? this.currency,
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
  String toString() =>
      'SinglePaymentAmount(currency: $currency, value: $value, metadata: $metadata)';
}
