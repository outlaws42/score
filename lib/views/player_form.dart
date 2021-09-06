import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import './player_screen.dart';

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
    context.read(playerProvider).addPlayerForm(firstname, lastname,wins);
    Get.back();
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
              Container(
                margin: EdgeInsets.fromLTRB(10,0,10,0),
                child: TextFormField(
                  controller: _firstNameController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty){
                      return "Fill in the First Name";
                    }
                    return null;
                  },
                  maxLength: 20,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decorationColor: Colors.teal,
                  ),
                  decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintText: 'Players first name (Required)',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              
              // Last Name
              Container(
                 margin: EdgeInsets.fromLTRB(10,0,10,0),
                child: TextFormField(
                  controller: _lastNameController,
                  maxLength: 20,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decorationColor: Colors.teal,
                  ),
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintText: 'Players last name (optional)',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
        
              // Wins
              Container(
                margin: EdgeInsets.fromLTRB(10,0,10,0),
                child: TextFormField(
                  controller: _winsController,
                  maxLength: 2,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    decorationColor: Colors.teal,
                  ),
                  decoration: InputDecoration(
                    labelText: "Wins",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    hintText: 'Players previous wins (optional)',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.secondaryVariant,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primaryVariant,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0,20,0,0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    saveEach(_firstNameController.text, _lastNameController.text,
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
