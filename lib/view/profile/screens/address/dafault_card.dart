import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/view/profile/screens/address/add_edit_buttons.dart';

class DefaultAddress extends StatelessWidget {
  DefaultAddress({required this.size, super.key});

  final Size size;
  final CollectionReference _addressCollection =
      FirebaseFirestore.instance.collection('default_address');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 6,
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: const Color.fromARGB(255, 148, 148, 148),
              ),
              height: size.height / 4.1,
              width: double.infinity,
              child: StreamBuilder(
                  stream: _addressCollection.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data?.docs ?? [];
                    if (data.isEmpty) {
                      return const Center(
                        child: Text(
                          'No address found. Please add an address.',
                          style: TextStyle(fontSize: 17),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 90, top: 9),
                            child: Text(
                              'Name: ${data[0]['fullname']} (Default)',
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 85, top: 4),
                            child: Text(
                              'Address: ${data[0]['house']}, ${data[0]['area']}, ${data[0]['city']}, ${data[0]['state']}, ${data[0]['pincode']}, ',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              maxLines: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 85, top: 4),
                            child: Text(
                              'Phone Number: ${data[0]['phone']}',
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              maxLines: 4,
                            ),
                          ),
                          AddEditAddressButtons(
                            area: data[0]['area'],
                            city: data[0]['city'],
                            fullname: data[0]['fullname'],
                            house: data[0]['house'],
                            phone: data[0]['phone'],
                            pincode: data[0]['pincode'],
                            state: data[0]['state'],
                            id: '1',
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ],
    );
  }
}
