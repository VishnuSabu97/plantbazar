
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plantbazar/view/home/indoor/indoor.dart';
import 'package:plantbazar/view/home/outdoor/outdoor.dart';
import 'package:plantbazar/view/home/screens/home/home_grid.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({
    super.key,
    required this.productCollection,
  });

  final CollectionReference<Object?> productCollection;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white30),
      child: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              height: 180,


              child: Image.asset(
                'assets/img/abcde.png',
             //   fit: BoxFit.cover,
                height: MediaQuery.of(context).size.width*0.8,
              ),
            ),
            SizedBox(
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 10),
                    child: Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const OutdoorScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              elevation: 8,
                              shadowColor: Colors.grey,
                              backgroundColor: Colors.green),
                          child: const Text(
                            'Outdoor',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const IndoorScreen(),

                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            elevation: 8,
                            shadowColor: Colors.grey,
                            backgroundColor: Colors.green),
                        child: const Text('Indoor'),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 9.0,
                      left: 14,
                    ),
                    child: Text(
                      'All',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            HomeScreenGrid(productCollection: productCollection),
          ],
        );
      }),
    );
  }
}
