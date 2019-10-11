import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_project/widgets/custom_slide_from_bottom_page_route_builder.dart';

import '../routes.dart';

class Auth with ChangeNotifier {
  String _userId;
  String _displayName;

  String get userId {
    print('userID in Authg is $_userId');
    return _userId;
  }

  String get displayName {
    // var document =
    //     await Firestore.instance.collection("users").document(_userId).get();
    print('display name in Auth is $_displayName');
    return _displayName;
  }

  Future<void> loginUser(String email, String password, BuildContext context) {
    if (password != null && email != null) {
      // final auth = FirebaseAuth.instance;
      // var user = FirebaseAuth.instance.currentUser();
      // IdTokenResult idTokenResult = await user.getIdToken();
      final auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) {
        _userId = result.user.uid;
        _displayName = result.user.displayName;
        print('login :name is$_displayName id is $_userId');
        notifyListeners();

        Navigator.pushReplacement(context,
            CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
        return result;
      }).catchError((error) {
        print(error);
      });
    }
    return null;
  }

  Future<void> registerUser(String email, String password, String lastname,
      String firstname, BuildContext context) {
    final auth = FirebaseAuth.instance;
    if (password != null &&
        email != null &&
        lastname != null &&
        firstname != null) {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) async {
        final firestoreRef =
            Firestore.instance.collection('users').document(result.user.uid);
        _userId = result.user.uid;
        notifyListeners();
        await firestoreRef.setData(
          {'displayName': firstname + ' ' + lastname, 'families': {}},
        );
        FirebaseUser account = result.user;
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = firstname + ' ' + lastname;
        account.updateProfile(userUpdateInfo);
        account.reload();

        Navigator.pushReplacement(context,
            CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
      }).catchError((error) {
        print(error);
      });
    }
    return null;
  }

  Future<void> updateUser(
      String lastname, String firstname, BuildContext context) async {
    print('updateUser called');
    if (lastname != null && firstname != null) {
      await FirebaseAuth.instance.currentUser().then((result) async {
        await Firestore.instance
            .collection('users')
            .document(result.uid)
            .setData({'displayName': firstname + ' ' + lastname});
        _displayName = firstname + ' ' + lastname;

        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = firstname + ' ' + lastname;
        result.updateProfile(userUpdateInfo);
        result.reload();
        Navigator.pop(context);
      });
    }
    print('new name is $_displayName id is $_userId');
    notifyListeners();
  }
}