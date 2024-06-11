import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartModel> cartList = [];

  addK(id, quantity) async {
    int num = int.parse(quantity);

    num++;
    await FirebaseFirestore.instance.collection('Cart').doc(id).update(
      {
        'quantity': num.toString(),
      },
    );
    notifyListeners();
  }

  reduceK(id, quantity) async {
    int num = int.parse(quantity);
    num--;
    if (num < 1) {
      await FirebaseFirestore.instance.collection('Cart').doc(id).delete();

      notifyListeners();
    }
    await FirebaseFirestore.instance.collection('Cart').doc(id).update(
      {
        'quantity': '$num',
      },
    );
    notifyListeners();
  }

  Future<void> addToCart({
    required CartModel value,
    required BuildContext? context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Cart').doc(value.id).set(
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
      showSnackbar(context!, "Product added to Cart");
      notifyListeners();
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

  Future<void> deleteCart({BuildContext? context, required String id}) async {
    return showDialog<void>(
      context: context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SingleChildScrollView(
            child: Text('Are sure you want to delete'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Cart')
                    .doc(id)
                    .delete();
                Navigator.of(context).pop();
                notifyListeners();
              },
            ), //'
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                notifyListeners();
              },
            ),
          ],
        );
      },
    );
  }
}
