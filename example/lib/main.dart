import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:paymaya_flutter/paymaya_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_browser/web_browser.dart';
import 'shoes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Shoe> _shoes = List.generate(5, (index) {
    return Shoe(
      amount: 100 * index,
      currency: "PHP",
      name: "Shoe #$index",
      description: "A smol shoe size of S-$index",
    );
  });
  late final PayMayaSDK _payMayaSdk;

  @override
  void initState() {
    /// Single Payment Public Key
    _payMayaSdk =
        PayMayaSDK.init('pk-MOfNKu3FmHMVHtjyjG7vhr7vFevRkWxmxYL1Yq6iFk5:');

    /// Checkout Public Key
    // _payMayaSdk =
    //     PayMayaSDK.init('pk-NCLk7JeDbX1m22ZRMDYO9bEPowNWT5J4aNIKIbcTy2a');
    super.initState();
  }

  final List<Shoe> _cart = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Paymaya Shoepping app'),
        ),
        body: GridView.builder(
          itemCount: _shoes.length,
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 250),
          itemBuilder: (context, index) {
            final shoe = _shoes[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (!_cart.contains(shoe)) {
                    _cart.add(shoe);
                  }
                });
              },
              child: _ShoeCard(shoe: shoe),
            );
          },
        ),
        floatingActionButton: Row(
          children: [
            FloatingActionButton.extended(
              onPressed: () async {
                final _amount = _cart.fold<num>(0,
                    (previousValue, element) => previousValue + element.amount);
                final singlePayment = PaymayaSinglePayment(
                    redirectUrl: PaymayaRedirectUrls(
                      success: 'http://shop.someserver.com/success?id=6319921',
                      failure: 'http://shop.someserver.com/failure?id=6319921',
                      cancel: 'http://shop.someserver.com/cancel?id=6319921',
                    ),
                    totalAmount: SinglePaymentAmount(
                      value: _amount.toString(),
                      currency: "PHP",
                    ),
                    requestReferenceNumber: '6319921');
                final result =
                    await _payMayaSdk.createSinglePayment(singlePayment);
                if (await canLaunch(result)) {
                  _onRedirectUrl(result);
                }
              },
              label: Text("Single Payment"),
              icon: Icon(Icons.credit_card),
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                final _amount = _cart.fold<num>(0,
                    (previousValue, element) => previousValue + element.amount);
                final _items = _cart.map((cart) {
                  return PaymayaItem(
                    name: cart.name,
                    quantity: 1,
                    code: 'ABP-797',
                    description: cart.description,
                    amount: PaymayaAmount(
                      value: cart.amount,
                      currency: cart.currency,
                    ),
                    totalAmount:
                        PaymayaAmount(value: cart.amount, currency: "PHP"),
                  );
                }).toList();
                final totalAmount = PaymayaAmount(
                  value: _amount,
                  currency: "PHP",
                );
                final _buyer = PaymayaBuyer(
                  firstName: "John",
                  middleName: '',
                  lastName: "Doe",
                  customerSince: "2020-01-01",
                  birthday: "1998-01-01",
                  contact: PaymayaContact(
                      email: 'johndoe@x.com', phone: '0912345678'),
                  billingAddress: PaymayaBillingAddress(
                    city: 'Davao City',
                    countryCode: 'PH',
                    zipCode: '8000',
                    state: 'Davao',
                  ),
                  shippingAddress: PaymayaShippingAddress(
                    city: 'Davao City',
                    countryCode: 'PH',
                    zipCode: '8000',
                    state: 'Davao',
                    firstName: "John",
                    middleName: '',
                    lastName: "Doe",
                    email: 'paymaya@flutter.com',
                    // ST - Standard
                    // SD - Same Day
                    shippingType: 'ST',
                  ),
                );
                final redirectUrls =
                    PaymayaRedirectUrls(success: '', failure: '', cancel: '');
                final _checkout = PaymayaCheckout(
                    totalAmount: totalAmount,
                    buyer: _buyer,
                    items: _items,
                    redirectUrl: redirectUrls,
                    requestReferenceNumber: '6319921');
                final result = await _payMayaSdk.createCheckOut(
                  _checkout,
                );
                _onRedirectUrl(result);
              },
              label: Text('Checkout Cart(${_cart.length})'),
              icon: Icon(Icons.shopping_basket),
            ),
          ],
        ));
  }

  Future<void> _onRedirectUrl(String url) async {
    if (!await canLaunch(url)) {
      return;
    }
    final isPaid = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return CheckoutPage();
        },
        settings: RouteSettings(arguments: url),
      ),
    );

    if (isPaid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CHECKOUT PAID!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("CANCELLED BY USER")),
      );
    }
  }
}

class _ShoeCard extends StatelessWidget {
  const _ShoeCard({
    Key? key,
    required this.shoe,
  }) : super(key: key);

  final Shoe shoe;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            color: Colors.red[100],
            height: 100,
          ),
          ListTile(
            title: Text(shoe.name),
            subtitle: Text(shoe.description),
            trailing: Text(
              "${shoe.currency} ${shoe.amount.toStringAsFixed(2)}",
            ),
          )
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context)?.settings.arguments as String;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, false);
        return false;
      },
      child: Scaffold(
          body: SafeArea(
        child: WebBrowser(
          interactionSettings: WebBrowserInteractionSettings(
            bottomBar: null,
            topBar: Row(children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              )
            ]),
          ),
          initialUrl: url,
          javascriptEnabled: true,
          debuggingEnabled: kDebugMode,
          iframeSettings: WebBrowserIFrameSettings(
            allow: WebBrowserFeaturePolicy(
              payment: true,
              publicKeyCredentialsGet: true,
            ),
          ),
          onError: (error) async {
            final dialog = await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Something went wrong'),
                  content: Text("$error"),
                  actions: [
                    TextButton(
                      child: Text("close"),
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                    )
                  ],
                );
              },
            );
            if (dialog) {
              Navigator.pop(context, false);
            }
          },
        ),
      )),
    );
  }
}
