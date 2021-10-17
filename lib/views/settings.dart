import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:path/path.dart';
import 'package:score/main.dart';
// import 'dart:html' as html;
// import 'package:provider/provider.dart';
// import 'package:get/get.dart';
// import '../controllers/theme_provider.dart';
import '../controllers/settings_provider.dart';
// import '../controllers/providers.dart';
import '../helpers.dart';
// import '../controllers/settings_controller.dart';

final settingsProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

// final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) => ThemeProvider());
class Settings extends StatefulWidget {
  // static const routeName = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // bool isDarkMode = false;
  bool isScreenOn = false;
  bool isViberate = false;
  bool isLowScore = false;
  void saveEach(int id, String setting, int active) {
    print("$id, $setting, $active");
    // Save for each field save
    if (setting.isEmpty) {
      print("This is running");
      return;
    }
    print("or this is running");
    context.read(settingsProvider).addSettings(id, setting, active);
    // Provider.of<SettingsProvider>(context, listen: false)
    //     .addSettings(id, setting, active);
    // print(active);
  }

  @override
  Widget build(BuildContext context) {
    // final themeData = Provider.of<ThemeProvider>(context, listen: false);
    // final themeData = watch(themeProvider);
    // final settingsData = context.read(settingsProvider);
    // settingsData.fetchSettings();
    // Provider.of<SettingsProvider>(context, listen: false).fetchSettings();
    // final set = Provider.of<SettingsProvider>(context, listen: false).settings;
    // print('This is setme: ${set[0].active}');
    // bool _isDarkMode = themeProvider.updateTheme().isDarkMode;
    // final SettingsController ver = Get.put(SettingsController().getVersionNumber());
    // final ver = Provider.of<SettingsProvider>(context).getVersionNumber();
    final ver = context.read(settingsProvider).getVersionNumber();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [],
      ),
      // body:
      body: Consumer(builder: (context, ScopedReader watch, child) {
        final themeData = watch(themeProvider);
        final _isDarkMode = themeData.isDarkMode;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Interface Options(Category)
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "Interface Options",
                ),

                SwitchListTile(
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    'This toggles whether the app uses a dark theme or a light theme.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value:
                      _isDarkMode, //payload.settings[0].active == 0 ? false : true,
                  onChanged: (boolVal) {
                    themeData.updateTheme();
                    int val = boolVal == false ? 0 : 1;
                    print(val);
                    saveEach(0, 'DarkMode', val);
                  },
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  activeColor: Theme.of(context).colorScheme.primaryVariant,
                ),
                //   ],
                // ),
                PageWidgets.settingHr(),

                // End Dark Mode

                SwitchListTile(
                  title: Text(
                    'Keep Screen on',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    'This toggles whether the screen stays on while the app is open.',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: isScreenOn,
                  onChanged: (value) {
                    setState(() {
                      isScreenOn = value;
                      print(isScreenOn);
                    });
                  },
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  activeColor: Theme.of(context).colorScheme.primaryVariant,
                ),
                //   ],
                // ),
                PageWidgets.settingHr(),
                // End Keep Screen On

                SwitchListTile(
                  title: Text(
                    'Button Feedback(Viberate)',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    'This toggles whether there will be viberation feed back when pressing the buttons',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  value: isViberate,
                  onChanged: (value) {
                    setState(() {
                      isViberate = value;
                      print(isViberate);
                    });
                  },
                  activeTrackColor: Theme.of(context).colorScheme.secondary,
                  activeColor: Theme.of(context).colorScheme.primaryVariant,
                ),
               
                // Export Import Database
                // Database (Category)
                PageWidgets.settingsCategoryHeader(
                  context: context,
                  sectionTitle: "Database",
                ),

                // Share Database
                PageWidgets.settingsItemIcon(
                  context: context,
                  title: "Share Database",
                  subtitle:
                      "This gives you some flexibility to where you would backup the database.",
                  action: "share",
                  icon: Icon(Icons.share),
                ),
                PageWidgets.settingHr(),
                // Export Database
                PageWidgets.settingsItemIcon(
                  context: context,
                  title: "Export Database",
                  subtitle:
                      "This will backup the database in the apps folder. This will be dislaye at the bottom",
                  action: "export",
                  icon: Icon(Icons.file_upload),
                ),
                PageWidgets.settingHr(),
                // Import Database
                PageWidgets.settingsItemIcon(
                  context: context,
                  title: "Import Database",
                  subtitle:
                      "This will import the selected database overwriting the current database",
                  action: "import",
                  icon: Icon(Icons.file_download),
                ),
                // About (Category)
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
