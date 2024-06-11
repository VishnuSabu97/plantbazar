import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:plantbazar/view/checkout_page/widget/heading_delivery.dart';
import 'package:plantbazar/view/profile/screens/address/address_card.dart';
import 'package:plantbazar/view/profile/screens/address/dafault_card.dart';

class ScreenAddress extends StatelessWidget {
  ScreenAddress({super.key});
  final CollectionReference addressCollection =
      FirebaseFirestore.instance.collection('Address');
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                kHeight20,
                DeliveryHeading(size: size),
                kHeight20,
                DefaultAddress(size: size),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: addressCollection.snapshots(),
                    builder: (context, snapshot) {
                      List<QueryDocumentSnapshot<Object?>> data = [];
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text('Add Address'),
                        );
                      }

                      data = snapshot.data!.docs;
                      if (snapshot.data!.docs.isEmpty || data.isEmpty) {
                        return const Center(
                          child: Text('Empty'),
                        );
                      }

                      return ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return AddressCard(
                            size: size,
                            area: data[index]['area'],
                            city: data[index]['city'],
                            fullname: data[index]['fullname'],
                            house: data[index]['house'],
                            id: data[index]['id'],
                            phone: data[index]['phone'],
                            pincode: data[index]["pincode"],
                            state: data[index]["state"],
                          );
                        },
                      );
                    },
                  ),
                ),
                kHeight50,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
