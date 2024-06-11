import 'package:flutter/material.dart';
import 'package:plantbazar/provider/checkout_provider/checkout_provider.dart';
import 'package:plantbazar/view/home/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class PaymentSuccessAlertDialog extends StatelessWidget {
  const PaymentSuccessAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final alertDialogProvider = Provider.of<AlertDialogProvider>(context);
    return AlertDialog(
      title: const Text('Payment Successful'),
      content: const Text('Your payment has been successfully processed.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            alertDialogProvider.hideAlertDialog();
            // Navigate to another page here
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen(); // Replace with the destination page
                },
              ),
            );
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
}
