import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/pages/all_pages.dart';
import 'package:it_project/models/all_models.dart';

class CustomPost extends StatefulWidget {
  final String image;
  final String message;
  final Timestamp time;
  final String docID;
  final String username;
  final String uid;

  CustomPost(
      {this.image,
      this.message,
      this.time,
      this.docID,
      this.username,
      this.uid});

  @override
  _CustomPostState createState() => _CustomPostState();
}

class _CustomPostState extends State<CustomPost> {
  var uid;

  @override
  void initState() {
    super.initState();
    UserModel.getUser().then((user) {
      setState(() {
        uid = user.uid;
        print("this is user id " + uid);
        print("this is user post id " + widget.uid);
      });
    });
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
        imageUrl: widget.image,
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
              widget.username ?? 'no usrname',
              // style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            child: Text(_humanReadableTime(widget.time),
                style: TextStyle(fontSize: 10)),
          ),
          (uid == null || widget.uid != uid)
              ? Container()
              : Expanded(
                  child: Container(
                    child: PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'edit') {
                          Navigator.push(
                            context,
                            CustomSlideFromBottomPageRouteBuilder(
                              widget: EditPost(
                                docID: widget.docID,
                                image: widget.image,
                                message: widget.message,
                                time: widget.time,
                                username: widget.username,
                              ),
                            ),
                          );
                        } else if (value == 'delete') {
                          Firestore.instance
                              .document('artifacts/' + widget.docID)
                              .delete();
                          StorageReference ref = FirebaseStorage.instance
                              .ref()
                              .child('images/' + widget.docID);
                          ref.delete();
                        }
                      },
                      child: Icon(Icons.more_horiz),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('delete'),
                        )
                      ],
                    ),
                    alignment: Alignment.centerRight,
                  ),
                )
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
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
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

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildUser(context),
            (widget.message != null) ? _buildMessage() : Container(),
            (widget.image != null) ? _buildImage(context) : Container(),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}

// class CustomPost extends StatelessWidget {
//   final String image;
//   final String message;
//   final Timestamp time;
//   final String docID;
//   final String username;
//   final String uid;

//   CustomPost(
//       {this.image,
//       this.message,
//       this.time,
//       this.docID,
//       this.username,
//       this.uid});

//   Widget _buildImage(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(4),
//         bottomRight: Radius.circular(4),
//       ),
//       child: CachedNetworkImage(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.width,
//         fit: BoxFit.cover,
//         imageUrl: image,
//         placeholder: (context, url) {
//           return Container(
//               padding: EdgeInsets.all(16),
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.red,
//               ),
//               width: 50,
//               height: 50);
//         },
//       ),
//     );
//   }

//   Widget _buildUser(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
//       child: Row(
//         children: <Widget>[
//           ClipRRect(
//             borderRadius: BorderRadius.all(
//               Radius.circular(25),
//             ),
//             child: Image.asset(
//               'assets/images/profile.png',
//               height: 50,
//               width: 50,
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.all(8.0),
//             child: Text(
//               username ?? 'no usrname',
//               // style: Theme.of(context).textTheme.title,
//             ),
//           ),
//           Container(
//             child:
//                 Text(_humanReadableTime(time), style: TextStyle(fontSize: 10)),
//           ),
//           Expanded(
//             child: Container(
//               child: PopupMenuButton(
//                 onSelected: (value) {
//                   if (value == 'edit') {
//                     Navigator.push(
//                       context,
//                       CustomSlideFromBottomPageRouteBuilder(
//                         widget: EditPost(
//                           docID: docID,
//                           image: image,
//                           message: message,
//                           time: time,
//                           username: username,
//                         ),
//                       ),
//                     );
//                   } else if (value == 'delete') {}
//                 },
//                 child: Icon(Icons.more_horiz),
//                 itemBuilder: (context) => [
//                   PopupMenuItem(
//                     value: 'edit',
//                     child: Text('edit'),
//                   ),
//                   PopupMenuItem(
//                     value: 'delete',
//                     child: GestureDetector(
//                       child: Text('delete'),
//                       onTap: () {
//                         print(docID);
//                         Firestore.instance
//                             .document('artifacts/' + docID)
//                             .delete();
//                         StorageReference ref = FirebaseStorage.instance
//                             .ref()
//                             .child('images/' + docID);
//                         ref.delete();
//                         Navigator.pushReplacementNamed(context, '/');
//                       },
//                     ),
//                   )
//                 ],
//               ),
//               alignment: Alignment.centerRight,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildMessage() {
//     return Container(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         message ?? 'default no input',
//         style: TextStyle(fontFamily: 'Roboto'),
//         // textAlign: TextAlign.left,
//       ),
//       padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
//     );
//   }

//   String _humanReadableTime(Timestamp time) {
//     int dayDiff = DateTime.now().difference(time.toDate()).inDays;
//     int hourDiff = DateTime.now().difference(time.toDate()).inHours;
//     int minuteDiff = DateTime.now().difference(time.toDate()).inMinutes;

//     if (dayDiff > 0) {
//       String ago = dayDiff > 1 ? " days ago" : " day ago";
//       return dayDiff.toString() + ago;
//     }
//     if (hourDiff > 0) {
//       String ago = hourDiff > 1 ? " hours ago" : " hour ago";
//       return hourDiff.toString() + ago;
//     }
//     if (minuteDiff > 0) {
//       String ago = minuteDiff > 1 ? " minutes ago" : " minute ago";
//       return minuteDiff.toString() + ago;
//     }
//     return "Just now";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(4),
//       child: Container(
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             _buildUser(context),
//             (message != null) ? _buildMessage() : Container(),
//             (image != null) ? _buildImage(context) : Container(),
//             CustomDivider(),
//           ],
//         ),
//       ),
//     );
//   }
// }
