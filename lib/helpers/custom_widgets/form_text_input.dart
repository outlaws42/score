import 'package:flutter/material.dart';

class FormConfig {

  static Widget formTextInputValidation({
    BuildContext? context,
    TextEditingController? controller,
    String? labelText,
    String? hintText = 'The name of your game (Required)',
    int maxLength = 20,
    String? blankFieldMessage,
  

  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        controller: controller,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return blankFieldMessage;
          }
          return null;
        },
        maxLength: maxLength,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: Theme.of(context!).colorScheme.primary,
          decorationColor: Colors.teal,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          hintText: hintText,
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
    );
  }

  static Widget formTextInput({
    BuildContext? context,
    TextEditingController? controller,
    String? labelText,
    String? hintText = 'The name of your game (Required)',
    int maxLength = 20,
  

  }) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: TextFormField(
        controller: controller,
        maxLength: maxLength,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: Theme.of(context!).colorScheme.primary,
          decorationColor: Colors.teal,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          hintText: hintText,
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
    );
  }
}
