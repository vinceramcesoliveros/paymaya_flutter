import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:url_launcher/url_launcher.dart';

/// A web implementation of the PaymayaFlutter plugin.
class PaymayaFlutterWeb {
  // ignore: public_member_api_docs
  static void registerWith(Registrar registrar) {
    final channel = MethodChannel(
      'paymaya_flutter',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = PaymayaFlutterWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'checkoutPage':
        if (await canLaunch(call.arguments)) {
          return true;
        }
        return false;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'paymaya_flutter for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }
}
