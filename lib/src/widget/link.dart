import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

///{@template linkwidget}
/// A widget that will show a button that is ready for payment
///{@endtemplate}
class PaymayaLinkWidget extends StatelessWidget {
  /// {@macro linkwidget}
  const PaymayaLinkWidget({
    Key? key,
    required this.future,
    required this.onTap,
    required this.child,
    this.errorWidget,
    this.loadingWidget,
  }) : super(key: key);

  /// the future will request for the redirect link and the
  /// link widget will handle for platform specific webview
  final Future<String> future;

  /// your specific callback before the [Link.builder] callback will invoke.
  final VoidCallback onTap;

  /// your widget to show, you can use button but the [onTap] will be used
  /// instead of the button onPressed
  final Widget child;

  /// while waiting for the future,the default widget will be
  /// [CircularProgressIndicator] widget.
  final Widget? loadingWidget;

  /// Throws an error when something went wrong with your [future].
  final Widget Function(Object? error)? errorWidget;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Link(
            uri: Uri.parse(snapshot.data),
            target: LinkTarget.self,
            builder:
                (BuildContext context, Future<void> Function()? followLink) =>
                    GestureDetector(
              child: child,
              onTap: () {
                onTap();
                followLink?.call();
              },
            ),
          );
        }
        if (snapshot.hasError) {
          return errorWidget?.call(snapshot.error) ??
              Text('Something went wrong: ${snapshot.error}');
        }
        return loadingWidget ??
            const Center(
              child: CircularProgressIndicator(),
            );
      },
    );
  }
}
