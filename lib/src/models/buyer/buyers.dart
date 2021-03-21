import 'dart:convert';

import 'billing_address.dart';
import 'contact.dart';
import 'shipping_address.dart';

/// {@template buyer}
/// The [PaymayaBuyer] will be inserted after the redirect url
/// response.
///
/// {@endtemplate}
class PaymayaBuyer {
  //// {@macro buyer}
  const PaymayaBuyer({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthday,
    required this.customerSince,
    this.sex,
    required this.contact,
    required this.shippingAddress,
    required this.billingAddress,
  });

  /// {@macro buyer}
  factory PaymayaBuyer.fromMap(Map<String, dynamic> map) {
    return PaymayaBuyer(
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      birthday: map['birthday'] ?? '',
      customerSince: map['customerSince'] ?? '',
      sex: map['sex'],
      contact: PaymayaContact.fromMap(map['contact']),
      shippingAddress: PaymayaShippingAddress.fromMap(map['shippingAddress']),
      billingAddress: PaymayaBillingAddress.fromMap(map['billingAddress']),
    );
  }

  ///{@macro buyer}
  factory PaymayaBuyer.fromJson(String source) =>
      PaymayaBuyer.fromMap(json.decode(source));

  /// Buyer first name
  final String firstName;

  /// Buyer middle name
  final String middleName;

  /// Buyer last name
  final String lastName;

  /// Buyer birthday
  final String birthday;

  /// Buyer since
  final String customerSince;

  /// Buyer sex
  final String? sex;

  /// Buyer [PaymayaContact]
  final PaymayaContact contact;

  /// Buyer shipping address
  final PaymayaShippingAddress shippingAddress;

  /// Buyer billing address
  final PaymayaBillingAddress billingAddress;

  /// {@macro billing}
  PaymayaBuyer copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? birthday,
    String? customerSince,
    String? sex,
    PaymayaContact? contact,
    PaymayaShippingAddress? shippingAddress,
    PaymayaBillingAddress? billingAddress,
  }) {
    return PaymayaBuyer(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      birthday: birthday ?? this.birthday,
      customerSince: customerSince ?? this.customerSince,
      sex: sex ?? this.sex,
      contact: contact ?? this.contact,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      billingAddress: billingAddress ?? this.billingAddress,
    );
  }

  @override
  String toString() {
    return '''PaymayaBuyer(
      firstName: $firstName, 
      middleName: $middleName, 
      lastName: $lastName, 
      birthday: $birthday, 
      customerSince: $customerSince, 
      sex: $sex, 
      contact: $contact, 
      shippingAddress: $shippingAddress, 
      billingAddress: $billingAddress
      )
      ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaBuyer &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.birthday == birthday &&
        other.customerSince == customerSince &&
        other.sex == sex &&
        other.contact == contact &&
        other.shippingAddress == shippingAddress &&
        other.billingAddress == billingAddress;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        birthday.hashCode ^
        customerSince.hashCode ^
        sex.hashCode ^
        contact.hashCode ^
        shippingAddress.hashCode ^
        billingAddress.hashCode;
  }

  /// {@macro billing}
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'birthday': birthday,
      'customerSince': customerSince,
      'sex': sex,
      'contact': contact.toMap(),
      'shippingAddress': shippingAddress.toMap(),
      'billingAddress': billingAddress.toMap(),
    };
  }

  /// {@macro billing}
  String toJson() => json.encode(toMap());
}
