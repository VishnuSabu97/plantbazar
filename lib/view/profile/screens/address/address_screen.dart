import 'package:flutter/material.dart';
import 'package:plantbazar/model/address_model.dart';
import 'package:plantbazar/provider/address/address_provider.dart';
import 'package:plantbazar/shared/common_widget/common_button.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:provider/provider.dart';

class ScreenAddNewAddress extends StatelessWidget {
  const ScreenAddNewAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add delivery address',
        ),
        centerTitle: true,
      ),
      body: const AddressForm(),
    );
  }
}

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  AddressFormState createState() => AddressFormState();
}

class AddressFormState extends State<AddressForm> {
  bool isDefault = false;
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  _fullNameController,
                  'Full Name(required)',
                  'Enter your full name',
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextField(
                  _pincodeController,
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
                  _cityController,
                  'City Name(required)',
                  'Enter your home city',
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: _buildTextField(
                  _stateController,
                  'State (required)',
                  'Enter your State',
                ),
              ),
            ],
          ),
          kHeight20,
          _buildTextField(
            _phoneController,
            'Phone Number(required)',
            'Enter your phone number',
          ),
          kHeight20,
          _buildTextField(
            _landmarkController,
            'House no. Building name(required)',
            'Enter your landmark',
          ),
          kHeight20,
          _buildTextField(
            _houseController,
            'House name',
            'Enter your House name',
            obscureText: true,
          ),
          kHeight20,
          _buildTextField(
            _areaController,
            'Area',
            'Enter your Area',
            obscureText: true,
          ),
          kHeight50,
          CommonButton(
              name: 'Save Address',
              voidCallback: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final addressModel = AddressModel(
                    area: _areaController.text.trim(),
                    city: _cityController.text.trim(),
                    fullname: _fullNameController.text.trim(),
                    house: _houseController.text.trim(),
                    id: uniqueFileName,
                    phone: _phoneController.text.trim(),
                    pincode: _pincodeController.text.trim(),
                    state: _stateController.text.trim(),
                  );

                  context.read<AddressProvider>().uploadAddressToFirebase(
                      value: addressModel, context: context);
                  debugPrint(
                      'Address sending to firebase============================');
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
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
