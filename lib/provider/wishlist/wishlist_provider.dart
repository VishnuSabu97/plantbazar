import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/wishlist_model.dart';
class WishlistProvider extends ChangeNotifier {
  bool isAddedToWishlist = false;
  Future<void> addToWishlist({
    required WishlistModel value,
    required BuildContext? context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('wishlist').doc(value.id).set(
        {
          'name': value.name,
          'price': value.price,
          'quantity': value.quantity,
          'description': value.description,
          'category': value.category,
          'imageUrl': value.imageUrl,
          'id': value.id,
        },
      );
      notifyListeners();
      showSnackbar(context!, 'Product added to Wishlist');
    } on FirebaseException catch (error) {
      String errorMessage = 'An error occurred while adding the product.';

      if (error.code == 'permission-denied') {
        errorMessage =
            'Permission denied. You do not have the necessary permissions.';
      } else if (error.code == 'not-found') {
        errorMessage = 'The requested document was not found.';
      }

      showSnackbar(context!, errorMessage);
      print("Failed to add product: $error");
      notifyListeners();
    } catch (error) {
      showSnackbar(context!, 'An unexpected error occurred. Please try again.');
      print("Failed to add product: $error");
      notifyListeners();
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 10.0),
      content: Text(message),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    notifyListeners();
  }

  deleteWishlist({required String id, required BuildContext context}) async {
    await FirebaseFirestore.instance.collection('wishlist').doc(id).delete();
    showSnackbar(context, 'Removed from');
    notifyListeners();
  }

  checkIfIdExists(String id) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('wishlist');

      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(id).get();

      isAddedToWishlist = documentSnapshot.exists;
    } catch (e) {
      print("Error checking if id exists: $e");
      isAddedToWishlist = false;
    }
  }
}
