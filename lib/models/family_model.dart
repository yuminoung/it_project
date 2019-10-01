import 'package:cloud_firestore/cloud_firestore.dart';
import 'all_models.dart';

class FamilyModel {
  static final _familyRef = Firestore.instance.collection('families');

  // a function to create a family in firestore and return its id
  static Future<String> createFamily(Map data) async {
    DocumentReference familyDocument = _familyRef.document();
    await familyDocument.setData(data);
    return familyDocument.documentID;
  }

  static Future<DocumentSnapshot> getFamilyDocument(String docID) async {
    return await _familyRef.document(docID).get();
  }

  static Future<void> updateFamilyDocument(String docID, data) async {
    await _familyRef.document(docID).setData(data, merge: true);
  }

  static Future<String> joinFamily(String familyID) async {
    var user = await UserModel.getUser();
    var status;

    // update family document with a new member.
    var familyDocument = await getFamilyDocument(familyID);

    if (familyDocument.data != null) {
      await UserModel.updateUserDocument({
        'families': {familyID: familyDocument.data['name']}
      });
      // var data = {
      //   'members': {user.uid: user.displayName}
      // };
      await updateFamilyDocument(familyID, {
        'members': {user.uid: user.displayName}
      });
      status = 'success';
    } else {
      status = 'error';
    }
    return status;
  }
}
