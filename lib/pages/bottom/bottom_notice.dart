import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:it_project/providers/artifacts.dart';
import 'package:provider/provider.dart';
// import 'package:quiver/strings.dart';
import 'package:quiver/time.dart';
import 'package:it_project/widgets/custom_post.dart';

class Bottom_Notification extends StatefulWidget {
  @override
  _Notification_State createState() => new _Notification_State();
}

class _Notification_State extends State<Bottom_Notification>{
  @override
  Widget build(BuildContext context) {
    List<Artifact> copy_artifacts = Provider.of<Artifacts>(context).artifacts;
    List<Widget> list = new List<Widget>();
    // DateTime time = new

    for(int i = 0; i < copy_artifacts.length; i++){
      //list.add(new Text("${i}"));
      if (copy_artifacts[i].image == null) {
        list.add(new Container(
          //color: Colors.grey,
            padding: EdgeInsets.all(1.0),
            child: new Card(
                color: Colors.lightBlueAccent,
                child: new Text("\nUser ${copy_artifacts[i]
                    .username} has added a new artifact text  "
                    "${_humanReadableTime(copy_artifacts[i].time).toString()}"
                    " at timedate: ${copy_artifacts[i].time.toDate()}\n",
                    style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  //style: new TextStyle(fontWeight: FontWeight.w700),),

                ))));
        //list.add(new Text(copy_artifacts[i].docID.toString()));

      } else {
        list.add(new Container(
          //color: Colors.grey,
          //margin: ,
            padding: EdgeInsets.all(12.0),
            child: new Card(
                color: Colors.orange,
                child: new Text("\nUser ${copy_artifacts[i]
                    .username} has added a new artifact text and image "
                    "${copy_artifacts[i].image.toString()} "
                    "${_humanReadableTime(copy_artifacts[i].time).toString()}"
                    " at timedate: ${copy_artifacts[i].time.toDate()}\n",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                  //style: new TextStyle(fontWeight: FontWeight.w700),),
                ))));
        //list.add(new Text(copy_artifacts[i].docID.toString()));
      }
    }
    return new Scaffold(

        body: new Container(

          child: ListView(
              children: list),
          color: Colors.black12,
        )
    );
    /*
    return new Scaffold(

      body: new Container(
        padding: new EdgeInsets.all(12.0),
        child: new Center(
          child: new Center(
            child: new Column(

              children: <Widget>[
                new ListView(children: list),
                //new Text("Hello World"),
                // new Card(child: new Container(),)
              ],
            )
          ),
        )
      ),
    );

     */
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