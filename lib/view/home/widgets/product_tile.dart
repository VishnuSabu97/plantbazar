import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/wishlist_model.dart';
import 'package:plantbazar/provider/wishlist/wishlist_provider.dart';
import 'package:plantbazar/shared/product_discription.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatefulWidget {
  final String name;
  final String subname;
  final String rate;
  final String image;
  final String description;
  final String id;
  const ProductTile({
    Key? key,
    required this.id,
    required this.name,
    required this.subname,
    required this.rate,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  bool isAddedToWishlist = false;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WishlistProvider>(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDiscription(
              id: widget.id,
              name: widget.name,
              price: widget.rate,
              category: widget.subname,
              discription: widget.description,
              img: widget.image,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width / 2.2,
            height: size.height / 4.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: size.width / 3.2,
                  top: 2,
                  child: IconButton(
                    icon: Icon(
                      provider.isAddedToWishlist
                          ? CupertinoIcons.suit_heart_fill
                          : CupertinoIcons.heart,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () async {
                      final _value = WishlistModel(
                        category: widget.subname,
                        description: widget.description,
                        id: widget.id,
                        imageUrl: widget.image,
                        name: widget.name,
                        price: widget.rate,
                      );
                      context
                          .read<WishlistProvider>()
                          .addToWishlist(value: _value, context: context);
                    },
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              letterSpacing: .5,
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            widget.subname,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 12,
                color: Colors.black54,
                fontWeight: FontWeight.w700),
          ),
          Text(
            "₹${widget.rate}.00",
            style: const TextStyle(
                letterSpacing: .5,
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}
