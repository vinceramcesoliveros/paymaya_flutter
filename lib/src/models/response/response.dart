import 'dart:convert';

/// {@template response}
/// Returns Paymaya response where you need a redirect url.
/// {@endtemplate}
class PaymayaResponse {
  /// {@macro response}
  const PaymayaResponse({
    required this.checkoutId,
    required this.redirectUrl,
  });

  /// {@macro response}
  factory PaymayaResponse.fromMap(Map<String, dynamic> map) {
    return PaymayaResponse(
      checkoutId: map['checkoutId'] ?? '',
      redirectUrl: map['redirectUrl'] ?? '',
    );
  }

  /// {@macro response}
  factory PaymayaResponse.fromJson(String source) =>
      PaymayaResponse.fromMap(json.decode(source));

  /// response from paymaya
  final String checkoutId;

  /// url link to show in the browser for completing payment request.
  final String redirectUrl;

  /// {@macro response}
  PaymayaResponse copyWith({
    String? checkoutId,
    String? redirectUrl,
  }) {
    return PaymayaResponse(
      checkoutId: checkoutId ?? this.checkoutId,
      redirectUrl: redirectUrl ?? this.redirectUrl,
    );
  }

  /// converts [PaymayaResponse] to [Map]
  Map<String, dynamic> toMap() {
    return {
      'checkoutId': checkoutId,
      'redirectUrl': redirectUrl,
    };
  }

  /// converts [PaymayaResponse] to [String] json
  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'PaymayaResponse(checkoutId: $checkoutId, redirectUrl: $redirectUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymayaResponse &&
        other.checkoutId == checkoutId &&
        other.redirectUrl == redirectUrl;
  }

  @override
  int get hashCode => checkoutId.hashCode ^ redirectUrl.hashCode;
}
