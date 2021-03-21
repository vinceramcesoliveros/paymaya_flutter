import 'dart:convert';

/// {@template PaymayaDetails}
///
class PaymayaDetails {
  /// {@macro PaymayaDetails}
  const PaymayaDetails({
    required this.discount,
    required this.serviceCharge,
    required this.shippingFee,
    required this.tax,
    required this.subtotal,
  });

  /// {@macro PaymayaDetails}
  factory PaymayaDetails.fromMap(Map<String, dynamic> map) {
    return PaymayaDetails(
      discount: map['discount'] ?? 0,
      serviceCharge: map['serviceCharge'] ?? 0,
      shippingFee: map['shippingFee'] ?? 0,
      tax: map['tax'] ?? 0,
      subtotal: map['subtotal'] ?? 0,
    );
  }

  /// {@macro PaymayaDetails}
  factory PaymayaDetails.fromJson(String source) =>
      PaymayaDetails.fromMap(json.decode(source));

  /// computed value which the merchant declared
  final num discount;

  /// if necessary to include service charge to merchant.
  final num serviceCharge;

  /// shipping fee can be either delivery fee or the commute fee you declare.
  final num shippingFee;

  /// calculated tax from the usual VAT of 12%
  final num tax;

  /// subtotal of the amount plus the remaining [PaymayaDetails] properties.
  final num subtotal;

  ///{@macro PaymayaDetails}
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

  /// Converts map to json string.
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return '''
    PaymayaDetails(
      discount: $discount, 
      serviceCharge: $serviceCharge, 
      shippingFee: $shippingFee, 
      tax: $tax, 
      subtotal: $subtotal)
    ''';
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

  /// Converts [PaymayaDetails] to [Map]
  Map<String, dynamic> toMap() {
    return {
      'discount': discount,
      'serviceCharge': serviceCharge,
      'shippingFee': shippingFee,
      'tax': tax,
      'subtotal': subtotal,
    };
  }
}
