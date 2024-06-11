// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gardenia/model/address_model.dart';

// Future<void> uploadAddressToFirebase({
//   required AddressModel value,
//   required String imgUrl,
//   required BuildContext? context,
// }) async {
//   try {
//     await FirebaseFirestore.instance.collection('Products').doc(value.id).set(
//       {
//         'id': value.id,
//         'fullname': value.fullname,
//         'pincode': value.pincode,
//         'city': value.city,
//         'state': value.state,
//         'phone': value.phone,
//         'house': value.house,
//         'area': value.area,
//       },
//     );
//   } on FirebaseException catch (error) {
//     String errorMessage = 'An error occurred while adding the product.';

//     if (error.code == 'permission-denied') {
//       errorMessage =
//           'Permission denied. You do not have the necessary permissions.';
//     } else if (error.code == 'not-found') {
//       errorMessage = 'The requested document was not found.';
//     }

//     showSnackbar(context!, errorMessage);
//     print("Failed to add product: $error");
//   } catch (error) {
//     // Handle generic exceptions, e.g., network issues
//     showSnackbar(context!, 'An unexpected error occurred. Please try again.');
//     print("Failed to add product: $error");
//   }
// }

// void showSnackbar(BuildContext context, String message) {
//   final snackBar = SnackBar(
//     behavior: SnackBarBehavior.floating,
//     margin: const EdgeInsets.only(bottom: 100.0),
//     content: Text(message),
//     action: SnackBarAction(
//       label: 'Dismiss',
//       onPressed: () {
//         ScaffoldMessenger.of(context).hideCurrentSnackBar();
//       },
//     ),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
