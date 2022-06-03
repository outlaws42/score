import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../models/http_exception.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // List arguments = Get.arguments;

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showErrorDialog(String message) {
    Get.defaultDialog(
      title: 'An Error Ocurred',
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Ok'),
        ),
      ],
    );
  }

  Future<void> _save(provider) async {
    // Save for each field save
    if (_emailController.text.isEmpty) {
      return;
    }
    try {
      if (_formKey.currentState!.validate()) {
        await provider.login(
          _emailController.text,
          _passwordController.text,
        );
      }
    } on HttpException catch (error) {
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('USER_NOT_FOUND')) {
        errorMessage = 'This is not a valid user';
      } else if (error.toString().contains('LOGIN_NOT_FOUND')) {
        errorMessage = 'Please provide a email and password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      var errorMessage = 'Could not authenticate you. Please try again later';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, String> _authData = {'email': '', 'password': '',};
    // context.read(authProvider).signup(_authData['email'], _authData['password']);
    final deviceSize = MediaQuery.of(context).size;
    // if (arguments[0] == "form_edit") {
    //    _nameController =
    //       TextEditingController(text: arguments[2].toString());
    //   _winsController =
    //       TextEditingController(text: arguments[3].toString());
    // }
    return Consumer(
      builder: (context, ref, child) {
        final value = ref(authProvider);
        return Scaffold(
          body: Stack(children: [
            Container(
              decoration: BoxDecoration(color: Colors.black54
                  // gradient: LinearGradient(
                  //   colors: [
                  //     Color.fromARGB(255, 234, 227, 237).withOpacity(0.5),
                  //     Color.fromARGB(255, 67, 58, 49).withOpacity(0.9),
                  //   ],
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   stops: [0, 1],
                  // ),
                  ),
            ),
            SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Flexible(
                    //   child: Container(
                    //     margin: EdgeInsets.only(bottom: 20.0),
                    //     padding:
                    //         EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                    //     // transform: Matrix4.rotationZ(-8 * pi / 180)
                    //     //   ..translate(-10.0),
                    //     // ..translate(-10.0),
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       color: Theme.of(context).appBarTheme.backgroundColor,
                    //       boxShadow: [
                    //         BoxShadow(
                    //           blurRadius: 8,
                    //           color: Colors.black26,
                    //           offset: Offset(0, 2),
                    //         )
                    //       ],
                    //     ),
                    //     child: Text('Score',
                    //         style: TextStyle(
                    //           color: Colors.white,
                    //           fontSize: 50,
                    //           fontFamily: 'Anton',
                    //           fontWeight: FontWeight.normal,
                    //         )),
                    //   ),
                    // ),
                    Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 8.0,
                        child: Container(
                          height: 320,
                          constraints: BoxConstraints(minHeight: 320),
                          width: deviceSize.width * 0.75,
                          padding: EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 20.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 50.0),
                                  // transform: Matrix4.rotationZ(-8 * pi / 180)
                                  //   ..translate(-10.0),
                                  // ..translate(-10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context)
                                        .appBarTheme
                                        .backgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 8,
                                        color: Colors.black26,
                                        offset: Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Text('Score',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        // fontFamily: 'Anton',
                                        fontWeight: FontWeight.bold,
                                      )),
                                ),
                                // Email
                                FormWidgets.formTextInputValidation(
                                    context: context,
                                    controller: _emailController,
                                    labelText: "Email",
                                    hintText: 'Email Address (Required)',
                                    maxLength: 20,
                                    blankFieldMessage: "Fill in the Email"),
                                // Password
                                FormWidgets.formTextInputValidation(
                                  context: context,
                                  controller: _passwordController,
                                  labelText: "Password",
                                  hintText: 'Password (Required)',
                                  maxLength: 20,
                                  blankFieldMessage: "Fill in the Password",
                                  obscure: true,
                                ),
                                // Submit Button
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      _save(value);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      onPrimary: Colors.white,
                                      primary: Theme.of(context)
                                          .appBarTheme
                                          .backgroundColor,
                                    ),
                                    icon: Icon(Icons.person),
                                    label: Text('Login'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        );
      },
    );
  }
}