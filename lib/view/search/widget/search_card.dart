import 'package:flutter/material.dart';
import 'package:plantbazar/model/cart_model.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/model/wishlist_model.dart';
import 'package:plantbazar/provider/cart/cart_provider.dart';
import 'package:plantbazar/provider/wishlist/wishlist_provider.dart';
import 'package:plantbazar/shared/product_discription.dart';
import 'package:provider/provider.dart';

class SearchCard extends StatelessWidget {
  const SearchCard({
    super.key,
    this.searchResults,
  });

  final List<ProductClass>? searchResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: searchResults!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // final er = searchResults![index];
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDiscription(
                  category: searchResults![index].category ?? "outdoor",
                  discription:
                      searchResults![index].description ?? "description",
                  id: searchResults![index].id ?? "null",
                  img: searchResults![index].imageUrl ?? 'null',
                  name: searchResults![index].name ?? "name",
                  price: searchResults![index].price ?? "null",
                ),
              ),
            );
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network(
                      searchResults![index].imageUrl ?? '',
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          searchResults![index].name ?? 'name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            '₹ ${searchResults![index].price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                                'Category: ${searchResults![index].category ?? 'category'} '),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          final addToCart = CartModel(
                            name: searchResults![index].name,
                            price: searchResults![index].price,
                            category: searchResults![index].category,
                            description: searchResults![index].description,
                            imageUrl: searchResults![index].imageUrl,
                            id: "324",
                            quantity: '1',
                          );
                          context
                              .read<CartProvider>()
                              .addToCart(context: context, value: addToCart);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () {
                          final _value = WishlistModel(
                            name: searchResults![index].name,
                            price: searchResults![index].price,
                            category: searchResults![index].category,
                            description: searchResults![index].description,
                            imageUrl: searchResults![index].imageUrl,
                            id: "324",
                            quantity: '1',
                          );
                          context
                              .read<WishlistProvider>()
                              .addToWishlist(value: _value, context: context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
