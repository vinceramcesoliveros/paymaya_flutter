import 'dart:convert';

import '../amount/amount.dart';

/// {@template item}
/// Paymaya Item
///
/// Example:
///
/// ```dart
///   final item = PaymayaItem(
///     name: 'Shoe(Size SX)',
///
///   );
/// ```
/// {@endtemplate}
class PaymayaItem {
  ///{@macro item}
  const PaymayaItem({
    required this.name,
    required this.quantity,
    this.code,
    this.description,
    required this.amount,
    required this.totalAmount,
  });

  ///{@macro item}
  factory PaymayaItem.fromMap(Map<String, dynamic> map) {
    return PaymayaItem(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      code: map['code'] ?? '',
      description: map['description'] ?? '',
      amount: PaymayaAmount.fromMap(map['amount']),
      totalAmount: PaymayaAmount.fromMap(map['totalAmount']),
    );
  }

  ///{@macro item}
  factory PaymayaItem.fromJson(String source) =>
      PaymayaItem.fromMap(json.decode(source));

  ///
  final String name;

  ///
  final num quantity;

  ///
  final String? code;

  ///
  final String? description;

  ///
  final PaymayaAmount amount;

  ///
  final PaymayaAmount totalAmount;

  ///{@macro item}
  PaymayaItem copyWith({
    String? name,
    num? quantity,
    String? code,
    String? description,
    PaymayaAmount? amount,
    PaymayaAmount? totalAmount,
  }) {
    return PaymayaItem(
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      code: code ?? this.code,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  @override
  String toString() {
    return '''PaymayaItem(
      name: $name, 
      quantity: $quantity, 
      code: $code, 
      description: $description, 
      amount: $amount, 
      totalAmount: $totalAmount)
      ''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaItem &&
        other.name == name &&
        other.quantity == quantity &&
        other.code == code &&
        other.description == description &&
        other.amount == amount &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        quantity.hashCode ^
        code.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        totalAmount.hashCode;
  }

  ///{@macro item}
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'code': code,
      'description': description,
      'amount': amount.toMap(),
      'totalAmount': totalAmount.toMap(),
    };
  }

  ///{@macro item}
  String toJson() => json.encode(toMap());
}
