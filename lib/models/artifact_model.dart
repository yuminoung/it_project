import 'package:cloud_firestore/cloud_firestore.dart';

class ArtifactModel {
  static List<String> whoCanSee = [];
  static bool allCanSee = true;
  static bool onlyMeCanSee = false;
  static bool customCanSee = false;

  static Stream<QuerySnapshot> fetchArtifacts(String uid) {
    return Firestore.instance
        .collection('artifacts')
        .where('members', arrayContains: uid)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  static resetWhoCanSee() {
    whoCanSee = [];
    allCanSee = true;
    onlyMeCanSee = false;
    customCanSee = false;
  }

  static Stream<QuerySnapshot> fetchImageArtifacts(String familyID) {
    return Firestore.instance
        .collection('artifacts')
        .where('families', arrayContains: familyID)
        .where('hasImage', isEqualTo: true)
        .orderBy('created_at', descending: true)
        .snapshots();
  }

  static String humanReadableTime(Timestamp time) {
    int dayDiff = DateTime.now().difference(time.toDate()).inDays;
    int hourDiff = DateTime.now().difference(time.toDate()).inHours;
    int minuteDiff = DateTime.now().difference(time.toDate()).inMinutes;

    if (dayDiff > 0) {
      String ago = dayDiff > 1 ? " days ago" : " day ago";
      return dayDiff.toString() + ago;
    }
    if (hourDiff > 0) {
      String ago = hourDiff > 1 ? " hours ago" : " hour ago";
      return hourDiff.toString() + ago;
    }
    if (minuteDiff > 0) {
      String ago = minuteDiff > 1 ? " minutes ago" : " minute ago";
      return minuteDiff.toString() + ago;
    }
    return "Just now";
  }
}