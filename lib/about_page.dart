import 'package:flutter/material.dart';
import 'package:strong_fingers/about_page_body.dart';

class AboutPage extends StatelessWidget {
  static const String routeName = '/about';

  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return CircularProgressIndicator.adaptive();
    return Scaffold(
      body: AboutPageBody(),
    );
  }
}
