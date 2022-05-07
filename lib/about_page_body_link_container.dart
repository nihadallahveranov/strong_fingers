import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPageBodyLinkContainer extends StatelessWidget {
  const AboutPageBodyLinkContainer({
    Key? key,
    required this.uri,
    required this.assetName,
    required this.containerText,
    required this.assetColor,
    required this.tileColor,
    required this.textColor,
    required this.message,
  }) : super(key: key);

  final Uri uri;
  final String assetName;
  final String containerText;
  final Color assetColor;
  final Color tileColor;
  final Color textColor;
  final String message;

  void _launchUrl(Uri uriObject) async {
    if (!await launchUrl(uriObject)) throw 'Could not launch $uriObject';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.only(
        top: 24.0,
      ),
      child: Tooltip(
        message: message,
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              32.0,
            ),
          ),
          // tileColor: Colors.white54,
          tileColor: tileColor,
          textColor: Colors.black,
          leading: SvgPicture.asset(
            assetName,
            width: 36.0,
            color: assetColor,
          ),
          title: Text(
            containerText,
            textAlign: TextAlign.start,
            softWrap: false,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () => _launchUrl(uri),
        ),
      ),
    );
  }
}
