import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:plantbazar/view/home/screens/home/home_widget.dart';
import 'package:plantbazar/view/wishlist/wishlist.dart';
import 'package:plantbazar/view_model/fetch_product.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  ValueNotifier<bool> notifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    fetchProducts();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[100],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.green,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Wishlist',
              ),
            ],
          ),
          title: const Text('Welcome'),
        ),
        body: TabBarView(
          children: [
            HomeScreenWidget(productCollection: productCollection),
            WishlistScreen()
            // Icon(Icons.directions_transit, size: 350),
          ],
        ),
      ),
    );
  }
}
