import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:strong_fingers/colors.dart';

class Documents extends StatelessWidget {
  const Documents({
    Key? key,
    required this.isText,
    this.newIndex = 0,
    this.fieldName = 'userName',
    this.textStyle = const TextStyle(),
    this.whereUserName = '',
  }) : super(key: key);

  final bool isText;
  final String fieldName;
  final int newIndex;
  final TextStyle textStyle;
  static int whereCounter = 0;
  final String whereUserName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .orderBy(
            'score',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        List<DocumentSnapshot> documentSnapshot = asyncSnapshot.data.docs;
        if (!isText) {
          return Expanded(
            child: ListView.builder(
              itemCount: documentSnapshot.length,
              itemBuilder: (BuildContext context, int index) {
                if (documentSnapshot[index].get('userName') == whereUserName) {
                  whereCounter++;
                }
                Color? numberColor;
                switch (index) {
                  case 0:
                    numberColor = firstUserColor;
                    break;
                  case 1:
                    numberColor = secondUserColor;
                    break;
                  case 2:
                    numberColor = thirdUserColor;
                    break;
                  default:
                    numberColor = Colors.white;
                }
                return ListTile(
                  leading: Text(
                    '${index + 1}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: numberColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Text(
                    '${documentSnapshot[index].get('score')}',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: numberColor,
                    ),
                  ),
                  title: Text(
                    '${documentSnapshot[index].get(fieldName)}',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: numberColor,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Text(
            '${documentSnapshot[newIndex].get(fieldName)}',
            style: textStyle,
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}
