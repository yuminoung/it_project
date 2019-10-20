import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/models/all_models.dart';

class WhoCanSee extends StatefulWidget {
  @override
  _WhoCanSeeState createState() => _WhoCanSeeState();
}

class _WhoCanSeeState extends State<WhoCanSee> {
  List<String> _canSee = <String>[];
  bool _allCanSee = true;
  bool _customCanSee = false;
  bool _onlyMeCanSee = false;

  @override
  void initState() {
    super.initState();
    _canSee = ArtifactModel.whoCanSee;
    _customCanSee = ArtifactModel.customCanSee;
    _onlyMeCanSee = ArtifactModel.onlyMeCanSee;
    _allCanSee = ArtifactModel.allCanSee;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Who Can See',
        leading: CustomPopButton(),
        trailing: CustomIconButton(
            onTap: () {
              ArtifactModel.allCanSee = _allCanSee;
              ArtifactModel.customCanSee = _customCanSee;
              ArtifactModel.onlyMeCanSee = _onlyMeCanSee;
              ArtifactModel.whoCanSee = _canSee;
              Navigator.pop(context);
            },
            icon: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.red,
                child: Text(
                  'SAVE',
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'RobotoMono'),
                ),
              ),
            )),
      ),
      body: ListView(children: [
        ListTile(
          title: Text('Everyone'),
          trailing: _allCanSee
              ? Icon(
                  Icons.done,
                  color: Colors.red,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          onTap: () {
            setState(() {
              _canSee = [];
              _allCanSee = true;
              _customCanSee = false;
              _onlyMeCanSee = false;
            });
          },
        ),
        Divider(),
        ListTile(
          title: Text('Only me'),
          trailing: _onlyMeCanSee
              ? Icon(
                  Icons.done,
                  color: Colors.red,
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          onTap: () {
            setState(() {
              _canSee = [];
              _allCanSee = false;
              _customCanSee = false;
              _onlyMeCanSee = true;
            });
          },
        ),
        Divider(),
        FutureBuilder(
          future: UserModel.getUserDocument(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data['families'].length != 0) {
              Map<String, String> families =
                  snapshot.data['families'].cast<String, String>();
              return Column(
                children: families.keys.map((key) {
                  bool _selected = _canSee.contains(key);

                  return Column(
                    children: [
                      ListTile(
                        trailing: _selected && _customCanSee
                            ? Icon(
                                Icons.done,
                                color: Colors.red,
                              )
                            : Container(
                                height: 0,
                                width: 0,
                              ),
                        title: Text(families[key]),
                        onTap: () {
                          if (_canSee.contains(key)) {
                            setState(() {
                              _canSee.remove(key);
                              _allCanSee = false;
                              _onlyMeCanSee = false;
                              _customCanSee = true;
                              if (_canSee.isEmpty) {
                                _allCanSee = true;
                                _customCanSee = false;
                                _onlyMeCanSee = false;
                              }
                            });
                          } else {
                            setState(() {
                              _canSee.add(key);
                              _allCanSee = false;
                              _onlyMeCanSee = false;
                              _customCanSee = true;
                            });
                          }
                        },
                      ),
                      Divider(),
                    ],
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ]),
    );
  }
}