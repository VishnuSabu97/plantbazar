import 'package:flutter/material.dart';

class CheckOutProuductCard extends StatelessWidget {
  const CheckOutProuductCard({
    super.key,
    required this.name,
    required this.price,
    required this.discription,
    required this.image,
  });
  final String name;
  final String price;
  final String discription;
  final String image;
  // final String quatity;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 215, 215),
            borderRadius: BorderRadius.circular(12)),
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
            // Product Details
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
                      'Price: ₹ $price',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  const Row(
                    children: [
                      Text('quantity: '),
                      Text('3'),
                    ],
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
