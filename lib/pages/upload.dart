import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it_project/models/all_models.dart';
import 'package:it_project/providers/artifacts.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

import 'all_pages.dart';

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
    FocusScope.of(context).unfocus();
  }

  Future getImageFromCamera() async {
    Navigator.pop(context);
    var image =
        await ImagePicker.pickImage(source: ImageSource.camera).then((_) {
      FocusScope.of(context).unfocus();
    });
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Upload',
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ArtifactModel.resetWhoCanSee();
            FocusScope.of(context).unfocus();

            Navigator.pop(context);
          },
          child: Icon(Icons.close),
        ),
        trailing: CustomIconButton(
          icon: Icon(Icons.done),
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            if (_textFieldController.text.isEmpty && _image == null) {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            } else {
              FocusScope.of(context).unfocus();
              await Provider.of<Artifacts>(context)
                  .addArtifact(_textFieldController.text, _image);
              Navigator.pop(context);
            }
          },
        ),
      ),

      // ignore pointer is to ignore all touch event when uploading is true
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          expands: true,
                          cursorColor: Colors.redAccent,
                          controller: _textFieldController,
                          onSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          maxLines: null,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text('Who can see?'),
                            trailing: Text(_buildWhoCanSeeText()),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CustomSlideFromBottomPageRouteBuilder(
                                      widget: WhoCanSee()));
                            },
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          title: Container(
                            margin: EdgeInsets.all(10),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.width / 4,
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            isLoading ? CustomProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }

  String _buildWhoCanSeeText() {
    if (ArtifactModel.allCanSee) {
      return 'All Families';
    } else if (ArtifactModel.onlyMeCanSee) {
      return 'Only Me';
    } else {
      return 'Custom';
    }
  }
}