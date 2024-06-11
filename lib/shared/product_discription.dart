import 'package:flutter/material.dart';
import 'package:plantbazar/model/cart_model.dart';
import 'package:plantbazar/provider/cart/cart_provider.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:plantbazar/view/checkout_page/screens/checkout_page.dart';
import 'package:provider/provider.dart';

class ProductDiscription extends StatelessWidget {
  const ProductDiscription({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.discription,
    required this.img,
    required this.id,
  });
  final String name;
  final String price;
  final String category;
  final String discription;
  final String img;
  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: const Text(
            'Product discription',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Discription(
          img: img,
          name: name,
          price: price,
          category: category,
          discription: discription,
          id: id,
        ),
      ),
    );
  }
}

class Discription extends StatelessWidget {
  const Discription({
    super.key,
    required this.img,
    required this.name,
    required this.price,
    required this.category,
    required this.discription,
    required this.id,
  });
  final String id;
  final String img;
  final String name;
  final String price;
  final String category;
  final String discription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: constraints.maxWidth,
                height: 400,
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 12),
                child: Row(
                  children: [
                    Text(
                      '₹$price',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Category: $category',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 133, 133, 133),
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: Text(discription),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            category: category,
                            id: id,
                            discription: discription,
                            image: img,
                            name: name,
                            price: price,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Buy',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.all(10),
                      minimumSize: const Size(150, 50),
                    ),
                    onPressed: () {
                      final addToCart = CartModel(
                        name: name,
                        price: price,
                        category: category,
                        description: discription,
                        imageUrl: img,
                        id: id,
                        quantity: '1',
                      );
                      context
                          .read<CartProvider>()
                          .addToCart(context: context, value: addToCart);
                    },
                    child: const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
              kHeight40,
            ],
          );
        },
      ),
    );
  }
}
