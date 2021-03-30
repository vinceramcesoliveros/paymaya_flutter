import 'dart:convert';

import 'package:flutter/foundation.dart';

/// {@template createwallet}
/// Links your paymaya without re-logging in again.
///
/// ```dart
/// final createWalletObject = CreateWalletObject(
///   requestReferenceNumber: '65559',
///   success:'https://yoururl.com/succes?id=65593',
///   cancel: 'https://yoururl.com/cancel?id=65593',
///   failure: 'https://yoururl.com/failure?id=65593',
///   metadata: {
///       ///...
///   }
/// );
/// ```
///
/// Creates a wallet link that allows charging to a PayMaya account.
/// The redirect URLs are used to go back to merchant’s server after the link
/// has been processed depending on the status, as shown in the request body.
/// The metadata is used to add payment facilitator information,
/// as indicated in this section.
/// {@endtemplate}
class CreateWalletObject {
  /// {@macro createwallet}
  const CreateWalletObject({
    required this.requestReferenceNumber,
    this.metadata,
    required this.success,
    required this.cancel,
    required this.failure,
  });

  /// {@macro createwallet}
  factory CreateWalletObject.fromMap(Map<String, dynamic> map) {
    return CreateWalletObject(
      requestReferenceNumber: map['requestReferenceNumber'] ?? '',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? const {}),
      success: map['success'] ?? '',
      cancel: map['cancel'] ?? '',
      failure: map['failure'] ?? '',
    );
  }

  /// {@macro createwallet}
  factory CreateWalletObject.fromJson(String source) =>
      CreateWalletObject.fromMap(json.decode(source));

  /// request reference number from the merchant
  final String requestReferenceNumber;

  /// temporary solution, the metadata will have its own `type`'d properties
  /// since everything will be converted to json.
  final Map<String, dynamic>? metadata;

  /// your success url callback.
  final String success;

  /// your cancel url callback.
  final String cancel;

  /// your failure url callback.
  final String failure;

  /// {@macro createwallet}
  Map<String, dynamic> toMap() {
    return {
      'requestReferenceNumber': requestReferenceNumber,
      'metadata': metadata,
      'success': success,
      'cancel': cancel,
      'failure': failure,
    };
  }

  /// convert [Map] to [String] json
  String toJson() => json.encode(toMap());

  /// {@macro createwallet}
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
    return '''CreateWalletObject(
      requestReferenceNumber: $requestReferenceNumber, 
      metadata: $metadata, 
      success: $success, 
      cancel: $cancel, 
      failure: $failure)
      ''';
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
