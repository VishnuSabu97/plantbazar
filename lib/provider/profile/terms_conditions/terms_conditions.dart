import 'package:flutter/material.dart';

class TermsandConditonsProvider extends ChangeNotifier {
  String termsAndConditionsText = '''
Welcome to Gardenia, an ecommerce platform for the sale of indoor and outdoor plants. By accessing or using our app, you agree to comply with and be bound by the following terms and conditions. Please read these terms carefully before using our services.

1. Acceptance of Terms:  By using our app, you agree to these terms and conditions. If you do not agree with any part of these terms, you may not use our services.

2. User Registration: To make a purchase, you may be required to register for an account. You are responsible for maintaining the confidentiality of your account information, including your username and password.

3. Ordering and Payment:
   - Orders: By placing an order, you agree to purchase the selected products at the specified price.
   - Payments: We use Razorpay for secure online payments. Payment information is encrypted and processed securely.

4. Shipping and Delivery:
   - Address Collection: We collect user addresses for shipping purposes. It is your responsibility to provide accurate and complete address information.
   - Delivery: Delivery times may vary. We strive to deliver products in a timely manner, but we are not responsible for delays caused by factors beyond our control.

5. Returns and Refunds:
   - Returns: Products may be eligible for return according to our return policy.
   - Refunds: Refunds are processed in accordance with our refund policy.

6. Add to Cart and Wishlist:
   - Add to Cart: The "Add to Cart" feature allows you to collect items for purchase. Adding items to the cart does not guarantee availability.
   - Add to Wishlist: The "Add to Wishlist" feature allows you to save items for future consideration. Wishlist items are not reserved.

7. Privacy Policy: Your use of our app is also governed by our Privacy Policy, which can be found.

8. Intellectual Property: All content on our app, including text, graphics, logos, and images, is the property of Gardenia and is protected by intellectual property laws.

9. Limitation of Liability: We are not liable for any direct, indirect, incidental, consequential, or punitive damages arising out of your use of our app or the products purchased through our app.

10. Changes to Terms: We reserve the right to update or modify these terms and conditions at any time. Continued use of our app after such changes constitutes acceptance of the updated terms.

11. Governing Law: These terms and conditions are governed by the laws and regulations of India.

If you have any questions or concerns about these terms and conditions, please contact us at ansertp47@gmail.com.

Thank you for using Gardenia
''';
  Future<dynamic> termsAndConditionsMethod(BuildContext context) {
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
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    termsAndConditionsText,
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
