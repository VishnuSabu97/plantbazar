import 'package:flutter/material.dart';
import 'package:plantbazar/model/order_model.dart';
import 'package:plantbazar/shared/core/constants.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;
  VoidCallback orderStatus;
  bool isDelivered;
  String buttonName;
  OrderDetailsScreen(
      {super.key,
      required this.order,
      required this.orderStatus,
      required this.isDelivered,
      required this.buttonName});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final String productDelivered = 'Product is delivered';
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.height / 23,
              decoration: BoxDecoration(border: Border.all(width: 0.1)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Order ID: OD${widget.order.orderId}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                ),
              ),
            ),
            kHeight40,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    children: [
                      Text(
                        ' ${widget.order.productName} ',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        '₹ ${widget.order.totalPrice} ',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.green),
                      ),
                      Text(
                        'Category: ${widget.order.category}',
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${widget.order.status}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.orange),
                          )
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Container(
                    color: Colors.amber,
                    width: size.width / 4,
                    height: size.height / 9,
                    child: Image.network(
                      '${widget.order.imageUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        content: const Text(
                            'Requst will be proceded with in few days'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Ok'),
                          )
                        ],
                      );
                    });
              },
              child: Text(widget.buttonName),
            ),
            Stepper(
              steps: [
                Step(
                  title: Text('Order Confirmed,  ${widget.order.date}'),
                  content: const Text(
                    'Your Order has been placed \n Seller will process your order soon',
                  ),
                ),
                const Step(
                  title: Text('Shipped'),
                  content: Text(
                      'Order will be shipped within\n 3 days after date of order'),
                ),
                const Step(
                  title: Text('Delivery'),
                  content: Text(
                    'Order is expected to deliver within 10 days after ordered date',
                  ),
                ),
              ],
              onStepTapped: (int newIndex) {
                setState(
                  () {
                    _currentStep = newIndex;
                  },
                );
              },
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep < 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep > 0) {
                  setState(
                    () {
                      _currentStep -= 1;
                    },
                  );
                }
              },
            )
            // : const Center(
            //     child: Text(
            //       'Product Cancelled',
            //       style: TextStyle(fontSize: 20),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle Cancel
          },
          child: const Text('Cancel Product'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Return
          },
          child: const Text('Return'),
        ),
      ],
    );
  }
}
