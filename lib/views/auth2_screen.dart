import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class Auth2Screen extends StatefulWidget {
  @override
  State<Auth2Screen> createState() => _Auth2ScreenState();
}

class _Auth2ScreenState extends State<Auth2Screen> {
  // List arguments = Get.arguments;

  var _emailController = TextEditingController();

  var _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _save(String email, String password) {
    // Save for each field save
    if (email.isEmpty) {
      return;
    }
    // var controller = context.read(playerProvider);
    // if (arguments[0] == "form_edit") {
    //   controller.updatePlayerName(arguments[1], name);
    // } else {
    //   controller.addPlayerForm(
    //     name: name,
    //   );
    //   controller.fetchPlayer();
    // }
    // Get.back(result: "player_form");
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // if (arguments[0] == "form_edit") {
    //    _nameController =
    //       TextEditingController(text: arguments[2].toString());
    //   _winsController =
    //       TextEditingController(text: arguments[3].toString());
    // }
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black54
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
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                    // transform: Matrix4.rotationZ(-8 * pi / 180)
                    //   ..translate(-10.0),
                    // ..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).appBarTheme.backgroundColor,
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
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        )),
                  ),
                ),
                Flexible(
                 flex: deviceSize.width > 600 ? 2 : 1, 
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8.0,
                    child: Container(
                      height: 260,
                      constraints: BoxConstraints(
                          minHeight: 260),
                      width: deviceSize.width * 0.75,
                      padding: EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Name
                            FormWidgets.formTextInputValidation(
                                context: context,
                                controller: _emailController,
                                labelText: "Email",
                                hintText: 'Email Address (Required)',
                                maxLength: 20,
                                blankFieldMessage: "Fill in the Email"),
                            FormWidgets.formTextInputValidation(
                                context: context,
                                controller: _passwordController,
                                labelText: "Password",
                                hintText: 'Password (Required)',
                                maxLength: 20,
                                blankFieldMessage:
                                    "Fill in the Password"), // Submit Button
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _save(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
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
  }
}
