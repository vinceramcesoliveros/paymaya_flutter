import 'dart:convert';

import 'details.dart';

/// {@template PaymayaAmount}
///
/// A Payment set to be calculated but not including [PaymayaDetails].
///
/// The [PaymayaDetails] is optional from the API docs.
/// But is relevant if you want to invoice these transactions
/// when you request to PayMaya.
///
///
/// {@endtemplate}
class PaymayaAmount {
  ///{@macro PaymayaAmount}
  const PaymayaAmount({
    this.currency = 'PHP',
    required this.value,
    this.details,
  });

  /// Converts [map] to [PaymayaAmount]'s Instance
  ///
  /// {@macro PaymayaAmount}
  factory PaymayaAmount.fromMap(Map<String, dynamic> map) {
    return PaymayaAmount(
      currency: map['currency'],
      value: map['value'] ?? 0,
      details: PaymayaDetails.fromMap(map['details']),
    );
  }

  /// Converts [source] to [PaymayaAmount]'s Instance
  ///
  /// {@macro PaymayaAmount}
  factory PaymayaAmount.fromJson(String source) =>
      PaymayaAmount.fromMap(json.decode(source));

  ///Replaces the current instance to a new instance with the same properties
  ///
  /// {@macro PaymayaAmount}
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

  /// The [currency] was planned to be an enum. but PayMaya only supports
  /// PHP as their standard.
  ///
  /// You can read it [here](https://enterprisehelp.paymaya.com/s/article/What-currencies-are-supported-by-PayMaya-Checkout)
  final String? currency;

  /// The [value] is set to num so that either int or double will be included
  /// since it will be parsed as json objects.
  final num value;

  /// The [details] are optional, but when it is instantiated,
  /// the properties will be required but can be set their values to 0.
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

  /// Converts [PaymayaAmount] to map
  Map<String, dynamic> toMap() {
    return {
      'currency': currency,
      'value': value,
      'details': details?.toMap(),
    };
  }

  /// Converts json of Amount to [PaymayaAmount].
  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PaymayaAmount(currency: $currency, value: $value, details: $details)';
}
