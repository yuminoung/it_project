import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';

class EditPost extends StatefulWidget {
  final String image;
  final Timestamp time;
  final String docID;
  final String username;
  final String message;

  EditPost({this.image, this.time, this.docID, this.username, this.message});

  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  TextEditingController editTextController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    editTextController.text = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Artifact',
        leading: CustomPopButton(),
        trailing: CustomIconButton(
          icon: Icon(Icons.done),
          onTap: () async {
            setState(() {
              isLoading = true;
            });

            await Firestore.instance
                .document('artifacts/' + widget.docID)
                .updateData({'message': editTextController.text});

            FocusScope.of(context).unfocus();
            Navigator.pop(context);
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
                          controller: editTextController,
                          onSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          maxLines: null,
                          decoration: InputDecoration(border: InputBorder.none),
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
                            child: widget.image == null
                                ? Container()
                                : CachedNetworkImage(
                                    imageUrl: widget.image,
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
            isLoading ? CustomProgressIndicator() : Container()
          ],
        ),
      ),
    );
  }
}
