import 'package:cloud_firestore/cloud_firestore.dart';

class ArtifactModel {
  static Stream<QuerySnapshot> fetchArtifacts(String uid) {
    print("This is " + uid);
    return Firestore.instance
        .collection('artifacts')
        .where('members', arrayContains: uid)
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
