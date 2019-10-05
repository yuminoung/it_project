import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_project/widgets/custom_slide_from_bottom_page_route_builder.dart';

import '../routes.dart';

class Auth with ChangeNotifier {
  String _userId;

  String get userId {
    return _userId;
  }

  void loginUser(String email, String password, BuildContext context) {
    if (password != null && email != null) {
      // final auth = FirebaseAuth.instance;
      // var user = FirebaseAuth.instance.currentUser();
      // IdTokenResult idTokenResult = await user.getIdToken();
      final auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) {
        _userId = result.user.uid;
        notifyListeners();
        print('result is $result');
        print('userid is $_userId');
        Navigator.pushReplacement(context,
            CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
        return result;
      }).catchError((error) {
        print(error);
      });
    }
  }

  void registerUser(String email, String password, String lastname,
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
  }
}
