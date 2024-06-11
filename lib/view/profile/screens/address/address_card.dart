import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/view/profile/screens/address/add_edit_buttons.dart';

class AddressCard extends StatelessWidget {
  AddressCard({
    Key? key,
    required this.size,
    required this.id,
    required this.fullname,
    required this.pincode,
    required this.city,
    required this.state,
    required this.phone,
    required this.house,
    required this.area,
  }) : super(key: key);
  String id;
  String fullname;
  String pincode;
  String city;
  String state;
  String phone;
  String house;
  String area;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromARGB(255, 216, 215, 215),
        ),
        height: size.height / 3.3,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 90, top: 9),
                child: Text(
                  'Name: $fullname',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
                child: Text(
                  'Address: ${house}, ${area}, ${city}, ${state}, ${pincode}, ',
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 85, top: 4),
                child: Text(
                  'Phone Number: ${phone}',
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  maxLines: 4,
                ),
              ),
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('default_address')
                      .doc('1')
                      .set(
                    {
                      'id': id,
                      'fullname': fullname,
                      'pincode': pincode,
                      'city': city,
                      'state': state,
                      'phone': phone,
                      'house': house,
                      'area': area,
                    },
                  );
                },
                child: const Text('Make this default'),
              ),
              AddEditAddressButtons(
                state: state,
                area: area,
                city: city,
                fullname: fullname,
                house: house,
                phone: phone,
                pincode: pincode,
                id: id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
