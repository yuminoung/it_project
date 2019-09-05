import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _textFieldController = TextEditingController();
  File _image;

  //get the image from gallery
  Future getImageFromPhoto() async {
    Navigator.pop(context);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
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
      appBar: AppBar(
        title: Text('Upload'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () async {
              final ref = Firestore.instance.collection('message').document();
              if (_image != null) {
                ref.setData({
                  'message': _textFieldController.text,
                  'user': 'Yumin',
                  'date': DateTime.now(),
                });
                StorageReference storageRef = FirebaseStorage.instance
                    .ref()
                    .child('images/' + ref.documentID.toString());
                StorageUploadTask uploadTask = storageRef.putFile(_image);
                StorageTaskSnapshot downloadUrl = await uploadTask.onComplete;
                String url = await downloadUrl.ref.getDownloadURL();

                ref.setData({
                  'image': url,
                }, merge: true);
              } else {
                ref.setData({
                  'message': _textFieldController.text,
                  'user': 'Yumin',
                  'date': DateTime.now(),
                });
              }

              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
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
                    decoration: InputDecoration(border: InputBorder.none),
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
                                          title:
                                              Text('Choose photo from gallery'),
                                          onTap: getImageFromPhoto,
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.camera_alt),
                                          title: Text('Take photo with camera'),
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
    );
  }
}
