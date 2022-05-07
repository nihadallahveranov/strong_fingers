import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strong_fingers/welcome_page.dart';

class AdaptiveAlertDialog extends StatelessWidget {
  const AdaptiveAlertDialog(
      {Key? key,
      required this.titleText,
      required this.contentText,
      required this.titleColor})
      : super(key: key);

  final String titleText;
  final String contentText;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    if (WelcomePage.isAndroid) {
      return AlertDialog(
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 20.0,
            color: titleColor,
          ),
        ),
        content: Text(
          contentText,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        actions: [
          buildFlatButton(context),
        ],
      );
    }
    return CupertinoAlertDialog(
      title: Text(
        titleText,
        style: TextStyle(
          fontSize: 20.0,
          color: titleColor,
        ),
      ),
      content: Text(
        contentText,
        style: const TextStyle(
          fontSize: 16.0,
        ),
      ),
      actions: [
        buildFlatButton(context),
      ],
    );
  }

  FlatButton buildFlatButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Ok'),
    );
  }
}
