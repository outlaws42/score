import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../models/settings_model.dart';
import '../controllers/settings_provider.dart';
import '../helpers.dart';

final settingsProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

final formControllerProvider =
    StateProvider<TextEditingController>((ref) => TextEditingController());

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    // ignore: unnecessary_statements
    // context.read(settingsProvider).getUrl();
    _urlController.text = context.read(settingsProvider).urlString;
    _urlController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _urlController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${_urlController.text}');
    context.read(settingsProvider).changeUrl(_urlController.text);
    context.read(settingsProvider).getUrl();
  }

  void _saveSettings(
    String url,
    bool darkMode,
  ) {
    final newSettings = SettingsModel(
      url: url,
      isDarkMode: darkMode,
    );
    context.read(settingsProvider).saveSettings(newSettings);
  }

  @override
  Widget build(BuildContext context) {
    // String _url = context.read(settingsProvider).settings[0].url.toString();
    // bool _isDarkMode = context.read(settingsProvider).settings[0].isDarkMode;
    // print('_isDarkMode at Build: $_isDarkMode');
    final ver = context.read(settingsProvider).getVersionNumber();
    // final _urlController = TextEditingController(text: _url);
    //  final _urlController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     _saveSettings(_urlController.text, _isDarkMode);
          //   },
          //   icon: Icon(
          //     Icons.save,
          //   ),
          // )
        ],
      ),
      // body:
      body: Consumer(builder: (context, ScopedReader watch, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // About (Category)
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "Connection Settings",
                ),

                ListTile(
                    title: FormWidgets.formTextInput(
                  context: context,
                  controller: _urlController,
                  labelText: 'Base URL',
                  hintText: 'This is the base URL to the API backend',
                  maxLength: 20,
                )),
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "Display Settings",
                ),
                ListTile(
                  title: Text('Theme Mode'),
                  trailing: DropdownButton<String>(
                    value: watch(settingsProvider).currentTheme,
                    items: [
                      // Light, Dark, System
                      DropdownMenuItem<String>(
                        value: 'light',
                        child: Text(
                          'Light',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'dark',
                        child: Text(
                          'Dark',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'system',
                        child: Text(
                          'System',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                    onChanged: (String? value) {
                      watch(settingsProvider).changeTheme(value ?? 'system');
                    },
                  ),
                ),
               
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "About",
                ),

                ListTile(
                  title: Text(
                    'Score Version',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    'This is the current app version',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: FutureBuilder(
                    future: ver,
                    builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) =>
                        Text(
                      snapshot.hasData ? "${snapshot.data}" : "Loading ...",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                PageWidgets.settingHr(),

                ListTile(
                  title: Text(
                    'License',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    'This app is opensource and is licensed under the GPL version 2',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  trailing: Text(
                    "GPL V2",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onTap: () async {
                    FunctionHelper.license();
                  },
                ),

                PageWidgets.settingHr(),
              ],
            ),
          ),
        );
      }),
      // ),
      // ),
    );
  }
}
