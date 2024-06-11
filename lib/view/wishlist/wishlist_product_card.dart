import 'package:flutter/material.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.constraints,
    required this.name,
    required this.price,
  });
  final String name;
  final String price;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Container(
        width: constraints.maxWidth,
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse3.mm.bing.net%2Fth%3Fid%3DOIP.8JpeNaTXEvw3UCcRe0IbOQHaIz%26pid%3DApi&f=1&ipt=26bb7939adac561ef3f061851faaef6da51a1e39a93709226c0334946a7cf612&ipo=images', // Replace with your product image URL
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹99.99',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
