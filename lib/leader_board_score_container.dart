import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeaderBoardScoreContainer extends StatelessWidget {
  const LeaderBoardScoreContainer({
    Key? key,
    required this.scoreTableColor,
    required this.partOfHeight,
    required this.imageNumber,
    required this.scoreText,
    required this.userNameText,
  }) : super(key: key);

  final Color scoreTableColor;
  final double partOfHeight;
  final int imageNumber;
  final Widget scoreText;
  final Widget userNameText;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * partOfHeight,
        width: MediaQuery.of(context).size.width * 0.27,
        decoration: BoxDecoration(
          color: scoreTableColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  'assets/images/$imageNumber-solid.svg',
                  height: 18.0,
                  color: scoreTableColor,
                ),
              ),
            ),
            Expanded(
              child: userNameText,
            ),
            Expanded(
              child: scoreText,
            ),
          ],
        ),
      ),
    );
  }
}
