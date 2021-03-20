import 'dart:convert';

class PaymayaDetails {
  final num discount;
  final num serviceCharge;
  final num shippingFee;
  final num tax;
  final num subtotal;
  PaymayaDetails({
    required this.discount,
    required this.serviceCharge,
    required this.shippingFee,
    required this.tax,
    required this.subtotal,
  });

  PaymayaDetails copyWith({
    num? discount,
    num? serviceCharge,
    num? shippingFee,
    num? tax,
    num? subtotal,
  }) {
    return PaymayaDetails(
      discount: discount ?? this.discount,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      shippingFee: shippingFee ?? this.shippingFee,
      tax: tax ?? this.tax,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  @override
  String toString() {
    return 'PaymayaDetails(discount: $discount, serviceCharge: $serviceCharge, shippingFee: $shippingFee, tax: $tax, subtotal: $subtotal)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaDetails &&
        other.discount == discount &&
        other.serviceCharge == serviceCharge &&
        other.shippingFee == shippingFee &&
        other.tax == tax &&
        other.subtotal == subtotal;
  }

  @override
  int get hashCode {
    return discount.hashCode ^
        serviceCharge.hashCode ^
        shippingFee.hashCode ^
        tax.hashCode ^
        subtotal.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'discount': discount,
      'serviceCharge': serviceCharge,
      'shippingFee': shippingFee,
      'tax': tax,
      'subtotal': subtotal,
    };
  }

  factory PaymayaDetails.fromMap(Map<String, dynamic> map) {
    return PaymayaDetails(
      discount: map['discount'] ?? 0,
      serviceCharge: map['serviceCharge'] ?? 0,
      shippingFee: map['shippingFee'] ?? 0,
      tax: map['tax'] ?? 0,
      subtotal: map['subtotal'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaDetails.fromJson(String source) =>
      PaymayaDetails.fromMap(json.decode(source));
}
