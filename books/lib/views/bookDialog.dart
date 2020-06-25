import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BookDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Warning'),
      content:Text('Are you sure you wanna delete this..'),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("yes")),

        FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("no")),

      ],

    );
  }
}
