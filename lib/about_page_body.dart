import 'package:flutter/material.dart';
import 'package:strong_fingers/about_page_body_link_container.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/constants.dart';

class AboutPageBody extends StatelessWidget {
  AboutPageBody({Key? key}) : super(key: key);

  final Uri _urlGithub = Uri.parse(Constants.kGithubLink);
  final Uri _urlLinkedin = Uri.parse(Constants.kLinkedinLink);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: primaryColor,
              ),
              Align(
                child: Image.asset(
                  'assets/images/about_image.png',
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.black,
              ),
              const Positioned(
                bottom: 32.0,
                left: 24.0,
                child: Text(
                  'About this app',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  height: 24.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: darkModeColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 18.0,
              bottom: 18.0,
            ),
            child: Text(
              'This is Flutter project, developed by Nihad Allahveranov.',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          AboutPageBodyLinkContainer(
            textColor: Colors.black,
            tileColor: Colors.white70,
            uri: _urlGithub,
            assetName: 'assets/images/github_icon.svg',
            assetColor: Colors.black,
            containerText: 'View Code',
            message: Constants.kGithubLink,
          ),
          AboutPageBodyLinkContainer(
            textColor: Colors.white,
            tileColor: linkedinIconColor,
            uri: _urlLinkedin,
            assetName: 'assets/images/linkedin_icon.svg',
            assetColor: Colors.white,
            containerText: 'LinkedIn',
            message: Constants.kLinkedinLink,
          ),
        ],
      ),
    );
  }
}
