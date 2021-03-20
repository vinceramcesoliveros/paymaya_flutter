#import "PaymayaFlutterPlugin.h"
#if __has_include(<paymaya_flutter/paymaya_flutter-Swift.h>)
#import <paymaya_flutter/paymaya_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "paymaya_flutter-Swift.h"
#endif

@implementation PaymayaFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPaymayaFlutterPlugin registerWithRegistrar:registrar];
}
@end
