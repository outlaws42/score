import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:get/get.dart';
import '../controllers/providers.dart';
import '../helpers.dart';

class SpinnerForm extends ConsumerStatefulWidget {
  @override
  _SpinnerFormState createState() => _SpinnerFormState();
}

class _SpinnerFormState extends ConsumerState<SpinnerForm> {
  List arguments = Get.arguments;

  int _count = 0;

  var _nameController = TextEditingController();

  var _winsController = TextEditingController(text: '0');

  final _formKey = GlobalKey<FormState>();

  void _save(WidgetRef ref, String name, int wins) {
    // Save for each field save
    if (name.isEmpty) {
      return;
    }
    var controller = ref.read(playerProvider);
    if (arguments[0] == "form_edit") {
      controller.updatePlayerName(arguments[1], name);
    } else {
      controller.addPlayerForm(
        name: name,
      );
      controller.fetchPlayer();
    }
    Get.back(result: "player_form");
  }

  @override
  Widget build(BuildContext context) {
    if (arguments[0] == "form_edit") {
      _nameController = TextEditingController(text: arguments[2].toString());
      _winsController = TextEditingController(text: arguments[3].toString());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          arguments[0] == "form_edit" ? "Edit Spinner" : "Add Spinner",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              setState(() {
                _count++;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () async {
              setState(() {
                _count = 0;
              });
            },
          ),
          // PageWidgets().iconButtonBarDocs(
          //   context: context,
          //   data: "assets/help_player_form.md",
          //   icon: Icon(MdiIcons.help),
          //   iconSize: 20,
          //   popupHeightPercent: 25,
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Spinner Information',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              // Name
              FormWidgets.formTextInputValidation(
                  context: context,
                  controller: _nameController,
                  labelText: "Spinner Name",
                  hintText: 'Name of the spinner (Required)',
                  maxLength: 20,
                  blankFieldMessage: "Fill in the spinner name"),
              // Spinner fields
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _count,
                  itemBuilder: index,
                ),
              ),
              // Submit Button
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _save(
                        ref,
                        _nameController.text,
                        int.parse(_winsController.text),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    onPrimary: Colors.white,
                    primary: Theme.of(context).appBarTheme.backgroundColor,
                  ),
                  icon: Icon(Icons.circle),
                  label: arguments[0] == "form_edit"
                      ? Text('Edit Spinner')
                      : Text('Add Spinner'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
