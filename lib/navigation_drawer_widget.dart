import 'package:flutter/material.dart';
import 'package:strong_fingers/about_page.dart';

import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/leader_board_page.dart';
import 'package:strong_fingers/provider_shared_prefences.dart';
import 'package:strong_fingers/welcome_page_arguments.dart';
import 'package:strong_fingers/welcome_page.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final WelcomePageArguments argument = WelcomePageArguments(
    buttonText: 'Change',
    isShownBackButton: true,
  );

  NavigationDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
              color: primaryColor,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 0,
                  child: Text(
                    'Hi ${ProviderSharedPrefences.getUserName}!',
                    softWrap: false,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Image.asset(
                    'assets/images/giphy.gif',
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.leaderboard,
              color: primaryColor,
            ),
            title: const Text(
              'Leader Board',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, LeaderBoardPage.routeName);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: primaryColor,
              size: 32.0,
            ),
            title: const Text(
              'Username',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                WelcomePage.routeName,
                arguments: argument,
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: primaryColor,
              size: 32.0,
            ),
            title: const Text(
              'About',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, AboutPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
