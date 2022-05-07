import 'package:flutter/material.dart';

class MyExpandedSizedBox extends StatelessWidget {
  const MyExpandedSizedBox({
    Key? key,
    this.height,
  }) : super(key: key);

  final double? height;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: SizedBox(
        width: 12.0,
        height: height,
      ),
    );
  }
}
