import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'profile_body.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'Account',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: const ProfileBody(),
      ),
    );
  }
}
