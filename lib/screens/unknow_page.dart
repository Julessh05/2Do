library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/translate.dart';
import 'package:todo/screens/homescreen.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Something went wrong while navigating to the page you wanted to see."
                    .translate(),
                semanticsLabel:
                    "Something went wrong while navigating to the page you wanted to see."
                        .translate(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: _backToTheHomescreen,
                child: Text(
                  "Back to the Homescreen".translate(),
                  semanticsLabel: "Back to the Homescreen".translate(),
                ),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
              )
            ],
          ),
        ),
      ),
    );

    return _scaffold;
  }

  void _backToTheHomescreen() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Homescreen.routeName,
      (route) => false,
    );
  }
}
