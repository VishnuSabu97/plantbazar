import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  String privacy = '''
 Gardenia Ecommerce App Privacy Policy

Last Updated: 26-11-2023

Thank you for using the Gardenia Ecommerce App. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By using our app, you consent to the terms described in this policy.

 Information We Collect

 Personal Information

1. ID: A unique identifier assigned to your account.
2. Full Name: Your full name for order processing and personalized communication.
3. Pincode, City, and State: Required for accurate delivery of your purchased items.
4. Phone Number: Used for communication regarding your orders and services.
5. House and Area Information: Specific address details for precise delivery.

 Payment Information

We use Razorpay, a secure payment gateway, to process payments. We do not store your payment information on our servers. Please refer to Razorpay's privacy policy for details on how they handle your payment information.

 Usage Information

We may collect information about how you interact with our app, such as pages visited, products viewed, and actions taken.

 How We Use Your Information

1. Order Fulfillment: To process and deliver your orders accurately.
2. Communication: Sending order updates, promotions, and important notifications.
3. Improving our Services: Analyzing user behavior to enhance the app's functionality and user experience.

 Information Sharing

We do not sell, trade, or otherwise transfer your personal information to third parties unless we provide you with advance notice or as required by law.

  Security

We implement a variety of security measures to protect the safety of your personal information.

 Your Choices

You can review and update your account information through the app. You may also opt-out of receiving promotional communications.

 Changes to this Privacy Policy

We reserve the right to modify this privacy policy at any time. Please review it frequently. Changes and clarifications will take effect immediately upon their posting on the app.

 Contact Us

If you have any questions about this Privacy Policy, please contact us at ansertp47@gmail.com.

---
 ''';
  Future<dynamic> privacyPolicyMethod(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Privacy and Policy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    privacy,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      child: const Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
