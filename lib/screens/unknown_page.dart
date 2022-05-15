library screens;

import 'package:flutter/material.dart';
import 'package:todo/logic/jumper.dart';
import 'package:string_translate/string_translate.dart' show Translate;

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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Unknown Page'.tr(),
          semanticsLabel: 'Unknown Page'.tr(),
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
                'Something went wrong while navigating to the page you wanted to see'
                    .tr(),
                semanticsLabel:
                    'Something went wrong while navigating to the page you wanted to see'
                        .tr(),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () => Jumper.backToTheHomescreen(context),
                autofocus: false,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Text(
                  'Back to the Homescreen'.tr(),
                  semanticsLabel: 'Back to the Homescreen'.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
