import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantbazar/model/address_model.dart';

class AddressProvider extends ChangeNotifier {
  Future<void> uploadAddressToFirebase({
    required AddressModel value,
    required BuildContext? context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('Address').doc(value.id).set(
        {
          'id': value.id,
          'fullname': value.fullname,
          'pincode': value.pincode,
          'city': value.city,
          'state': value.state,
          'phone': value.phone,
          'house': value.house,
          'area': value.area,
        },
      );
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
      // Handle generic exceptions, e.g., network issues
      showSnackbar(context!, 'An unexpected error occurred. Please try again.');
      print("Failed to add product: $error");
      notifyListeners();
    }
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(bottom: 20.0),
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

  void deleteAddress(String id) async {
    int _check = int.parse(id);
    if (_check == 1) {
      await FirebaseFirestore.instance
          .collection('default_address')
          .doc(id)
          .delete();
    } else {
      await FirebaseFirestore.instance.collection('Address').doc(id).delete();
    }
  }

  void editAddress(AddressModel value) async {
    int _check = int.parse(value.id.toString());
    if (_check == 1) {
      await FirebaseFirestore.instance
          .collection('default_address')
          .doc(value.id)
          .update(
        {
          'id': value.id,
          'fullname': value.fullname,
          'pincode': value.pincode,
          'city': value.city,
          'state': value.state,
          'phone': value.phone,
          'house': value.house,
          'area': value.area,
        },
      );
    } else {
      print('====================error');
    }
    await FirebaseFirestore.instance.collection('Address').doc(value.id).update(
      {
        'id': value.id,
        'fullname': value.fullname,
        'pincode': value.pincode,
        'city': value.city,
        'state': value.state,
        'phone': value.phone,
        'house': value.house,
        'area': value.area,
      },
    );
  }
}

class AddressEditProvider extends ChangeNotifier {
  late TextEditingController stateController;
  late TextEditingController areaController;
  late TextEditingController cityController;
  late TextEditingController houseController;
  late TextEditingController landmarkController;
  late TextEditingController phoneController;
  late TextEditingController fullNameController;
  late TextEditingController pincodeController;

  AddressEditProvider({
    required String initialState,
    required String initialArea,
    required String initialCity,
    required String initialHouse,
    required String initialLandmark,
    required String initialPhone,
    required String initialFullName,
    required String initialPincode,
  }) {
    stateController = TextEditingController(text: initialState);
    areaController = TextEditingController(text: initialArea);
    cityController = TextEditingController(text: initialCity);
    houseController = TextEditingController(text: initialHouse);
    landmarkController = TextEditingController(text: initialLandmark);
    phoneController = TextEditingController(text: initialPhone);
    fullNameController = TextEditingController(text: initialFullName);
    pincodeController = TextEditingController(text: initialPincode);
  }
}
