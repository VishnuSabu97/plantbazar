import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200.0,
        height: 100.0,
        child: Shimmer.fromColors(
          baseColor: const Color.fromARGB(255, 89, 244, 54),
          highlightColor: Colors.yellow,
          child: const Text(
            'Gardenia',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
