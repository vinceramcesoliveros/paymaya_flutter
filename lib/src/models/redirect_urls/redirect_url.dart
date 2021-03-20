import 'dart:convert';

class PaymayaRedirectUrls {
  final String success;
  final String failure;
  final String cancel;
  PaymayaRedirectUrls({
    required this.success,
    required this.failure,
    required this.cancel,
  });

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
  String toString() =>
      'PaymayaRedirectUrls(success: $success, failure: $failure, cancel: $cancel)';

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

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'failure': failure,
      'cancel': cancel,
    };
  }

  factory PaymayaRedirectUrls.fromMap(Map<String, dynamic> map) {
    return PaymayaRedirectUrls(
      success: map['success'] ?? '',
      failure: map['failure'] ?? '',
      cancel: map['cancel'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymayaRedirectUrls.fromJson(String source) =>
      PaymayaRedirectUrls.fromMap(json.decode(source));
}
