import 'dart:convert';

import 'billing_address.dart';

class PaymayaShippingAddress implements PaymayaBillingAddress {
  final String? phone;
  final String email;
  final String shippingType;

  // Billing Address

  final String firstName;
  final String lastName;
  final String middleName;
  final String? line1;
  final String? lin2;
  final String city;
  final String state;
  final String zipCode;
  final String countryCode;
  PaymayaShippingAddress({
    this.phone,
    required this.email,
    required this.shippingType,
    required this.firstName,
    required this.lastName,
    required this.middleName,
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

    return other is PaymayaShippingAddress &&
        other.phone == phone &&
        other.email == email &&
        other.shippingType == shippingType &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.middleName == middleName &&
        other.line1 == line1 &&
        other.lin2 == lin2 &&
        other.city == city &&
        other.state == state &&
        other.zipCode == zipCode &&
        other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return phone.hashCode ^
        email.hashCode ^
        shippingType.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        middleName.hashCode ^
        line1.hashCode ^
        lin2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        countryCode.hashCode;
  }

  @override
  String toString() {
    return 'PaymayaShippingAddress(firstName: $firstName, lastName: $lastName, middleName: $middleName, phone: $phone, email: $email, shippingType: $shippingType, line1: $line1, lin2: $lin2, city: $city, state: $state, zipCode: $zipCode, countryCode: $countryCode)';
  }

  PaymayaShippingAddress copyWith({
    String? phone,
    String? email,
    String? shippingType,
    String? firstName,
    String? lastName,
    String? middleName,
    String? line1,
    String? lin2,
    String? city,
    String? state,
    String? zipCode,
    String? countryCode,
  }) {
    return PaymayaShippingAddress(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      shippingType: shippingType ?? this.shippingType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      line1: line1 ?? this.line1,
      lin2: lin2 ?? this.lin2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'shippingType': shippingType,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'line1': line1,
      'lin2': lin2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'countryCode': countryCode,
    };
  }

  factory PaymayaShippingAddress.fromMap(Map<String, dynamic> map) {
    return PaymayaShippingAddress(
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      shippingType: map['shippingType'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      middleName: map['middleName'] ?? '',
      line1: map['line1'] ?? '',
      lin2: map['lin2'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      countryCode: map['countryCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaShippingAddress.fromJson(String source) =>
      PaymayaShippingAddress.fromMap(json.decode(source));
}
