library components;

import 'package:flutter/material.dart';
import 'package:string_translate/string_translate.dart' show Translate;

class NotesDetailsTile extends StatefulWidget {
  const NotesDetailsTile({
    this.title,
    this.subtitle,
    this.icon,
    this.isButton = false,
    this.function,
    Key? key,
  }) : super(key: key);

  const NotesDetailsTile.divider({
    this.title = '',
    this.subtitle = '',
    this.icon,
    this.isButton = false,
    this.function,
    Key? key,
  }) : super(key: key);

  const NotesDetailsTile.button({
    required this.title,
    required this.function,
    this.subtitle = '',
    this.icon,
    this.isButton = true,
    Key? key,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final Icon? icon;
  final bool isButton;
  final void Function()? function;

  @override
  State<NotesDetailsTile> createState() => _NotesDetailsTileState();
}

class _NotesDetailsTileState extends State<NotesDetailsTile> {
  @override
  Widget build(BuildContext context) {
    final Widget _tile;
    if (widget.isButton) {
      // Fitted Box to make Button not appear
      // in the whole width
      _tile = FittedBox(
        alignment: Alignment.center,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: BoxFit.scaleDown,
        child: TextButton(
          autofocus: false,
          onPressed: widget.function,
          child: Text(widget.title!),
        ),
      );
    } else {
      _tile = ListTile(
        autofocus: false,
        title: Text(
          widget.title ?? '',
          semanticsLabel: 'Title'.tr(),
        ),
        subtitle: Text(
          widget.subtitle ?? '',
          semanticsLabel: 'Value of the Info'.tr(),
        ),
        enabled: true,
        leading: widget.icon,
        isThreeLine: false,
        onTap: widget.function,
      );
    }
    return _tile;
  }
}
