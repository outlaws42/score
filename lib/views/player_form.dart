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
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _winsController = TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();

  void saveEach(String firstname, String lastname, int wins) {
    // Save for each field save
    if (firstname.isEmpty) {
      return;
    }
    var controller = context.read(playerProvider);
    controller.addPlayerForm(firstname, lastname, wins);
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
              // First Name
              FormConfigInput.formTextInputValidation(
                  context: context,
                  controller: _firstNameController,
                  labelText: "First Name",
                  hintText: 'Players first name (Required)',
                  maxLength: 20,
                  blankFieldMessage: "Fill in the First Name"),

              // Last Name
              FormConfigInput.formTextInput(
                context: context,
                controller: _lastNameController,
                labelText: "Last Name",
                hintText: 'Players last name (optional)',
                maxLength: 20,
              ),

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
                          _firstNameController.text,
                          _lastNameController.text,
                          int.parse(_winsController.text));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Theme.of(context).colorScheme.secondaryVariant,
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
