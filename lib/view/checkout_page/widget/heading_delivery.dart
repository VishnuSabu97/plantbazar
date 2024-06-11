import 'package:flutter/material.dart';
import 'package:plantbazar/view/profile/screens/address/address_screen.dart';


class DeliveryHeading extends StatelessWidget {
  const DeliveryHeading({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              SizedBox(
                width: size.width / 6,
              ),
              const Text(
                'Delivery Address',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            color: Colors.white60,
            width: double.infinity,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ScreenAddNewAddress(),
                    ),
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add),
                    Text(
                      'Click here to add address',
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
