import 'dart:convert';

class PaymayaBillingAddress {
  final String? line1;
  final String? lin2;
  final String city;
  final String state;
  final String zipCode;
  final String countryCode;
  PaymayaBillingAddress({
    this.line1,
    this.lin2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.countryCode,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaBillingAddress &&
        other.line1 == line1 &&
        other.lin2 == lin2 &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return line1.hashCode ^
        lin2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        countryCode.hashCode;
  }

  PaymayaBillingAddress copyWith({
    String? line1,
    String? lin2,
    String? city,
    String? state,
    String? zipCode,
    String? countryCode,
  }) {
    return PaymayaBillingAddress(
      line1: line1 ?? this.line1,
      lin2: lin2 ?? this.lin2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  String toString() {
    return 'PaymayaBillingAddress(line1: $line1, lin2: $lin2, city: $city, state: $state, zipCode: $zipCode, countryCode: $countryCode)';
  }

  Map<String, dynamic> toMap() {
    return {
      'line1': line1,
      'lin2': lin2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'countryCode': countryCode,
    };
  }

  factory PaymayaBillingAddress.fromMap(Map<String, dynamic> map) {
    return PaymayaBillingAddress(
      line1: map['line1'] ?? '',
      lin2: map['lin2'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      countryCode: map['countryCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaBillingAddress.fromJson(String source) =>
      PaymayaBillingAddress.fromMap(json.decode(source));
}
