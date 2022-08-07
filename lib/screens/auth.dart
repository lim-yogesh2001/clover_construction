import 'package:clover_construction/constants/theme.dart';
import 'package:clover_construction/models/http_exception.dart';
import 'package:clover_construction/providers/auth.dart';
import 'package:clover_construction/screens/home.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

enum AuthCategory { Login, Register }

class AuthScreen extends StatelessWidget {
  static const routeName = 'auth-screen';
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color(0xffde6262),
                Color(0xffffb88c),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              width: deviceSize.width,
              height: deviceSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 50.0),
                    transform: Matrix4.rotationZ(-9 * pi / 180)
                      ..translate(-8.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade900,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black54,
                              offset: Offset(0, 2))
                        ]),
                    child: const Text(
                      "Clover Construction",
                      style: TextStyle(
                          fontFamily: 'Lato-Bold',
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                  )),
                  Flexible(child: AuthCard()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _passwordFocuseNode = FocusNode();
  final _fullNameNode = FocusNode();
  final _phoneNumNode = FocusNode();
  final _emailNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  var _isLoading = false;

  Map<String, String> _loginData = {
    'username': '',
    'password': '',
  };

  Map<String, String> _registerData = {
    'username': '',
    'password': '',
    'full name': '',
    'phone number': '',
    'email': '',
  };

  AuthCategory _authChoice = AuthCategory.Login;

  void _switchAuth(AuthCategory choice) {
    if (choice == AuthCategory.Login) {
      setState(() {
        _authChoice = AuthCategory.Login;
      });
    } else {
      setState(() {
        _authChoice = AuthCategory.Register;
        print(_authChoice);
      });
    }
  }

  void _showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text(
                'Warning!',
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: 'Lato-Bold',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: Text(
                message,
                style: TextStyle(fontSize: 16.0),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("Okay"))
              ],
            ));
  }

  Future<void> _saveForm() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authChoice == AuthCategory.Login) {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(_loginData['username']!, _loginData['password']!);
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        await Provider.of<AuthProvider>(context, listen: false).register(
          _registerData['username']!,
          _registerData['password']!,
          _registerData['full name']!,
          _registerData['phone number']!,
          _registerData['email']!,
        );
        setState(() {
          _authChoice = AuthCategory.Login;
        });
      }
    } on HttpException catch (error) {
      var errorMessage = "Something Went Wrong.";
      if (error
          .toString()
          .contains('Unable to Register with provided credentials')) {
        errorMessage =
            "The username you have used has already been used by someone.";
      } else if (error
          .toString()
          .contains('Unable to Login with provided credentials')) {
        errorMessage = "You have entered a wrong username or password";
      }
      _showErrorMessage(errorMessage);
    } catch (error) {
      const errorMessage = "Could not authenticate! Something went wrong";
      _showErrorMessage(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _passwordFocuseNode.dispose();
    _fullNameNode.dispose();
    _phoneNumNode.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 5.0,
      child: Container(
        color: Colors.transparent,
        height: _authChoice == AuthCategory.Register ? 600 : 250,
        width: deviceSize.width * 0.88,
        padding: EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(
                        fontFamily: 'Lato-Regular',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                      label: Text(
                        "Username",
                        style: TextStyle(
                            fontFamily: 'Lato-Light',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please do not leave the field empty.";
                      }
                      if (value.length < 2) {
                        return "Please enter characters greater than 2.";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocuseNode);
                    },
                    onSaved: (value) {
                      if (_authChoice == AuthCategory.Login) {
                        _loginData['username'] = value!;
                      } else {
                        _registerData['username'] = value!;
                      }
                    },
                  ),
                  TextFormField(
                    style: const TextStyle(
                        fontFamily: 'Lato-Regular',
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            fontFamily: 'Lato-Light',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w300)),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please do not leave the field empty.';
                      }
                      if (value.length < 4) {
                        return 'Please have the character of password greater than 7.';
                      }
                      return null;
                    },
                    focusNode: _passwordFocuseNode,
                    onFieldSubmitted: _authChoice == AuthCategory.Register
                        ? (_) {
                            FocusScope.of(context).requestFocus(_fullNameNode);
                          }
                        : null,
                    textInputAction: _authChoice == AuthCategory.Register
                        ? TextInputAction.next
                        : TextInputAction.done,
                    onSaved: (value) {
                      if (_authChoice == AuthCategory.Login) {
                        _loginData['password'] = value!;
                      } else {
                        _registerData['password'] = value!;
                      }
                    },
                  ),
                  if (_authChoice == AuthCategory.Register)
                    Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(
                              fontFamily: 'Lato-Regular',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                              labelText: "Full Name",
                              labelStyle: TextStyle(
                                  fontFamily: 'Lato-Light',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300)),
                          focusNode: _fullNameNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please do not leave the field empty';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_phoneNumNode);
                          },
                          onSaved: (value) {
                            _registerData['full name'] = value!;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(
                              fontFamily: 'Lato-Regular',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                              label: Text("Phone number"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Lato-Light',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300)),
                          focusNode: _phoneNumNode,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please do not leave the field empty.';
                            }
                            if (value.length < 10) {
                              return 'Phone number should have a length of 10 characters.';
                            }
                            if (!value.startsWith('9') &&
                                int.tryParse(value) == null) {
                              return 'Please Enter valid format of phone number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_emailNode),
                          onSaved: (value) {
                            _registerData['phone number'] = value!;
                          },
                        ),
                        TextFormField(
                          style: const TextStyle(
                              fontFamily: 'Lato-Regular',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500),
                          decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(
                                  fontFamily: 'Lato-Light',
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300)),
                          validator: (value) {
                            if (value!.isEmpty && !value.contains('@')) {
                              return "Please enter a valid email";
                            }
                          },
                          onSaved: ((value) => _registerData['email'] = value!),
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailNode,
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (_authChoice == AuthCategory.Register)
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text("Already Have an account?"),
                          const SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _switchAuth(AuthCategory.Login);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: textHighlighter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_authChoice == AuthCategory.Login)
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          const Text("Are you new?"),
                          const SizedBox(
                            width: 8.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              _switchAuth(AuthCategory.Register);
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                color: textHighlighter,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_isLoading)
                    const CircularProgressIndicator()
                  else
                    MaterialButton(
                      minWidth: 150,
                      color: Colors.cyan,
                      onPressed: _saveForm,
                      child: _authChoice == AuthCategory.Register
                          ? const Text("Register")
                          : const Text("Login"),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
