import 'package:flutter/material.dart';
import 'package:plantbazar/provider/address/address_provider.dart';
import 'package:plantbazar/shared/common_widget/common_button.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:provider/provider.dart';
import '../../../../model/address_model.dart';

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen(
      {required this.id,
      required this.fullname,
      required this.pincode,
      required this.city,
      required this.state,
      required this.phone,
      required this.house,
      required this.area,
      Key? key})
      : super(key: key);
  String id;
  String fullname;
  String pincode;
  String city;
  String state;
  String phone;
  String house;
  String area;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddressEditProvider(
          initialState: state,
          initialArea: area,
          initialCity: city,
          initialHouse: house,
          initialLandmark: city,
          initialPhone: phone,
          initialFullName: fullname,
          initialPincode: pincode),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add delivery address',
          ),
          centerTitle: true,
        ),
        body: AddressEditForm(id: id),
      ),
    );
  }
}

class AddressEditForm extends StatelessWidget {
  AddressEditForm({required this.id, Key? key}) : super(key: key);
  String id;
  bool isDefault = false;
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressEditProvider>(
      builder: (context, provider, widget) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              kHeight30,
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      provider.fullNameController,
                      'Full Name(required)',
                      'Enter your full name',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTextField(
                      provider.pincodeController,
                      'Pincode (required)',
                      'Enter Pincode',
                    ),
                  ),
                ],
              ),
              kHeight20,
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      provider.cityController,
                      'City Name(required)',
                      'Enter your home city',
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _buildTextField(
                      provider.stateController,
                      'State (required)',
                      'Enter your State',
                    ),
                  ),
                ],
              ),
              kHeight20,
              _buildTextField(
                provider.phoneController,
                'Phone Number(required)',
                'Enter your phone number',
              ),
              kHeight20,
              _buildTextField(
                provider.cityController,
                'House no. Building name(required)',
                'Enter your landmark',
              ),
              kHeight20,
              _buildTextField(
                provider.houseController,
                'House name',
                'Enter your House name',
                obscureText: true,
              ),
              kHeight20,
              _buildTextField(
                provider.areaController,
                'Area',
                'Enter your Area',
                obscureText: true,
              ),
              kHeight50,
              CommonButton(
                  name: 'Update Address',
                  voidCallback: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final addressModel = AddressModel(
                        area: provider.areaController.text.trim(),
                        city: provider.cityController.text.trim(),
                        fullname: provider.fullNameController.text.trim(),
                        house: provider.houseController.text.trim(),
                        phone: provider.phoneController.text.trim(),
                        pincode: provider.pincodeController.text.trim(),
                        state: provider.stateController.text.trim(),
                        id: id,
                      );
                      print(provider.fullNameController.text);
                      print(addressModel.city);
                      context.read<AddressProvider>().editAddress(addressModel);
                      debugPrint(
                          'update address========== = = = $id===============');
                      Navigator.of(context).pop();
                    }
                  })
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    String hint, {
    bool obscureText = false,
  }) {
    TextInputType keyboardType = TextInputType.text;
    if (label == 'Age' || label == 'Phone Number') {
      keyboardType = TextInputType.number;
    }
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.white70,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
