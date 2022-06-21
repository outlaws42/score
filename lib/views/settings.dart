import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/providers.dart';
import '../helpers.dart';



// final formControllerProvider =
//     StateProvider<TextEditingController>((ref) => TextEditingController());

class Settings extends ConsumerStatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {

  @override
  Widget build(BuildContext context) {
    final ver = ref.read(settingsProvider).getVersionNumber();

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
      body: Consumer(builder: (context, ref, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "Display Settings",
                ),
                ListTile(
                  title: Text('Theme Mode'),
                  trailing: DropdownButton<String>(
                    value: ref.watch(settingsProvider).currentTheme,
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
                      ref.watch(settingsProvider).changeTheme(value ?? 'system');
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
