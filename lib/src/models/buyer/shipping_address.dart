import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'billing_address.dart';

/// Paymaya Shipping type
enum ShippingType {
  /// Standard
  st,

  /// Same Day
  sd
}

ShippingType _shippingtype(String type) {
  if (type == 'ST') {
    return ShippingType.st;
  }
  return ShippingType.sd;
}

///{@template shipping}
/// Example:
/// Extended class of [PaymayaBillingAddress].
/// ```dart
/// final shippingAddress = PaymayaShippingAddress(
///   phone:'09123456789',
///   email:'paymaya@flutter.com',
///   shippingType: Shippingtype.st, // Standard
///   firstName: 'John'
///   middleName: 'Birb',
///   lastName: 'Doe',
///   line1: '123-4567',
///   line2: '456-789',
///   city: 'Davao City',
///   state: 'Davao del Sur',
///   zipCode: 8000,
///   countryCode: 'PH', /// Default value is set to 'PH'
/// );
/// ```
///{@endtemplate}
class PaymayaShippingAddress {
  /// {@macro shipping}
  const PaymayaShippingAddress({
    this.phone,
    required this.email,
    this.shippingType = ShippingType.st,
    required this.firstName,
    required this.lastName,
    required this.middleName,
    this.line1,
    this.line2,
    required this.city,
    required this.state,
    required this.zipCode,
    this.countryCode = 'PH',
  });

  ///{@macro shipping}
  factory PaymayaShippingAddress.fromMap(Map<String, dynamic> map) {
    return PaymayaShippingAddress(
      phone: map['phone'],
      email: map['email'] ?? '',
      shippingType: _shippingtype(map['shippingType'] as String),
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      middleName: map['middleName'] ?? '',
      line1: map['line1'],
      line2: map['line2'],
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      zipCode: map['zipCode'] ?? '',
      countryCode: map['countryCode'] ?? '',
    );
  }

  ///{@macro shipping}
  factory PaymayaShippingAddress.fromJson(String source) =>
      PaymayaShippingAddress.fromMap(json.decode(source));

  /// Autovalidated by PayMaya API. Feel free to validate at your own.
  final String? phone;

  /// Autovalidated by PayMaya API. Feel free to validate at your own.
  final String email;

  /// **ST** - Standard
  ///
  /// **SD** - Same Day
  final ShippingType shippingType;

  // Billing Address

  /// first name of the buyer
  final String firstName;

  /// last name of the buyer
  final String lastName;

  /// middle name of the buyer
  final String middleName;

  /// optional [line1] value.
  final String? line1;

  /// optional [line2] value
  final String? line2;

  /// Buyer City
  final String city;

  /// Buyer State
  final String state;

  /// Buyer zipCode
  final String zipCode;

  /// Buyer countryCode
  final String countryCode;

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
        other.line2 == line2 &&
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
        line2.hashCode ^
        city.hashCode ^
        state.hashCode ^
        zipCode.hashCode ^
        countryCode.hashCode;
  }

  @override
  String toString() {
    return '''PaymayaShippingAddress(
      phone: $phone, 
      email: $email, 
      shippingType: $shippingType, 
      firstName: $firstName, 
      lastName: $lastName, 
      middleName: $middleName, 
      line1: $line1, 
      line2: $line2, 
      city: $city, 
      state: $state, 
      zipCode: $zipCode, 
      countryCode: $countryCode
      )
      ''';
  }

  ///{@macro shipping}
  PaymayaShippingAddress copyWith({
    String? phone,
    String? email,
    ShippingType? shippingType,
    String? firstName,
    String? lastName,
    String? middleName,
    String? line1,
    String? line2,
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
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  ///{@macro shipping}
  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'email': email,
      'shippingType': describeEnum(shippingType).toUpperCase(),
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'line1': line1,
      'line2': line2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'countryCode': countryCode,
    };
  }

  ///{@macro shipping}
  String toJson() => json.encode(toMap());
}
