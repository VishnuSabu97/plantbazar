import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  List<ProductClass> indoorProducts = [];
  List<ProductClass> outdoorProducts = [];

  Future<void> fetchProducts() async {
    indoorProducts = await _fetchProductsByCategory('Indoor');

    outdoorProducts = await _fetchProductsByCategory('Outdoor');

    notifyListeners();
  }

  Future<List<ProductClass>> _fetchProductsByCategory(String category) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Products')
        .where('category', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => ProductClass.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
