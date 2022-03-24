library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:todo/logic/translate.dart';

/// Screen shown when the User tries to navigate to a Page that can't be
/// found in this App
class UnknownPage extends StatefulWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    final _scaffold = Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Unknown Page".translate(),
          semanticsLabel: "Unknown Page".translate(),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            textBaseline: TextBaseline.alphabetic,
            textDirection: TextDirection.ltr,
            verticalDirection: VerticalDirection.down,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Something went wrong while navigating to the page you wanted to see"
                    .translate(),
                semanticsLabel:
                    "Something went wrong while navigating to the page you wanted to see"
                        .translate(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Jumper.backToTheHomescreen(context),
                child: Text(
                  "Back to the Homescreen".translate(),
                  semanticsLabel: "Back to the Homescreen".translate(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              ),
            ],
          ),
        ),
      ),
    );

    return _scaffold;
  }
}