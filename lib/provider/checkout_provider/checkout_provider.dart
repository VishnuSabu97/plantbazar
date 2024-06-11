import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/order_model.dart';
import 'package:plantbazar/shared/bottomnavigation/bottom_bar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

enum PaymentCategory { cashondelivery, paynow }

class ProductPayment extends ChangeNotifier {
  String? _orderId;
  set orderId(String value) {
    _orderId = value;
  }

  String get orderId => _orderId ?? '0';
  Future<void> confirm(
      {required OrderModel value, BuildContext? context}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Order')
          .doc(value.orderId)
          .set(
        {
          'id': value.id,
          'status': value.status,
          'productName': value.productName,
          'quantity': value.quantity,
          'totalPrice': value.totalPrice,
          'description': value.description,
          'category': value.category,
          'imageUrl': value.imageUrl,
          'orderId': value.orderId,
          'date': value.date
        },
      );
      notifyListeners();
    } on FirebaseException catch (error) {
      String errorMessage = 'An error occurred while adding the product.';

      if (error.code == 'permission-denied') {
        errorMessage =
            'Permission denied. You do not have the necessary permissions.';
      } else if (error.code == 'not-found') {
        errorMessage = 'The requested document was not found.';
      }

      showSnackbar(context!, errorMessage);
      print("Failed to add product: $error");
      notifyListeners();
    } catch (error) {
      showSnackbar(context!, 'An unexpected error occurred. Please try again.');
      print("Failed to add product: $error");
      notifyListeners();
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 20.0),
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }
}

class CheckoutProvider extends ChangeNotifier {
  int _totalNum = 1;
  set totalNum(int value) {
    _totalNum = value;
  }

  int get totalNum => _totalNum;
  void addNum() {
    _totalNum++;
    notifyListeners();
  }

  void reduceNum() {
    _totalNum--;
    notifyListeners();
  }

  int calulateTotal(String value) {
    int price = int.tryParse(value) ?? 0;
    if (_totalNum != 0 || _totalNum <= 0) {
      int lastprice = price * _totalNum;
      return lastprice;
    } else {
      debugPrint('== ======== =calculating price have error==========');
      return 0;
    }
  }

  void showPaymentCompletedDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Payment Completed"),
      content: Text("Your payment has been successfully completed."),
      actions: [
        ElevatedButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ScreenNavWidget(),
              ),
            );
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  PaymentCategory _paymentCategory = PaymentCategory.paynow;

  PaymentCategory get paymentCategory => _paymentCategory;

  void setPaymentCategory(PaymentCategory category) {
    _paymentCategory = category;
    notifyListeners();
  }
}

class BottomSheetProvider extends ChangeNotifier {
  bool _showBottomSheet = false;

  bool get bottomSheet => _showBottomSheet;

  void showBottomSheet() {
    _showBottomSheet = true;
    notifyListeners();
  }

  void hideBottomSheet() {
    _showBottomSheet = false;
    notifyListeners();
  }
}

class AlertDialogProvider with ChangeNotifier {
  bool _showDialog = false;

  bool get showDialog => _showDialog;

  void showAlertDialog() {
    _showDialog = true;
    notifyListeners();
  }

  void hideAlertDialog() {
    _showDialog = false;
    notifyListeners();
  }
}

class RazorpayProvider with ChangeNotifier {
  final Razorpay _razorpay = Razorpay();
  late Function(PaymentFailureResponse) _onPaymentFailure;
  late Function(PaymentSuccessResponse) _onPaymentSuccess;

  RazorpayProvider() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  void openRazorpayPayment({
    required Map<String, dynamic> options,
    required Function(PaymentFailureResponse) onError,
    required Function(PaymentSuccessResponse) onSuccess,
  }) {
    _razorpay.open(options);
    _onPaymentFailure = onError;
    _onPaymentSuccess = onSuccess;
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    _onPaymentFailure(response);
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    _onPaymentSuccess(response);
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {}

  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
