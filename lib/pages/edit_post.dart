import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:it_project/providers/artifacts.dart';
import 'package:it_project/widgets/all_widgets.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class EditPost extends StatefulWidget {
  static const routeName = '/edit';
  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  String temp;
  var message;
  var time;
  var docID;
  var username;
  var image;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      print('routeArgs is $routeArgs');
      time = routeArgs['time'];
      docID = routeArgs['docID'];
      username = routeArgs['username'];
      image = routeArgs['image'];
      message = routeArgs['message'];
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    Provider.of<Artifacts>(context, listen: false).fetchAndSetArtifacts();
    return Scaffold(
        appBar: AppBar(
          title: Text('Edit Post'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.done),
              tooltip: 'confirm',
              onPressed: () {
                setState(() {
                  Firestore.instance
                      .document('artifacts/' + docID)
                      .updateData({'message': temp});
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    _buildUser(context),
                    (message != null)
                        ? Container(
                            child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Edit message'),
                                onChanged: (text) {
                                  temp = text;
                                },
                                initialValue: message,
                                style: TextStyle(fontFamily: 'Roboto')),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                          )
                        : Container(),
                    (image != null)
                        ? _buildImage(context)
                        : Container(child: Text('iamge is$image')),
                    CustomDivider(),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      child: CachedNetworkImage(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        imageUrl: image,
        placeholder: (context, url) {
          return Container(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              width: 50,
              height: 50);
        },
      ),
    );
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
              username,
              // style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            child:
                Text(_humanReadableTime(time), style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }

  String _humanReadableTime(Timestamp time) {
    int dayDiff = DateTime.now().difference(time.toDate()).inDays;
    int hourDiff = DateTime.now().difference(time.toDate()).inHours;
    int minuteDiff = DateTime.now().difference(time.toDate()).inMinutes;

    if (dayDiff > 0) {
      String ago = dayDiff > 1 ? " days ago" : " day ago";
      return dayDiff.toString() + ago;
    }
    if (hourDiff > 0) {
      String ago = hourDiff > 1 ? " hours ago" : " hour ago";
      return hourDiff.toString() + ago;
    }
    if (minuteDiff > 0) {
      String ago = minuteDiff > 1 ? " minutes ago" : " minute ago";
      return minuteDiff.toString() + ago;
    }
    return "Just now";
  }
}
