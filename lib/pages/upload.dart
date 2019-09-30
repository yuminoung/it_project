import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/widgets/custom_app_bar.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _textFieldController = TextEditingController();
  bool isLoading = false;
  File _image;

  //get the image from gallery
  Future getImageFromPhoto() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    Navigator.pop(context);
  }

  Future getImageFromCamera() async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upload',
        leading: CustomIconButton(
          onTap: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        trailing: CustomIconButton(
          icon: Icon(Icons.done),
          onTap: () async {
            FocusScope.of(context).unfocus();
            setState(() {
              isLoading = true;
            });
            final ref = Firestore.instance.collection('artifacts').document();
            var auth = await FirebaseAuth.instance.currentUser();
            final userRef =
                Firestore.instance.collection('users').document(auth.uid);
            final userData = await userRef.get();
            ref.setData({
              'message': _textFieldController.text,
              'created_at': DateTime.now(),
              'user': userData.data['first_name'] +
                  " " +
                  userData.data['last_name'],
            });
            if (_image != null) {
              StorageReference storageRef = FirebaseStorage.instance
                  .ref()
                  .child('images/' + ref.documentID.toString());
              StorageUploadTask uploadTask = storageRef.putFile(_image);
              StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
              String url = await downloadUrl.ref.getDownloadURL();
              ref.setData({
                'image': url,
              }, merge: true);
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            expands: true,
                            cursorColor: Colors.redAccent,
                            controller: _textFieldController,
                            maxLines: null,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.width / 4,
                            width: MediaQuery.of(context).size.width / 4,
                            child: _image == null
                                ? FlatButton(
                                    textColor: Colors.grey,
                                    shape: Border.all(color: Colors.grey),
                                    child: Icon(Icons.add),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                                child: Wrap(
                                              children: <Widget>[
                                                ListTile(
                                                  leading: Icon(Icons.photo),
                                                  title: Text(
                                                      'Choose photo from gallery'),
                                                  onTap: getImageFromPhoto,
                                                ),
                                                ListTile(
                                                  leading:
                                                      Icon(Icons.camera_alt),
                                                  title: Text(
                                                      'Take photo with camera'),
                                                  onTap: getImageFromCamera,
                                                )
                                              ],
                                            ));
                                          });
                                    },
                                  )
                                : Image.file(
                                    _image,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            isLoading
                ? LinearProgressIndicator(
                    backgroundColor: Color.fromRGBO(250, 250, 250, 0),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
