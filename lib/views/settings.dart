import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../controllers/settings_provider.dart';
import '../helpers.dart';

final settingsProvider =
    ChangeNotifierProvider<SettingsProvider>((ref) => SettingsProvider());

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // bool isScreenOn = false;
  // bool isViberate = false;
  // bool isLowScore = false;
  void saveEach(int id, String setting, int active) {
    // Save for each field save
    if (setting.isEmpty) {
      return;
    }
    context.read(settingsProvider).addSettings(id, setting, active);
  }

  @override
  Widget build(BuildContext context) {
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
        // final settingData = watch(settingsProvider);
        // bool _isDarkMode = settingData.settings[0].active == 0 ? false : true;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                      "This option gives you some flexibility" 
                      "where you want to backup the database.",
                  action: "share",
                  icon: Icon(Icons.share),
                ),
                PageWidgets.settingHr(),
                // Export Database
                PageWidgets.settingsItemIcon(
                  context: context,
                  title: "Export Database",
                  subtitle:
                      "This option will backup the database in the apps folder." 
                      "The path and file name will be dislayed at the bottom once exported",
                  action: "export",
                  icon: Icon(MdiIcons.databaseExport),
                ),
                PageWidgets.settingHr(),
                // Import Database
                PageWidgets.settingsItemIcon(
                  context: context,
                  title: "Import Database",
                  subtitle:
                      "This option will import the selected" 
                      "database overwriting the current database",
                  action: "import",
                  icon: Icon(MdiIcons.databaseImport),
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
