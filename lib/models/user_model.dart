import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static final CollectionReference _userRef =
      Firestore.instance.collection('users');

  static FirebaseUser _user;
  static DocumentSnapshot _userDocument;

  // a function to get the current logged in user
  static Future<FirebaseUser> getUser() async {
    if (_user != null) {
      return _user;
    }
    _user = await FirebaseAuth.instance.currentUser();
    return _user;
  }

  // a function to get the current logged in user document from firestore
  static Future<DocumentSnapshot> getUserDocument() async {
    if (_userDocument != null) {
      return _userDocument;
    }
    final user = await getUser();
    _userDocument = await _userRef.document(user.uid).get();
    return _userDocument;
  }

  // a function to update the user document
  static Future<void> updateUserDocument(data) async {
    final user = await getUser();
    await _userRef.document(user.uid).setData(data, merge: true);
    resetUserModel();
  }

  // reset the static variables and get the new updated user document from firestore
  static void resetUserModel() async {
    _user = null;
    _userDocument = null;
    await getUser();
    await getUserDocument();
  }
}
