import 'package:flutter/material.dart';
import '../widgets/main_body.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import '../widgets/main_body.dart';
// import '../providers/webview_provider.dart';
import '../screens/settings.dart';

enum FilterOptions {
  Settings,
  Card2,
}

class MainScreen extends StatelessWidget {
  void selectSettings(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(Settings.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final _appName = Provider.of<SettingsProvider>(context).getAppName();
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: _appName,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
              Text(
            snapshot.hasData ? snapshot.data! : "Loading ...",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              print(selectedValue);
              selectSettings(context);
            },
            icon: Icon(Icons.more_vert),
            // onSelected: (Filter){},
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text("Settings"), value: FilterOptions.Settings)
            ],
          ),
        ],
      ),
      body: MainBody(),
    );
  }
}
