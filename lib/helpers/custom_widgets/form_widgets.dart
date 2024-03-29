import 'package:flutter/material.dart';

class FormWidgets {
  static Widget formTextInputValidation({
    BuildContext? context,
    TextEditingController? controller,
    String? labelText,
    String? hintText = 'The name of your game (Required)',
    int maxLength = 20,
    String? blankFieldMessage,
    String obscureCharacter = '*',
    bool obscure = false,
    bool enable = true,
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
        enabled: enable,
        obscuringCharacter: obscureCharacter,
        obscureText: obscure,
        maxLength: maxLength,
        textCapitalization: TextCapitalization.words,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: Theme.of(context!).colorScheme.primary,
          decorationColor: Colors.teal,
        ),
        decoration: InputDecoration(
          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Theme.of(context).appBarTheme.foregroundColor!,
          //     width: 2.0,
          //     style: BorderStyle.solid,
          //   ),
          // ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              width: 2.0,
              style: BorderStyle.solid,
            ),
          ),
          fillColor: Colors.grey,
          // If form_edit mode enable will be false.
          filled: enable == false ? true : false,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.backgroundColor!,
              width: 3.0,
              style: BorderStyle.solid,
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
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.backgroundColor!,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  static Widget formTextInputMulti({
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
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        minLines: 1,
        maxLines: 10,
        keyboardType: TextInputType.multiline,
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
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).appBarTheme.backgroundColor!,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
