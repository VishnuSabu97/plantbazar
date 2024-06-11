import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  // var _isAuthenticating = false;
  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication faild'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'PlantBazar',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Log in or Sign up to continue',
                    style: TextStyle(),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 400,
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              gapPadding: double.maxFinite,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)))),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address.';
                        }

                        return null;
                      },
                      onSaved: (value) {
                        _enteredEmail = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 400,
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder(
                          gapPadding: double.maxFinite,
                          borderRadius:
                          BorderRadius.all(Radius.circular(25))
                      )),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(
                        () {
                          _isLogin = !_isLogin;
                        },
                      );
                    },
                    child: Text(_isLogin
                        ? 'Create an account'
                        : 'I already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
