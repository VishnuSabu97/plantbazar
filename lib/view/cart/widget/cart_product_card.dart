import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart/cart_provider.dart';

class CartCard extends StatelessWidget {
  const CartCard({
    super.key,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.description,
    required this.id,
  });
  final String name;
  final String image;
  final String quantity;
  final String description;
  final String price;
  final String id;

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
        child: SingleChildScrollView(
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
                            context.read<CartProvider>().reduceK(id, quantity);
                          },
                        ),
                        Text(quantity),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () async {
                            context.read<CartProvider>().addK(id, quantity);
                            // context.read<CartProvider>().fetchCart();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  context
                      .read<CartProvider>()
                      .deleteCart(id: id, context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
