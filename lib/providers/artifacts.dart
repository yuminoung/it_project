import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:it_project/models/all_models.dart';

class Artifact {
  String image;
  String message;
  Timestamp time;
  String docID;
  String username;
  Artifact(this.image, this.message, this.time, this.docID, this.username);
}

class Artifacts with ChangeNotifier {
  List<Artifact> _artifacts = [];
  String userId;
  String displayName;
  Artifacts(this.userId, this.displayName);

  Future<void> fetchAndSetArtifacts() async {
    print('called fetch :$displayName $userId');
    _artifacts = [];
    var all = await Firestore.instance
        .collection('artifacts')
        .where('uid', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .getDocuments();

    List<DocumentSnapshot> templist = all.documents;

    templist.map((DocumentSnapshot docSnapshot) {
      _artifacts.insert(
          _artifacts.length,
          Artifact(
              docSnapshot.data['image'],
              docSnapshot.data['message'],
              docSnapshot.data['created_at'],
              docSnapshot.documentID,
              displayName));
    }).toList();
    notifyListeners();
  }

  List<Artifact> get artifacts {
    return _artifacts;
  }

  Future<void> addArtifact(String message, File image) async {
    final ref = Firestore.instance.collection('artifacts').document();
    var userDoc = await UserModel.getUserDocument();

    var families = [];
    if (ArtifactModel.allCanSee) {
      if (userDoc.data['families'] != null) {
        userDoc.data['families'].forEach((key, _) {
          families.add(key);
        });
      }
    } else if (ArtifactModel.customCanSee) {
      families = ArtifactModel.whoCanSee;
    } else {
      families = [];
    }

    ref.setData({
      'message': message,
      'created_at': DateTime.now(),
      'user': displayName,
      'profile_url': userDoc.data['profile_url'],
      'uid': userId,
      'families': families,
      'members': [userDoc.documentID]
    });
    if (image != null) {
      StorageReference storageRef = FirebaseStorage.instance
          .ref()
          .child('images/' + ref.documentID.toString());
      StorageUploadTask uploadTask = storageRef.putFile(image);
      StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
      String url = await downloadUrl.ref.getDownloadURL();
      ref.setData({
        'image': url,
        'hasImage': true,
      }, merge: true);
    }
    fetchAndSetArtifacts();
    notifyListeners();

    // display artifact added message
    // HomeState.artifactAddedMessage();
  }
}
