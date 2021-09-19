import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
// import '../controllers/player_provider.dart';
import '../helpers/custom_widgets/form_text_input.dart';

class PlayerForm extends StatefulWidget {
  @override
  State<PlayerForm> createState() => _PlayerFormState();
}

class _PlayerFormState extends State<PlayerForm> {
  final _nameController = TextEditingController();

  final _winsController = TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();

  void saveEach(String name, int wins) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    var controller = context.read(playerProvider);
    controller.addPlayerForm(name, wins);
    controller.fetchPlayer();
    Get.back(result: "player_form");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Player"),
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
              FormConfigInput.formTextInputValidation(
                  context: context,
                  controller: _nameController,
                  labelText: "Name",
                  hintText: 'Players name (Required)',
                  maxLength: 20,
                  blankFieldMessage: "Fill in the Name"),


              // Wins
              FormConfigInput.formTextInput(
                context: context,
                controller: _winsController,
                labelText: "Wins",
                hintText: 'Players previous wins (optional)',
                maxLength: 2,
              ),
              // Submit Button
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveEach(
                          _nameController.text,

                          int.parse(_winsController.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  icon: Icon(Icons.person),
                  label: Text('Add Player'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
