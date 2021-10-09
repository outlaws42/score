import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
// import '../controllers/player_provider.dart';
import '../helpers/custom_widgets/form_widgets.dart';

class PlayerForm extends StatefulWidget {
  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  List arguments = Get.arguments;

  var _nameController = TextEditingController();

  var _winsController = TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();

  void _save(String name, int wins) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    int _dtUtcMs = DateTime.now().toUtc().millisecondsSinceEpoch;
    var controller = context.read(playerProvider);
    if (arguments[0] == "form_edit") {
      controller.updatePlayerName(arguments[1], name);
    } else {
      controller.addPlayerForm(
        name: name,
        wins: wins,
        dateTime: _dtUtcMs,
      );
      controller.fetchPlayer();
    }
    Get.back(result: "player_form");
  }

  @override
  Widget build(BuildContext context) {
    // final form = arguments[0];
    if (arguments[0] == "form_edit") {
       _nameController =
          TextEditingController(text: arguments[2].toString());
      _winsController =
          TextEditingController(text: arguments[3].toString());
    }
    print(arguments);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          arguments[0] == "form_edit" ? "Edit Player" : "Add Player",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Player Information',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              // Name
              FormWidgets.formTextInputValidation(
                  context: context,
                  controller: _nameController,
                  labelText: "Name",
                  hintText: 'Players name (Required)',
                  maxLength: 20,
                  blankFieldMessage: "Fill in the Name"),

              // Wins
              // FormWidgets.formTextInput(
              //   context: context,
              //   controller: _winsController,
              //   labelText: "Wins",
              //   hintText: 'Players previous wins (optional)',
              //   maxLength: 2,
              // ),
              // Submit Button
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _save(
                        _nameController.text,
                        int.parse(_winsController.text),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  icon: Icon(Icons.person),
                  label: arguments[0] == "form_edit"
                      ? Text('Edit Player')
                      : Text('Add Player'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
