import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:plantbazar/shared/product_discription.dart';
import 'package:plantbazar/view/cart/widget/cart_product_card.dart';
import 'package:plantbazar/view/checkout_page/screens/check_out2.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('Cart');
  List<ProductClass> getProductsFromCart(QuerySnapshot cartSnapshot) {
    List<ProductClass> products = [];

    for (QueryDocumentSnapshot<Object?> item in cartSnapshot.docs) {
      Map<String, dynamic> productData = item.data() as Map<String, dynamic>;

      products.add(
        ProductClass(
          name: productData['name'],
          price: productData['price'],
          quantity: productData['quantity'],
          description: productData['description'],
          category: productData['category'],
          imageUrl: productData['imageUrl'],
          id: productData['id'],
        ),
      );
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'Cart',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: gcolor,
          ),
          child: StreamBuilder(
              stream: cartCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<QueryDocumentSnapshot<Object?>> data =
                    snapshot.data?.docs ?? [];
                String total = calculateTotalPrice(data);
                return Column(
                  children: [
                    kHeight20,
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (data.isEmpty) {
                            return const Center(
                              child: Text('No Products'),
                            );
                          }

                          return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProductDiscription(
                                        category:
                                            data[index]['category'] ?? 'null',
                                        discription: data[index]['description'],
                                        id: data[index]['id'],
                                        img: data[index]['imageUrl'],
                                        name: data[index]['name'],
                                        price: data[index]['price'],
                                      ),
                                    ),
                                  );
                                },
                                child: CartCard(
                                    name: data[index]['name'] ?? 'name',
                                    price: data[index]['price'] ?? '84',
                                    image: data[index]['imageUrl'] ??
                                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShiq-YDkgihdO9XD29qY3p58tiBINmzqZD8Q&usqp=CAU',
                                    quantity:
                                        data[index]['quantity'] ?? 'quantit',
                                    description: data[index]['description'] ??
                                        'quantity',
                                    id: data[index]['id'] ?? 'null'),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 70,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              subtitle: Text(
                                'Total (${snapshot.data!.docs.length} items):',
                              ),
                              title: Text(
                                '₹ $total',
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              trailing: ElevatedButton(
                                onPressed: () {
                                  cartCollection.get().then(
                                    (cartSnapshot) {
                                      List<ProductClass> products =
                                          getProductsFromCart(cartSnapshot);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CheckoutScreen2(
                                              products: products),
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    elevation: 8,
                                    shadowColor: Colors.grey,
                                    backgroundColor: Colors.green),
                                child: const Text('Place Order'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
    );
  }

  String calculateTotalPrice(List<QueryDocumentSnapshot<Object?>> data) {
    double total = 0;

    for (var item in data) {
      try {
        double price = double.tryParse(item['price'].toString()) ?? 0;
        int quantity = int.tryParse(item['quantity'].toString()) ?? 0;
        total += price * quantity;
        print(
            '=============   Price: $price, Quantity: $quantity, Total: $total');
      } catch (e) {
        print('Error calculating total price: $e');
      }
    }

    return total.toStringAsFixed(2);
  }
}
