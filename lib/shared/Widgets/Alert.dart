import 'package:flutter/material.dart';

Future<void> showConfirmation(String title,String message,Widget widg,context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
              ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          widg,
        ],
      );
    },
  );
}


Future<void> showAlert(String title,String message,Widget widg,context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(title),
        content:  SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.lightBlueAccent,
              ),
              ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          widg,
        ],
      );
    },
  );
}