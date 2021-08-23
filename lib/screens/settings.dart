import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/settings_provider.dart';

class Settings extends StatefulWidget {
  static const routeName = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // bool isDarkMode = false;
  bool isScreenOn = false;
  bool isViberate = false;
  bool isLowScore = false;
  void saveEach(int id, String setting, int active) {
    // Save for each field save
    if (setting.isEmpty) {
      return;
    }
    Provider.of<SettingsProvider>(context, listen: false)
        .addSettings(id, setting, active);
    print(active);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<ThemeProvider>(context, listen: false);
    Provider.of<SettingsProvider>(context, listen: false).fetchSettings();
    // final set = Provider.of<SettingsProvider>(context, listen: false).settings;
    // print('This is setme: ${set[0].active}');
    bool _isDarkMode = themeData.isDarkMode;
    final ver = Provider.of<SettingsProvider>(context).getVersionNumber();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              future: ver,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
                  Text(
                snapshot.hasData ? "${snapshot.data}" : "Loading ...",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<SettingsProvider>(
        builder: (ctx, payload, ch) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // Interface Options(Category)
                      Container(
                        color: Theme.of(context).colorScheme.onPrimary,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              'Interface Options',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      // End View Options

                      // Dark Mode (Toggle)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dark Mode',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Switch(
                            value:
                                _isDarkMode, //payload.settings[0].active == 0 ? false : true,
                            onChanged: (boolVal) {
                              themeData.updateTheme();
                              int val = boolVal == false ? 0 : 1;
                              saveEach(0, 'DarkMode', val);
                            },
                            activeTrackColor:
                                Theme.of(context).colorScheme.secondary,
                            activeColor:
                                Theme.of(context).colorScheme.primaryVariant,
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 0,
                        endIndent: 0,
                      ),
                      // End Dark Mode

                      // Keep Screen On(Toggle)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Keep Screen On',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Switch(
                            value: isScreenOn,
                            onChanged: (value) {
                              setState(() {
                                isScreenOn = value;
                                print(isScreenOn);
                              });
                            },
                            activeTrackColor:
                                Theme.of(context).colorScheme.secondary,
                            activeColor:
                                Theme.of(context).colorScheme.primaryVariant,
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 0,
                        endIndent: 0,
                      ),
                      // End Keep Screen On

                      // Button Feedback(Toggle)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Button Feedback(Viberate)',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Switch(
                            value: isViberate,
                            onChanged: (value) {
                              setState(() {
                                isViberate = value;
                                print(isViberate);
                              });
                            },
                            activeTrackColor:
                                Theme.of(context).colorScheme.secondary,
                            activeColor:
                                Theme.of(context).colorScheme.primaryVariant,
                          ),
                        ],
                      ),
                      Divider(
                        height: 20,
                        thickness: 5,
                        indent: 0,
                        endIndent: 0,
                      ),
                      // End Button Feedback

                      // Quick Entry Options (Category)
                      Container(
                        color: Theme.of(context).colorScheme.onPrimary,
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              'Quick Entry Options',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ),
                      // End Quick Entry Options

                      // TextFormField(
                      //   // initialValue: payload.settings[0].setting,
                      //   onFieldSubmitted: (value) {
                      //     saveEach(1, value);
                      //   },
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     decorationColor: Colors.teal,
                      //   ),
                      //   decoration: InputDecoration(
                      //     labelText: "Base URL",
                      //     labelStyle: TextStyle(color: Colors.white60),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           const BorderSide(color: Colors.teal, width: 2.0),
                      //       borderRadius: BorderRadius.circular(10.0),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
      ),
      // ),
      // ),
    );
  }
}
