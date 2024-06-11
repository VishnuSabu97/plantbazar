import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/product_model.dart';

class SearchProvider extends ChangeNotifier {
  String? value;
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');

  Future<List<ProductClass>> getProductsByPriceRange() async {
    QuerySnapshot querySnapshot = await _productsCollection
        .orderBy(
          'price',
        )
        .get();

    List<ProductClass> productList = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      productList
          .add(ProductClass.fromJson(doc.data() as Map<String, dynamic>));
    }

    return productList;
  }
}
