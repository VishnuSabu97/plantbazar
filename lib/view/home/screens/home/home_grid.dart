import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/view/home/widgets/product_tile.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenGrid extends StatelessWidget {
  const HomeScreenGrid({
    Key? key,
    required this.productCollection,
  }) : super(key: key);

  final CollectionReference<Object?> productCollection;

  Future<List<ProductClass>> fetchProducts() async {
    List<ProductClass> productList = [];

    try {
      var productCollectionSnapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      if (productCollectionSnapshot.docChanges.isNotEmpty) {
        productList = productCollectionSnapshot.docs.map(
          (doc) {
            Map<String, dynamic> data = doc.data();
            return ProductClass.fromJson(data);
          },
        ).toList();
      } else {
        debugPrint("Error: Product collection snapshot is null");
      }
    } catch (e) {
      debugPrint("Error fetching products===+++++++====: $e");
    }

    return productList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchProducts(),
      builder: (context, AsyncSnapshot<List<ProductClass>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.0 / 4.0,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: const ProductTileShimmer(),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Products'),
          );
        } else {
          List<ProductClass> productList = snapshot.data!;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3.0 / 4.0,
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
            ),
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ProductTile(
                id: productList[index].id.toString(),
                name: productList[index].name ?? 'Empty',
                subname: productList[index].category ?? 'Empty',
                rate: productList[index].price ?? 'Empty',
                image: productList[index].imageUrl ??
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9k33VDGg4WcrLISmAosSXtH9LnRke9pcaBQ&usqp=CAU",
                description: productList[index].description ?? "empty",
              );
            },
          );
        }
      },
    );
  }
}

class ProductTileShimmer extends StatelessWidget {
  const ProductTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.grey[300],
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.grey[300],
              height: 16.0,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}
