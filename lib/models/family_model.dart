import 'package:cloud_firestore/cloud_firestore.dart';
import 'all_models.dart';

class FamilyModel {
  static final _familyRef = Firestore.instance.collection('families');

  // a function to create a family in firestore
  static Future<void> createFamily(familyName) async {
    DocumentSnapshot userDocument = await UserModel.getUserDocument();

    // create a document in families collection
    DocumentReference familyDocument = _familyRef.document();
    await familyDocument.setData({
      'name': familyName,
      'members': {userDocument.documentID: userDocument.data['displayName']},
      'created_at': DateTime.now()
    });

    // update user document with a new family
    var newUserData = userDocument.data['families'];
    newUserData == null
        ? newUserData = {familyDocument.documentID: familyName}
        : newUserData[familyDocument.documentID] = familyName;

    await UserModel.updateUserDocument({'families': newUserData});
  }

  static Future<DocumentSnapshot> getFamilyDocument(String docID) async {
    return await _familyRef.document(docID).get();
  }

  static Future<void> updateFamilyDocument(String docID, data) async {
    await _familyRef.document(docID).updateData(data);
  }

  static Future<String> joinFamily(String familyID) async {
    var status;

    DocumentSnapshot familyDocument =
        await FamilyModel.getFamilyDocument(familyID);
    DocumentSnapshot userDocument = await UserModel.getUserDocument();

    if (familyDocument.data != null) {
      // update user document
      var newUserData = userDocument.data['families'];
      newUserData == null
          ? newUserData = {
              familyDocument.documentID: familyDocument.data['name']
            }
          : newUserData[familyDocument.documentID] =
              familyDocument.data['name'];
      await UserModel.updateUserDocument({'families': newUserData});

      // update family document
      var newFamilyData = familyDocument.data['members'];
      newFamilyData[userDocument.documentID] = userDocument.data['displayName'];
      await updateFamilyDocument(familyID, {'members': newFamilyData});

      // return success status
      status = 'success';
    } else {
      status = 'error';
    }
    return status;
  }

  static Future<void> leaveFamily(String familyID) async {
    DocumentSnapshot familyDocument =
        await FamilyModel.getFamilyDocument(familyID);
    DocumentSnapshot userDocument = await UserModel.getUserDocument();

    // delete document if the last member leave a family
    if (familyDocument.data['members'].length == 1) {
      await _familyRef.document(familyID).delete();
    } else {
      familyDocument.data['members'].remove(userDocument.documentID);
      await FamilyModel.updateFamilyDocument(
          familyID, {'members': familyDocument.data['members']});
    }

    // remove user from family
    userDocument.data['families'].remove(familyID);
    await UserModel.updateUserDocument(
        {'families': userDocument.data['families']});
  }
}
