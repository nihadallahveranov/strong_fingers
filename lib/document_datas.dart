import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentDatas {
  static int _lengthDocuments = 1;

  static get getLengthDocuments {
    FirebaseFirestore.instance.collection("users").get().then(
      (event) {
        _lengthDocuments = event.size;
        /* for (var doc in event.docs) {
          _lengthDocuments++;
        } */
      },
    );
    return _lengthDocuments;
  }

  static bool value = false;
  Future<void> isTakenUsername(String userName) async {
    await FirebaseFirestore.instance.collection("users").get().then(
      (event) {
        for (var doc in event.docs) {
          if (doc.get('userName') == userName) {
            value = true;
            break;
          }
          value = false;
        }
      },
    );
  }

  static int score = 0;
  Future<int> getScore(String userName) async {
    await FirebaseFirestore.instance.collection("users").get().then(
      (event) {
        for (var doc in event.docs) {
          if (doc.get('userName') == userName) {
            score = doc.get('score');
            break;
          }
          score = 0;
        }
      },
    );
    return score;
  }
}
