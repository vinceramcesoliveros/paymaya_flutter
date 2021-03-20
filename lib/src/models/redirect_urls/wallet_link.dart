import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'redirect_url.dart';

class CreateWalletObject implements PaymayaRedirectUrls {
  final String requestReferenceNumber;
  final Map<String, dynamic>? metadata;
  final String success;
  final String cancel;
  final String failure;
  CreateWalletObject({
    required this.requestReferenceNumber,
    this.metadata,
    required this.success,
    required this.cancel,
    required this.failure,
  });
  Map<String, dynamic> toMap() {
    return {
      'requestReferenceNumber': requestReferenceNumber,
      'metadata': metadata,
      'success': success,
      'cancel': cancel,
      'failure': failure,
    };
  }

  factory CreateWalletObject.fromMap(Map<String, dynamic> map) {
    return CreateWalletObject(
      requestReferenceNumber: map['requestReferenceNumber'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
      success: map['success'] ?? '',
      cancel: map['cancel'] ?? '',
      failure: map['failure'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateWalletObject.fromJson(String source) =>
      CreateWalletObject.fromMap(json.decode(source));
  @override
  CreateWalletObject copyWith({
    String? requestReferenceNumber,
    Map<String, dynamic>? metadata,
    String? success,
    String? cancel,
    String? failure,
  }) {
    return CreateWalletObject(
      requestReferenceNumber:
          requestReferenceNumber ?? this.requestReferenceNumber,
      metadata: metadata ?? this.metadata,
      success: success ?? this.success,
      cancel: cancel ?? this.cancel,
      failure: failure ?? this.failure,
    );
  }

  @override
  String toString() {
    return 'CreateWalletObject(requestReferenceNumber: $requestReferenceNumber, metadata: $metadata, success: $success, cancel: $cancel, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateWalletObject &&
        other.requestReferenceNumber == requestReferenceNumber &&
        mapEquals(other.metadata, metadata) &&
        other.success == success &&
        other.cancel == cancel &&
        other.failure == failure;
  }

  @override
  int get hashCode {
    return requestReferenceNumber.hashCode ^
        metadata.hashCode ^
        success.hashCode ^
        cancel.hashCode ^
        failure.hashCode;
  }
}
