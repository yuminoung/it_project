import 'package:flutter/material.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/models/all_models.dart';
import 'package:it_project/pages/all_pages.dart';

class FamilyView extends StatefulWidget {
  final String familyID;
  final String familyName;
  FamilyView({this.familyID, this.familyName});

  @override
  _FamilyViewState createState() => _FamilyViewState();
}

class _FamilyViewState extends State<FamilyView> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomPopButton(),
        title: widget.familyName,
        trailing: PopupMenuButton(
          onSelected: (value) async {
            if (value == 'id') {
              Navigator.push(
                context,
                CustomSlideFromBottomPageRouteBuilder(
                    widget: FamilyID(
                  familyName: widget.familyName,
                  familyID: widget.familyID,
                )),
              );
            } else if (value == 'leave') {
              setState(() {
                isLoading = true;
              });
              await FamilyModel.leaveFamily(widget.familyID);
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.more_horiz),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'id',
              child: Text('ID'),
            ),
            PopupMenuItem(
              value: 'leave',
              child: Text('Leave'),
            )
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: FamilyModel.getFamilyDocument(widget.familyID),
            builder: (context, snapshot) {
              if (!isLoading) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, String> members =
                      snapshot.data['members'].cast<String, String>();

                  return ListView(
                    children: members.keys.map((key) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(members[key]),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  );
                }
                return CustomProgressIndicator();
              }
              return Container();
            },
          ),
        ),
        isLoading ? CustomProgressIndicator() : Container(),
      ]),
    );
  }
}
