import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/constants.dart';
import 'package:strong_fingers/document_datas.dart';

import 'package:strong_fingers/leader_board_page.dart';
import 'package:strong_fingers/provider_shared_prefences.dart';
import 'package:strong_fingers/about_page.dart';
import 'package:strong_fingers/my_app_home.dart';
import 'package:strong_fingers/welcome_page_arguments.dart';
import 'package:strong_fingers/welcome_page.dart';

void main() async {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: darkModeColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: Constants.apiKey,
      appId: Constants.appId,
      messagingSenderId: Constants.messagingSenderId,
      projectId: Constants.projectId,
    ),
  );

  await ProviderSharedPrefences().initializeSharedPref();

  runApp(ChangeNotifierProvider<ProviderSharedPrefences>(
      create: (BuildContext context) => ProviderSharedPrefences(),
      child: MyApp()));

  await DocumentDatas().getScore(ProviderSharedPrefences.getUserName);
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  final FirebaseFirestore database = FirebaseFirestore.instance;
  // CollectionReference collectionReference =
  // FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Strong Fingers',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      initialRoute: ProviderSharedPrefences.isUserNameNull
          ? WelcomePage.routeName
          : MyAppHome.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case MyAppHome.routeName:
            return MaterialPageRoute(builder: (context) => const MyAppHome());
          case AboutPage.routeName:
            return MaterialPageRoute(builder: (context) => const AboutPage());
          case LeaderBoardPage.routeName:
            return MaterialPageRoute(
                builder: (context) => const LeaderBoardPage());
          case WelcomePage.routeName:
            final args = settings.arguments == null
                ? WelcomePageArguments(
                    buttonText: 'Start',
                    isShownBackButton: false,
                  )
                : settings.arguments as WelcomePageArguments;
            return MaterialPageRoute(
              builder: (context) => WelcomePage(
                argument: args,
              ),
            );
          default:
            return null;
        }
      },
    );
  }
}
