import 'package:flutter/material.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/provider/search/search_provider.dart';
import 'package:plantbazar/view/search/widget/search_card.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Consumer<SearchProvider>(
          builder: (context, provider, widget) {
            return FutureBuilder<List<ProductClass>>(
              future: provider.getProductsByPriceRange(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final listProduct = snapshot.data;
                  return SearchCard(
                    searchResults: listProduct,
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
