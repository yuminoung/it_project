import 'package:flutter/material.dart';
import 'package:it_project/models/all_models.dart';
import 'package:it_project/pages/all_pages.dart';
import 'package:it_project/widgets/custom_app_bar.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';


class GalleryView extends StatefulWidget {
  final familyName;
  final familyID;

  GalleryView({this.familyName, this.familyID});

  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.familyName,
        leading: CustomArrowBack(),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: ArtifactModel.fetchImageArtifacts(widget.familyID),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CustomProgressIndicator();
              default:
                return GridView.count(
                  crossAxisCount: 4,
                  children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GalleryDetail(
                                  username: document['user'],
                                  imageUrl: document['image'],
                                  familyName: widget.familyName,
                                  message: document['message'],
                                  time: document['created_at'],
                                )));
                      },
                      child: Hero(
                        tag: document['image'],
                        child: CachedNetworkImage(
                          imageUrl: document['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}