import 'package:paymaya_flutter/paymaya_flutter.dart';

import 'constants.dart';

const shippingAddress = PaymayaShippingAddress(
  city: 'Davao City',
  countryCode: 'PH',
  zipCode: '8000',
  state: 'Davao',
  firstName: 'John',
  middleName: '',
  lastName: 'Doe',
  email: 'paymaya@flutter.com',
  // ST - Standard
  // SD - Same Day
  shippingType: ShippingType.sd,
);
const billingAddress = PaymayaBillingAddress(
  city: 'Davao City',
  countryCode: 'PH',
  zipCode: '8000',
  state: 'Davao',
);
const buyer = PaymayaBuyer(
  firstName: 'John',
  middleName: '',
  lastName: 'Doe',
  customerSince: '2020-01-01',
  birthday: '1998-01-01',
  contact: PaymayaContact(
    email: 'johndoe@x.com',
    phone: '0912345678',
  ),
  billingAddress: billingAddress,
  shippingAddress: shippingAddress,
);

const items = [
  PaymayaItem(
    name: 'test1',
    amount: PaymayaAmount(value: 100),
    quantity: 1,
    totalAmount: PaymayaAmount(
      value: 100,
    ),
  ),
  PaymayaItem(
    name: 'test2',
    amount: PaymayaAmount(value: 100),
    quantity: 1,
    totalAmount: PaymayaAmount(
      value: 100,
    ),
  ),
  PaymayaItem(
    name: 'test3',
    amount: PaymayaAmount(value: 100),
    quantity: 1,
    totalAmount: PaymayaAmount(
      value: 100,
    ),
  ),
  PaymayaItem(
    name: 'test4',
    amount: PaymayaAmount(value: 100),
    quantity: 1,
    totalAmount: PaymayaAmount(
      value: 100,
    ),
  ),
];

const checkout = PaymayaCheckout(
  totalAmount: amount,
  buyer: buyer,
  items: items,
  redirectUrl: redirectUrl,
  requestReferenceNumber: requestReferenceNumber,
);
