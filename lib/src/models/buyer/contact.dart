import 'dart:convert';

/// {@template contact}
/// Simple contact info.
/// Example:
/// ```dart
///   final contact = PaymayaContact(
///     email:'paymaya@flutter.com',
///     phone:'0912345689',
///   );
/// ```
/// {@endtemplate}
class PaymayaContact {
  ///{@macro contact}
  const PaymayaContact({
    this.email,
    this.phone,
  });

  /// {@macro contact}
  factory PaymayaContact.fromMap(Map<String, dynamic> map) {
    return PaymayaContact(
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  /// {@macro contact}
  factory PaymayaContact.fromJson(String source) =>
      PaymayaContact.fromMap(json.decode(source));

  /// the [email] no validation. the API handles the email validation
  final String? email;

  /// it can be either cellular phone number or telephone nunmber.
  final String? phone;

  /// {@macro contact}
  PaymayaContact copyWith({
    String? email,
    String? phone,
  }) {
    return PaymayaContact(
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaContact &&
        other.email == email &&
        other.phone == phone;
  }

  @override
  int get hashCode => email.hashCode ^ phone.hashCode;

  @override
  String toString() => 'PaymayaContact(email: $email, phone: $phone)';

  ///{@macro contact}
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
    };
  }

  ///{@macro contact}
  String toJson() => json.encode(toMap());
}
