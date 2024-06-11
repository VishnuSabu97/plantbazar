import 'package:flutter/material.dart';

class AccountTile extends StatelessWidget {
  AccountTile(
      {super.key,
      required this.icon,
      required this.name,
      required this.voidCallback});
  final IconData icon;
  final String name;
  VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, left: 17),
        child: Row(
          children: [
            Icon(
              icon,
              size: 35,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
