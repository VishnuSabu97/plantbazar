import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/order_model.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/provider/address/address_provider.dart';
import 'package:plantbazar/provider/checkout_provider/checkout_provider.dart';
import 'package:plantbazar/shared/common_widget/common_button.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:plantbazar/view/checkout_page/widget/heading_delivery.dart';
import 'package:plantbazar/view/profile/screens/address/dafault_card.dart';
import 'package:plantbazar/view/profile/screens/address/main_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

Razorpay razorpay = Razorpay();

class CheckoutScreen2 extends StatelessWidget {
  CheckoutScreen2({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<ProductClass> products;
  int calculateTotalAmount(List<ProductClass> products) {
    int totalAmount = 0;
    for (var product in products) {
      int price = int.tryParse(product.price ?? '0') ?? 0;
      int quantity = int.tryParse(product.quantity ?? '0') ?? 0;
      totalAmount += price * quantity;
    }
    return totalAmount;
  }

  DateTime currentDate = DateTime.now();
  String _uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  String date = '0';
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${currentDate.day}-${currentDate.month}-${currentDate.year}";
    date = formattedDate;

    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final razorpayProvider = Provider.of<RazorpayProvider>(context);

    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              kHeight20,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size.height / 8,
                  child: DeliveryHeading(size: size),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 9,
                  right: 9,
                ),
                child: DefaultAddress(size: size),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ScreenAddress(),
                    ),
                  );
                  context
                      .read<AddressProvider>()
                      .showSnackbar(context, 'Change address default');
                },
                child: const Text('Change Address'),
              ),
              kHeight20,
              // Display product cards
              for (var product in products) ...[
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10.0),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            product.imageUrl ??
                                'https://www.google.com/imgres?imgurl=https%3A%2F%2Fwww.salonlfc.com%2Fwp-content%2Fuploads%2F2018%2F01%2Fimage-not-found-scaled.png&tbnid=EQhG80gDXt9AJM&vet=12ahUKEwixkcr9xdKCAxWBoekKHQTjCBAQMygBegQIARBH..i&imgrefurl=https%3A%2F%2Fwww.salonlfc.com%2Fen%2Fimage-not-found%2F&docid=rb42RVdX5acoCM&w=2560&h=1440&q=image%20not%20found&ved=2ahUKEwixkcr9xdKCAxWBoekKHQTjCBAQMygBegQIARBH',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        // Product Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  '₹ ${product.price ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  const Text('quantity: '),
                                  Text(product.quantity ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Total : ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    ' ₹ ${calculateTotalAmount(products)}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Radio<PaymentCategory>(
                  groupValue: checkoutProvider.paymentCategory,
                  value: PaymentCategory.paynow,
                  onChanged: (PaymentCategory? value) {
                    checkoutProvider.setPaymentCategory(value!);
                  },
                ),
                title: const Text('Pay Now'),
              ),
              ListTile(
                leading: Radio<PaymentCategory>(
                  groupValue: checkoutProvider.paymentCategory,
                  value: PaymentCategory.cashondelivery,
                  onChanged: (PaymentCategory? value) {
                    checkoutProvider.setPaymentCategory(value!);
                  },
                ),
                title: const Text('Cash on delivery'),
              ),
              kHeight50,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 12,
                child: CommonButton(
                  name: "Confirm order",
                  voidCallback: () {
                    if (checkoutProvider.paymentCategory ==
                        PaymentCategory.paynow) {
                      final user = FirebaseAuth.instance.currentUser;

                      for (var product in products) {
                        int total = calculateTotalAmount(products);
                        var options = {
                          'key': 'rzp_test_EunImdr5xuJGFC',
                          'amount': total * 100,
                          'name': 'Gardenia',
                          'description': product.name ?? '',
                          'retry': {'enabled': true, 'max_count': 1},
                          'send_sms_hash': true,
                          'prefill': {
                            'contact': '8078711479',
                            'email': user!.email
                          },
                          'external': {
                            'wallets': ['paytm']
                          }
                        };
                        final obj = OrderModel(
                          orderId: _uniqueFileName,
                          status: 'Pending',
                          quantity: context
                              .read<CheckoutProvider>()
                              .totalNum
                              .toString(),
                          id: product.id,
                          description: product.description,
                          category: product.category,
                          imageUrl: product.imageUrl,
                          productName: product.name,
                          totalPrice: product.price,
                          date: date,
                        );
                        context
                            .read<ProductPayment>()
                            .confirm(value: obj, context: context);
                        razorpayProvider.openRazorpayPayment(
                          options: options,
                          onError: (response) {
                            handlePaymentErrorResponse(response, context);
                          },
                          onSuccess: (response) {
                            handlePaymentSuccessResponse(response, context);
                          },
                        );
                      }
                    } else {
                      for (var product in products) {
                        final obj = OrderModel(
                          orderId: _uniqueFileName,
                          status: 'Pending',
                          quantity: context
                              .read<CheckoutProvider>()
                              .totalNum
                              .toString(),
                          id: product.id,
                          description: product.description,
                          category: product.category,
                          imageUrl: product.imageUrl,
                          productName: product.name,
                          totalPrice: product.price,
                          date: date,
                        );
                        context
                            .read<ProductPayment>()
                            .confirm(value: obj, context: context);
                        context
                            .read<CheckoutProvider>()
                            .showPaymentCompletedDialog(context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(
      PaymentFailureResponse response, BuildContext context) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(
        context, "Payment Failed", "\nDescription: ${response.message}}");
  }

  void handlePaymentSuccessResponse(
      PaymentSuccessResponse response, BuildContext context) {
    String id = response.orderId.toString();

    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(
      ExternalWalletResponse response, BuildContext context) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
