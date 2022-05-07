import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strong_fingers/colors.dart';
import 'package:strong_fingers/documents.dart';
import 'package:strong_fingers/leader_board_score_container.dart';

class LeaderBoardBody extends StatelessWidget {
  LeaderBoardBody({Key? key}) : super(key: key);

  final listOfDocs = FirebaseFirestore.instance.collection('users').get();
  final scoreTextStyle = const TextStyle(fontSize: 24.0);
  final userNameTextStyle = const TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                color: primaryColor,
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 24.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      LeaderBoardScoreContainer(
                        scoreTableColor: secondUserColor,
                        partOfHeight: 0.24,
                        imageNumber: 2,
                        scoreText: Documents(
                          isText: true,
                          newIndex: 1,
                          fieldName: 'score',
                          textStyle: scoreTextStyle,
                        ),
                        userNameText: Documents(
                          isText: true,
                          newIndex: 1,
                          fieldName: 'userName',
                          textStyle: userNameTextStyle,
                        ),
                      ),
                      LeaderBoardScoreContainer(
                        scoreTableColor: firstUserColor,
                        partOfHeight: 0.31,
                        imageNumber: 1,
                        scoreText: Documents(
                          isText: true,
                          newIndex: 0,
                          fieldName: 'score',
                          textStyle: scoreTextStyle,
                        ),
                        userNameText: Documents(
                          isText: true,
                          newIndex: 0,
                          fieldName: 'userName',
                          textStyle: userNameTextStyle,
                        ),
                      ),
                      LeaderBoardScoreContainer(
                        scoreTableColor: thirdUserColor,
                        partOfHeight: 0.17,
                        imageNumber: 3,
                        scoreText: Documents(
                          isText: true,
                          newIndex: 2,
                          fieldName: 'score',
                          textStyle: scoreTextStyle,
                        ),
                        userNameText: Documents(
                          isText: true,
                          newIndex: 2,
                          fieldName: 'userName',
                          textStyle: userNameTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 24.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: darkModeColor,
                    ),
                    color: darkModeColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Documents(
          isText: false,
        ),
      ],
    );
  }
}
