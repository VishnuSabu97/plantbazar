import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/order_model.dart';
import 'package:plantbazar/view/profile/screens/orders/order_detiles.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/order_status_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Screen'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Order').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Shimmer loading state
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView(
                children: List.generate(
                  10,
                  (index) => Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      color: Colors.grey[300],
                      height: 150,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<OrderModel> orders = snapshot.data!.docs
                .map(
                  (doc) =>
                      OrderModel.fromJson(doc.data() as Map<String, dynamic>),
                )
                .toList();

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                OrderModel order = orders[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      if (order.status == 'Pending' ||
                          order.status == 'Shipped') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                              buttonName: 'Return',
                              orderStatus: () {},
                              isDelivered: true,
                              order: order,
                            ),
                          ),
                        );
                      } else
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderDetailsScreen(
                              buttonName: 'Cancel',
                              orderStatus: () {},
                              isDelivered: true,
                              order: order,
                            ),
                          ),
                        );
                    },
                    child: OrderCard(order: order),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
