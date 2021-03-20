import 'dart:convert';

import 'details.dart';

class PaymayaAmount {
  const PaymayaAmount({
    this.currency,
    required this.value,
    this.details,
  });
  final String? currency;
  final num value;
  final PaymayaDetails? details;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaAmount &&
        other.currency == currency &&
        other.value == value &&
        other.details == details;
  }

  @override
  int get hashCode => currency.hashCode ^ value.hashCode ^ details.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'value': value,
      'details': details?.toMap(),
    };
  }

  factory PaymayaAmount.fromMap(Map<String, dynamic> map) {
    return PaymayaAmount(
      currency: map['currency'],
      value: map['value'] ?? 0,
      details: PaymayaDetails.fromMap(map['details']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaAmount.fromJson(String source) =>
      PaymayaAmount.fromMap(json.decode(source));

  PaymayaAmount copyWith({
    String? currency,
    num? value,
    PaymayaDetails? details,
  }) {
    return PaymayaAmount(
      currency: currency ?? this.currency,
      value: value ?? this.value,
      details: details ?? this.details,
    );
  }

  @override
  String toString() =>
      'PaymayaAmount(currency: $currency, value: $value, details: $details)';
}
