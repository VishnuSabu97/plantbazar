import 'package:flutter/material.dart';

class AboutUsProvider extends ChangeNotifier {
  Future<dynamic> aboutUsMethod(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Gardenia - Your Green Haven!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'About Gardenia:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Gardenia is your one-stop destination for all things green! We specialize in providing a wide variety of indoor and outdoor plants to bring nature into your home and garden. Our passion for plants and commitment to quality make us your trusted partner in creating a lush, green environment.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our Mission:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'At Gardenia, our mission is to inspire and enable people to embrace the beauty of nature. We strive to offer a curated selection of high-quality plants, along with a seamless shopping experience. Whether you are a seasoned plant enthusiast or just starting your green journey, Gardenia is here to cater to your plant needs.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Why Choose Gardenia?',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Wide Variety: Explore a diverse range of indoor and outdoor plants to suit your preferences and space.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '2. Quality Assurance: Each plant is carefully selected and nurtured to ensure it meets our high-quality standards.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '3. Secure Payments: Shop with confidence using our secure payment gateway powered by Razorpay.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '4. Convenient Delivery: Provide us with your address, and we will ensure timely delivery of your green companions.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Thank you for choosing Gardenia for all your plant needs!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.green,
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
