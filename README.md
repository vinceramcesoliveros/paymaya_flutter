# paymaya_flutter


Unofficial PayMaya SDK for Flutter.

### BLOCKERS

The plan for this package was to make it accessible to all platforms.
But since PayMaya heavily relies on WebViews, The only possible way for this
is to use WebView related packages such as webview_flutter, web_browser or Platform Channels.


### Issues for WebView

#### WEB
PayMaya does not allow iframes to be loaded becasue the `X-FRAME-OPTIONS` was set to `deny`.
So the only solution is to make a redirect url that closes the window. that way,
you will have control thru your own logic.

Example:
```dart
    /// returns payment link.
    final redirectUrl = await payMayaSDK.createCheckout(checkout);
    /// For Mobile:
    /// From the webview of your page. 
    final bool result = await Navigator.push(context, YourWebView());
    /// For Web:
    /// Opens a new window to process payment.
    if(await canLaunch(redirectUrl)){
        await launch(redirectUrl);
    }
```

### Usage

### PayMayaSDK

#### `init()`
Run this method first before invoking other methods.
```dart
final payMayaSDK = PayMayaSDK.init('pk-Mn124x69sda', isSandBox: true);
```

#### `createCheckout`
```dart
// inside of Future function
final checkout = PaymayaCheckout(
    totalAmount: PaymayaAmount(
        value: 700,
        currency: 'PHP', // Default currency
    ),
    items: [PaymayaItems(...)],
    redirectUrl: PaymayaRedirectUrls(
        success:'https://yourwebsite.com/success?id=65593',
        failure:'https://yourwebsite.com/failure?id=65593',
        cancel:'https://yourwebsite.com/cancel?id=65593',
    ),
    requestReferenceNumber: '512396',
);
  /// returns payment link.
  final redirectUrl = await payMayaSDK.createCheckout(checkout);
```
TODOS:

- [ ] Webhooks. This is useful for flutter web to monitor the redirect callback url
- [ ] Custom Widget without using WebViews
- [ ] Wallet Link Widget
- [ ] Instructions for newly registered PayMaya Managers
- [ ] Support paymaya for non-flutter apps.
### Donate
<form action="https://www.paypal.com/donate" method="post" target="_top">
<input type="hidden" name="business" value="blusea231@gmail.com" />
<input type="hidden" name="currency_code" value="USD" />
<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" title="PayPal - The safer, easier way to pay online!" alt="Donate with PayPal button" />
<img alt=""  src="https://www.paypal.com/en_PH/i/scr/pixel.gif" width="1" height="1" />
</form>
