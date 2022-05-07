import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/document_datas.dart';
import 'package:strong_fingers/expanded_radial_gauge.dart';
import 'package:strong_fingers/my_expanded_sized_box.dart';
import 'package:strong_fingers/navigation_drawer_widget.dart';
import 'package:strong_fingers/provider_shared_prefences.dart';
import 'package:strong_fingers/result_container.dart';

import './colors.dart';
import 'constants.dart';

class MyAppHome extends StatefulWidget {
  static const String routeName = '/';

  const MyAppHome({Key? key}) : super(key: key);

  @override
  State<MyAppHome> createState() => _MyAppHomeState();
}

class _MyAppHomeState extends State<MyAppHome> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  late Timer _timer;
  int _timeCounter = 60;
  int _wordsPerMinute = 0; // result of your strong fingers
  var showWordPerMinute;
  var resultContainer;
  Color textColor = rightColor;
  String _loremTempText = Constants
      .kTexts[Random().nextInt(Constants.kTexts.length)]
      .toLowerCase()
      .replaceAll(',', '')
      .replaceAll('!', ' ')
      .replaceAll('?', ' ')
      .replaceAll('-', ' ')
      .replaceAll('_', ' ')
      .replaceAll('[', ' ')
      .replaceAll(']', ' ')
      .replaceAll('  ', ' ')
      .replaceAll('.', '');

  int _typingCorrectWordsCounter = 0;
  int _typingNotCorrectWordsCounter = 0;
  final _controller = TextEditingController();
  bool _isReadOnlyOfTextField = false;
  String _timeShower = '1:00';
  bool _autoFocus = false;
  bool _hasRefresh = false;
  double _accuracy = 0;
  double _totalTypingWords = 0;
  int _typingCorrectKeyStrokes = 0;
  int _typingNotCorrectKeyStrokes = 0;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeCounter > 0) {
          _timeCounter--;
        } else {
          _isReadOnlyOfTextField = true;
          _timer.cancel();
          _wordsPerMinute = _typingCorrectWordsCounter;
          if (_wordsPerMinute > DocumentDatas.score) {
            final user = <String, dynamic>{
              'userName': ProviderSharedPrefences.getUserName,
              'score': _wordsPerMinute,
            };

            FirebaseFirestore.instance
                .collection('users')
                .doc(ProviderSharedPrefences.getUserName)
                .delete();
            FirebaseFirestore.instance
                .collection('users')
                .doc(ProviderSharedPrefences.getUserName)
                .set(user);
          }

          resultContainer = ResultContainer(
            wordsPerMinute: _wordsPerMinute,
            typingCorrectKeyStrokes: _typingCorrectKeyStrokes,
            typingNotCorrectKeyStrokes: _typingNotCorrectKeyStrokes,
            typingCorrectWords: _typingCorrectWordsCounter,
            typingNotCorrectWords: _typingNotCorrectWordsCounter,
          );
        }
        if (_timeCounter == 60) {
          _timeShower = '1:00';
        } else if (_timeCounter > 9) {
          _timeShower = '00:$_timeCounter';
        } else {
          _timeShower = '00:0$_timeCounter';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text(
          'Strong Fingers',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const MyExpandedSizedBox(
                height: 50.0,
              ),
              ExpandedRadialGauge(
                modeTextColor: darkModeColor,
                radialGaugeValue: _accuracy.toDouble(),
              ),
              Expanded(
                flex: 0,
                child: Text(
                  '${_accuracy.toStringAsFixed(2)}%\nAccuracy',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 21.0,
                  ),
                ),
              ),
              const MyExpandedSizedBox(
                height: 50.0,
              ),
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8.0,
                    bottom: 16.0,
                  ),
                  child: Text(
                    _loremTempText,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 27.0,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              const MyExpandedSizedBox(
                height: 8.0,
              ),
              Expanded(
                flex: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          focusNode: myFocusNode,
                          autofocus: _autoFocus,
                          readOnly: _isReadOnlyOfTextField,
                          controller: _controller,
                          cursorColor: primaryColor,
                          style: TextStyle(
                            fontSize: 24.0,
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                          autocorrect: false,
                          // cursorColor: modeTextColor,
                          decoration: InputDecoration(
                            hintText: 'Type',
                            hintStyle: const TextStyle(
                              color: hintColor,
                            ),
                            filled: true,
                            fillColor: darkModeColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                color: lightModeColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: const BorderSide(
                                color: primaryColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onChanged: (input) {
                            /// Input Controller
                            setState(() {
                              if (input.contains(
                                  _loremTempText.substring(0, input.length))) {
                                textColor = rightColor;
                              } else {
                                textColor = wrongColor;
                              }
                              if (input.endsWith(' ') && input != ' ') {
                                if (input.replaceAll(' ', '') ==
                                    _loremTempText.split(' ')[0]) {
                                  _typingCorrectWordsCounter++;
                                  _typingCorrectKeyStrokes += input.length - 1;
                                } else {
                                  _typingNotCorrectWordsCounter++;
                                  _typingNotCorrectKeyStrokes +=
                                      input.length - 1;
                                }
                                _loremTempText = _loremTempText
                                    .substring(_loremTempText.indexOf(' ') + 1);
                                _controller.clear();
                                _totalTypingWords++;
                              } else if (input == ' ') {
                                _controller.clear();
                              }
                              if (_totalTypingWords != 0) {
                                _accuracy = (_typingCorrectWordsCounter /
                                        _totalTypingWords) *
                                    100;
                              }
                            });
                          },
                          onTap: () {
                            setState(() {
                              if (!_hasRefresh) {
                                _startTimer();
                                _hasRefresh = true;
                              }
                            });
                          },
                        ),
                      ),
                      const MyExpandedSizedBox(),
                      Expanded(
                        flex: 0,
                        child: SizedBox(
                          height: 27.0,
                          width: 64.0,
                          child: Text(
                            _timeShower,
                            style: const TextStyle(
                              fontSize: 21.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Column(
                          children: <Widget>[
                            IconButton(
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  _accuracy = 0;
                                  _totalTypingWords = 0;
                                  _timeShower = '1:00';
                                  _timer.cancel();
                                  _isReadOnlyOfTextField = false;
                                  _timeCounter = 60;
                                  _controller.clear();
                                  _startTimer();
                                  _typingCorrectWordsCounter = 0;
                                  _typingNotCorrectWordsCounter = 0;
                                  _typingCorrectKeyStrokes = 0;
                                  _typingNotCorrectKeyStrokes = 0;
                                  _autoFocus = true;
                                  _hasRefresh = true;
                                  _loremTempText = Constants.kTexts[Random()
                                          .nextInt(Constants.kTexts.length)]
                                      .toLowerCase()
                                      .replaceAll(',', '')
                                      .replaceAll('!', ' ')
                                      .replaceAll('?', ' ')
                                      .replaceAll('-', ' ')
                                      .replaceAll('_', ' ')
                                      .replaceAll('[', ' ')
                                      .replaceAll(']', ' ')
                                      .replaceAll('  ', ' ')
                                      .replaceAll('.', '');
                                  myFocusNode.requestFocus();
                                  resultContainer = null;
                                });
                              },
                              icon: const Icon(
                                Icons.refresh,
                              ),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (resultContainer != null) resultContainer,
              const MyExpandedSizedBox(
                height: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
