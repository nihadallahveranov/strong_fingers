import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:strong_fingers/document_datas.dart';
import 'package:strong_fingers/provider_shared_prefences.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/my_app_home.dart';
import 'package:strong_fingers/my_expanded_sized_box.dart';
import 'package:strong_fingers/welcome_page_arguments.dart';

import 'adaptive_alert_dialog.dart';

class WelcomePage extends StatelessWidget with ChangeNotifier {
  static const String routeName = '/welcome';

  final WelcomePageArguments argument;

  String _userName = '';

  WelcomePage({
    Key? key,
    required this.argument,
  }) : super(key: key);

  static late bool isIOS;
  static late bool isAndroid;

  @override
  Widget build(BuildContext context) {
    isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    isAndroid = Theme.of(context).platform == TargetPlatform.android;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: argument.isShownBackButton,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Strong Fingers',
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Expanded(
                flex: 0,
                child: Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/typing.svg',
                      height: 400,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Container(
                  width: 300.0,
                  margin: const EdgeInsets.symmetric(horizontal: 24.0),
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    bottom: 6.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: ThemeData(
                      textSelectionTheme: TextSelectionThemeData(
                        selectionColor: Colors.blue[120],
                      ),
                    ),
                    child: TextField(
                      maxLines: 1,
                      maxLength: 18,
                      autocorrect: false,
                      cursorColor: primaryColor,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        counterText: '',
                        hintText: 'Username',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (String newValue) {
                        _userName = newValue;
                      },
                    ),
                  ),
                ),
              ),
              const MyExpandedSizedBox(
                height: 12.0,
              ),
              Expanded(
                flex: 0,
                child: RaisedButton(
                  color: primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  onPressed: () async {
                    if (_userName.length < 4) {
                      showDialog(
                        context: context,
                        builder: (context) => const AdaptiveAlertDialog(
                            titleColor: wrongColor,
                            titleText: 'Warning',
                            contentText:
                                'Your username cannot be less than 4 characters'),
                      );
                    } else if (argument.buttonText == 'Start') {
                      // print(DocumentDatas.getLengthDocuments);
                      await DocumentDatas().isTakenUsername(_userName);
                      if (!DocumentDatas.value) {
                        // print(DocumentDatas.value);
                        // print('success2');

                        ProviderSharedPrefences.setSharedPrefences(
                            'userName', _userName);

                        Navigator.popAndPushNamed(context, MyAppHome.routeName);

                        final user = <String, dynamic>{
                          'score': 0,
                          'userName': _userName,
                        };

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(_userName)
                            .set(user);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              const AdaptiveAlertDialog(
                            titleText: 'Warning',
                            contentText:
                                'This username has already been taken.',
                            titleColor: wrongColor,
                          ),
                        );
                      }
                    } else {
                      if (_userName != ProviderSharedPrefences.getUserName) {
                        await DocumentDatas().isTakenUsername(_userName);

                        await DocumentDatas()
                            .getScore(ProviderSharedPrefences.getUserName);

                        int score = DocumentDatas.score;

                        if (!DocumentDatas.value) {
                          final user = <String, dynamic>{
                            'userName': _userName,
                            'score': score,
                          };

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(ProviderSharedPrefences.getUserName)
                              .delete();

                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(_userName)
                              .set(user);

                          ProviderSharedPrefences.setSharedPrefences(
                              'userName', _userName);

                          Navigator.popAndPushNamed(
                              context, MyAppHome.routeName);

                          showDialog(
                            context: context,
                            builder: (context) => const AdaptiveAlertDialog(
                              titleColor: rightColor,
                              titleText: 'Successfully',
                              contentText: 'You have changed your username.',
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => const AdaptiveAlertDialog(
                              titleColor: wrongColor,
                              titleText: 'Warning',
                              contentText:
                                  'This username has already been taken.',
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AdaptiveAlertDialog(
                            titleColor: wrongColor,
                            titleText: 'Warning',
                            contentText: 'Your username is already $_userName',
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    argument.buttonText,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
