## [0.2.0]
### Features
- Added Checkout Widget. Use `PayMayaSDK.navigateToCheckout(PaymayaCheckout checkout)`.
- Added Single Payment Widget. Use `PayMayaSDK.navigateToPayment(PaymayaSinglePayment singlePayment)`
- Added Link widget that uses `url_launcher` Platform specific webview including Web, Android and iOS. Use `PaymayaLink` Widget. See [PaymayaLink](./lib/src/widgets/link.dart)
### Breaking Changes
- Change `createCheckout` and `createSinglePayment` return type to `PaymayaResponse`. See [PaymayaResponse](./lib/src/models/response.dart)
- Added `http` on `PayMayaSDK.init` method. This lets you customize your http response.

## [0.1.0]
### Features

- Added test cases for Create Checkout and Create Single Payment
- Added **PaymayaResponse** for api response object 
### BUG FIXES
- Fix documentation markdown
- Fix default values for `toMap`
- Fix required fields
## [0.0.1]
- Added PayMaya SDK port from https://github.com/PayMaya/PayMaya-JS-SDK-v2