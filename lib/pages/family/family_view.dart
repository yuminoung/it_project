import 'package:flutter/material.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/models/all_models.dart';

class FamilyView extends StatelessWidget {
  final String familyID;
  final String familyName;

  FamilyView({this.familyID, this.familyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomPopButton(),
        title: familyName,
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: FamilyModel.getFamilyDocument(familyID),
          builder: (context, snapshot) {
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
          },
        ),
      ),
    );
  }
}
