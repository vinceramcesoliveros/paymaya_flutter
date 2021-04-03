import 'package:paymaya_flutter/paymaya_flutter.dart';

const amount = PaymayaAmount(value: 700);
const contact = PaymayaContact(email: 'test@g.com', phone: '+6391234567');

const redirectUrl = PaymayaRedirectUrls(
  success: 'http://google.com/?success=1&id=6319921',
  failure: 'http://google.com/?failure=1&id=6319921',
  cancel: 'http://google.com/?cancel=1&id=6319921',
);

const requestReferenceNumber = '6319921';
const checkoutPublicKey = 'pk-NCLk7JeDbX1m22ZRMDYO9bEPowNWT5J4aNIKIbcTy2a';
const singlePaymentKey = 'pk-MOfNKu3FmHMVHtjyjG7vhr7vFevRkWxmxYL1Yq6iFk5:';
