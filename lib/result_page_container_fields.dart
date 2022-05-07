import 'package:flutter/material.dart';

import 'package:strong_fingers/colors.dart';

class ResultPageContainerFields extends StatelessWidget {
  ResultPageContainerFields({
    Key? key,
    required this.containerFieldName,
    required this.containerFieldParameter,
    this.containerOptionalFieldParameter,
    required this.wrongOrCorrectColor,
  }) : super(key: key);

  final String containerFieldName;
  final int containerFieldParameter;
  final int? containerOptionalFieldParameter;
  final Color wrongOrCorrectColor;

  List<Widget> rowChildren = [];

  @override
  Widget build(BuildContext context) {
    rowChildren.add(
      Text(
        '$containerFieldParameter',
        style: TextStyle(
          fontSize: 24.0,
          color: wrongOrCorrectColor,
        ),
      ),
    );

    if (containerOptionalFieldParameter != null) {
      rowChildren.add(
        const Text(
          ' | ',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      );
      rowChildren.add(
        Text(
          '$containerOptionalFieldParameter',
          style: const TextStyle(
            fontSize: 24.0,
            color: wrongColor,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 12.0,
        right: 12.0,
        bottom: 2.0,
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            containerFieldName,
            style: const TextStyle(
              fontSize: 24.0,
              color: lightModeColor,
            ),
          ),
          Row(
            children: rowChildren,
          ),
        ],
      ),
    );
  }
}
