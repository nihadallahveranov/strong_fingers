import 'package:flutter/material.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/leader_board_body.dart';

class LeaderBoardPage extends StatelessWidget {
  static const String routeName = '/leaderBoard';

  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: primaryColor,
        title: const Text(
          'Leader Board',
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
      ),
      body: LeaderBoardBody(),
    );
  }
}
