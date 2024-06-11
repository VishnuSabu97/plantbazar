import 'package:flutter/material.dart';
import 'package:plantbazar/provider/indoor_outdoor/indoor_outdoor_provider.dart';
import 'package:plantbazar/view/search/widget/search_card.dart';
import 'package:provider/provider.dart';

class IndoorScreen extends StatelessWidget {
  const IndoorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CategoryProvider>().fetchProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Indoor plants'),
        centerTitle: true,
      ),
      body: Consumer<CategoryProvider>(builder: (context, provider, widget) {
        final indoorlist = provider.indoorProducts;
        return ListView(
          children: [
            SearchCard(
              searchResults: indoorlist,
            )
          ],
        );
      }),
    );
  }
}
