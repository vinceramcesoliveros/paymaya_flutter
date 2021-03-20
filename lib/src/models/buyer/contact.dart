import 'dart:convert';

class PaymayaContact {
  PaymayaContact({
    this.email,
    this.phone,
  });

  final String? email;
  final String? phone;
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

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phone': phone,
    };
  }

  factory PaymayaContact.fromMap(Map<String, dynamic> map) {
    return PaymayaContact(
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaContact.fromJson(String source) =>
      PaymayaContact.fromMap(json.decode(source));
}
