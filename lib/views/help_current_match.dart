import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

class HelpCurrentMatch extends StatelessWidget {
  // const HelpCurrentMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: EdgeInsets.all(20),
        child: FutureBuilder(
          future: rootBundle.loadString("assets/help_current_match.md"),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Markdown(
                data: snapshot.data!,
                styleSheet: MarkdownStyleSheet(
                  // h1: TextStyle(color: Colors.blue, fontSize: 40),
                  p: Theme.of(context).textTheme.bodyText1,
                  h1: Theme.of(context).textTheme.headline2,
                  h2: Theme.of(context).textTheme.headline4,
                  h3: Theme.of(context).textTheme.headline6,
                  h4: Theme.of(context).textTheme.headline4,
                  h5: Theme.of(context).textTheme.headline5,
                  h6: Theme.of(context).textTheme.headline6,
                  listBullet: Theme.of(context).textTheme.bodyText1,
                  strong: Theme.of(context).textTheme.headline6,
                  code: Theme.of(context).textTheme.headline6,
                  // codeblockDecoration: ,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
