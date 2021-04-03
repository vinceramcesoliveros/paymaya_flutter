import 'dart:convert';

///{@template redireturl}
///
/// Example:
///
/// ```dart
///   final redirectUrl = PaymayaRedirectUrl(
///     success: 'yourwebsite.com/success?id=655936',
///     failure: 'yourwebsite.com/failure?id=655936',
///     cancel: 'yourwebsite.com/cancel?id=659936'
///   )
///
/// ```
///
///
///{@endtemplate}
class PaymayaRedirectUrls {
  /// {@macro redirecturl}
  const PaymayaRedirectUrls({
    required this.success,
    required this.failure,
    required this.cancel,
  });

  /// {@macro redirecturl}
  factory PaymayaRedirectUrls.fromMap(Map<String, dynamic> map) {
    return PaymayaRedirectUrls(
      success: map['success'] ?? '',
      failure: map['failure'] ?? '',
      cancel: map['cancel'] ?? '',
    );
  }

  /// {@macro redirecturl}
  factory PaymayaRedirectUrls.fromJson(String source) =>
      PaymayaRedirectUrls.fromMap(json.decode(source));

  /// After successful transaction. PayMaya will use this link to redirect
  /// to your link.
  final String success;

  /// An error occured on PayMaya. The transaction was incomplete and will
  /// redirect to failure link.
  final String failure;

  /// User chose to cancel the transaction.
  final String cancel;

  /// {@macro redirecturl}
  PaymayaRedirectUrls copyWith({
    String? success,
    String? failure,
    String? cancel,
  }) {
    return PaymayaRedirectUrls(
      success: success ?? this.success,
      failure: failure ?? this.failure,
      cancel: cancel ?? this.cancel,
    );
  }

  @override
  String toString() => '''PaymayaRedirectUrls(
          success: $success, 
          failure: $failure, 
          cancel: $cancel)
      ''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaRedirectUrls &&
        other.success == success &&
        other.failure == failure &&
        other.cancel == cancel;
  }

  @override
  int get hashCode => success.hashCode ^ failure.hashCode ^ cancel.hashCode;

  /// converts [Map] to JSON.
  String toJson() => json.encode(toMap());

  /// converts [PaymayaRedirectUrls] to [Map].
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'failure': failure,
      'cancel': cancel,
    };
  }
}
