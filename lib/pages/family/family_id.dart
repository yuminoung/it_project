import 'package:flutter/material.dart';
import 'package:it_project/widgets/custom_app_bar.dart';
import 'package:it_project/widgets/custom_pop_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FamilyID extends StatelessWidget {
  final String familyName;
  final String familyID;

  FamilyID({this.familyName, this.familyID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomPopButton(),
        title: familyName,
      ),
      body: Center(
        child: QrImage(
          data: familyID,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
