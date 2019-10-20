import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:it_project/models/all_models.dart';

class GalleryDetail extends StatefulWidget {
  final imageUrl;
  final familyName;
  final message;
  final username;
  final time;

  GalleryDetail(
      {this.imageUrl, this.familyName, this.message, this.username, this.time});

  @override
  _GalleryDetailState createState() => _GalleryDetailState();
}

class _GalleryDetailState extends State<GalleryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leading: CustomArrowBack(),
          title: widget.familyName,
        ),
        body: ListView(children: [
          Column(
            children: <Widget>[
              Hero(
                tag: widget.imageUrl,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.contain,
                ),
              ),
              _buildUser(context),
              (widget.message.isEmpty) ? Container() : _buildMessage(),
            ],
          ),
        ]));
  }

  Widget _buildUser(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            child: Image.asset(
              'assets/images/profile.png',
              height: 50,
              width: 50,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.username ?? 'no usrname',
              // style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            child: Text(ArtifactModel.humanReadableTime(widget.time),
                style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.message ?? 'default no input',
        style: TextStyle(fontFamily: 'Roboto'),
        // textAlign: TextAlign.left,
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    );
  }
}