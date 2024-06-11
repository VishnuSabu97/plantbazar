import 'package:flutter/material.dart';
import 'package:plantbazar/provider/checkout_provider/checkout_provider.dart';
import 'package:provider/provider.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.checkoutProvider,
    required this.totalPrice,
  });

  final String image;
  final String name;
  final String price;
  final CheckoutProvider checkoutProvider;
  final int totalPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
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
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '₹ $price',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('quantity: '),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (checkoutProvider.totalNum <= 0) {
                            checkoutProvider.totalNum = 1;
                            Navigator.pop(context);
                          }
                          context.read<CheckoutProvider>().reduceNum();
                        },
                      ),
                      Text(checkoutProvider.totalNum.toString()),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () async {
                          context.read<CheckoutProvider>().addNum();
                        },
                      ),
                    ],
                  ),
                  Text(
                    'Total : $totalPrice',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
