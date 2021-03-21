import 'dart:convert';

/// {@template billingAddress}
/// Billing Address for PayMaya
/// [countryCode] only supports 'PH'.
///
/// Example:
/// ```dart
///   final billingAddress = PaymayaBillingAddress(
///     city: 'Davao City',
///     state: 'Davao del Sur',
///     zipCode: '8000',
///     countryCode: 'PH', /// Default value.
///   );
/// ```
/// {@endtemplate}
class PaymayaBillingAddress {
  ///{@macro billingAddress}
  const PaymayaBillingAddress({
    this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.zipCode,
    this.countryCode = 'PH',
  });

  ///{@macro billingAddress}
  factory PaymayaBillingAddress.fromMap(Map<String, dynamic> map) {
    return PaymayaBillingAddress(
      line1: map['line1'] ?? '',
      line2: map['line2'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      countryCode: map['countryCode'] ?? 'PH',
    );
  }

  ///{@macro billingAddress}
  factory PaymayaBillingAddress.fromJson(String source) =>
      PaymayaBillingAddress.fromMap(json.decode(source));

  ///
  final String? line1;

  ///
  final String? line2;

  ///
  final String city;

  /// Example: 'South Cotabato'
  final String state;

  /// Example:
  /// '9600' - Cotabato
  final String zipCode;

  /// Default value is 'PH'
  ///
  /// Paymaya doesn't support other countries yet.
  final String countryCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaBillingAddress &&
        other.line1 == line1 &&
        other.line2 == line2 &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return line1.hashCode ^
        line2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        countryCode.hashCode;
  }

  ///{@macro billingAddress}
  PaymayaBillingAddress copyWith({
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? zipCode,
    String? countryCode,
  }) {
    return PaymayaBillingAddress(
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  String toString() {
    return '''
    PaymayaBillingAddress(
      line1: $line1, 
      line2: $line2, 
      city: $city, 
      state: $state, 
      zipCode: $zipCode, 
      countryCode: $countryCode
      )
      ''';
  }

  /// {@macro billingAddress}
  /// Converts [PaymayaBillingAddress] to [Map]
  Map<String, dynamic> toMap() {
    return {
      'line1': line1,
      'line2': line2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'countryCode': countryCode,
    };
  }

  /// {@macro billingAddress}
  /// Converts [Map] to json.
  String toJson() => json.encode(toMap());
}
