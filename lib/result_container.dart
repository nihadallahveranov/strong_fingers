import 'package:flutter/material.dart';

import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/result_page_container_fields.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    Key? key,
    required this.wordsPerMinute,
    required this.typingCorrectKeyStrokes,
    required this.typingNotCorrectKeyStrokes,
    required this.typingCorrectWords,
    required this.typingNotCorrectWords,
  }) : super(key: key);

  final int wordsPerMinute;
  final int typingCorrectKeyStrokes;
  final int typingNotCorrectKeyStrokes;
  final int typingCorrectWords;
  final int typingNotCorrectWords;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        border: Border.all(
          color: primaryColor,
          width: 2.0,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      margin: const EdgeInsets.only(
        top: 24.0,
        left: 12.0,
        right: 12.0,
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
            ),
            color: primaryColor,
            width: double.infinity,
            child: const Text(
              'Result',
              style: TextStyle(
                fontSize: 28.0,
                color: lightModeColor,
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            '$wordsPerMinute',
            style: const TextStyle(
              fontSize: 54.0,
              color: resultTextColor,
            ),
          ),
          const Text(
            'words per minute',
          ),
          const Divider(
            thickness: 1,
            color: dividerColor,
          ),
          ResultPageContainerFields(
            containerFieldName: 'Keystrokes',
            containerFieldParameter: typingCorrectKeyStrokes,
            containerOptionalFieldParameter: typingNotCorrectKeyStrokes,
            wrongOrCorrectColor: rightColor,
          ),
          const Divider(
            thickness: 1,
            color: dividerColor,
          ),
          ResultPageContainerFields(
            containerFieldName: 'Correct Words',
            containerFieldParameter: typingCorrectWords,
            wrongOrCorrectColor: rightColor,
          ),
          const Divider(
            thickness: 1,
            color: dividerColor,
          ),
          ResultPageContainerFields(
            containerFieldName: 'Wrong Words',
            containerFieldParameter: typingNotCorrectWords,
            wrongOrCorrectColor: wrongColor,
          ),
        ],
      ),
    );
  }
}
