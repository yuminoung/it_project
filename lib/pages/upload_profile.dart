import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/widgets/custom_app_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:it_project/models/all_models.dart';

class UploadProfile extends StatefulWidget {
  @override
  _UploadProfile createState() => _UploadProfile();
}

class _UploadProfile extends State<UploadProfile> {
  bool isLoading = false;
  File _image;

  //get the image from gallery
  Future getImageFromPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future getImageFromCamera() async {
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera).then((_) {});
    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Changing Photo',
        leading: CustomIconButton(
          icon: Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: IgnorePointer(
        ignoring: isLoading,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              isLoading ? CustomProgressIndicator() : Container(),
              Center(
                  child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: _image == null
                    ? Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                      )
                    : Image.file(
                        _image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                      ),
              )),
              _fromGallery(),
              _fromCamera(),
              _saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fromGallery() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text('Upload from gallery'),
        onPressed: () {
          getImageFromPhoto();
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget _fromCamera() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text('Take a photo'),
        onPressed: () {
          getImageFromCamera();
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget _saveButton() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text("Save"),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          if (_image != null) {
            var userDoc = await UserModel.getUserDocument();
            var userRef = Firestore.instance
                .collection('users')
                .document(userDoc.documentID);

            StorageReference storageRef = FirebaseStorage.instance
                .ref()
                .child('profile/' + userDoc.documentID);
            StorageUploadTask uploadTask = storageRef.putFile(_image);
            StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
            String url = await downloadUrl.ref.getDownloadURL();
            await userRef.updateData({
              'profile_url': url,
            });
            await UserModel.resetUserModel();
            Navigator.pop(context);
          }
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }
}
