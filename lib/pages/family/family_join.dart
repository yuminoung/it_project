import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/models/all_models.dart';

class FamilyJoin extends StatefulWidget {
  @override
  _FamilyJoinState createState() => _FamilyJoinState();
}

class _FamilyJoinState extends State<FamilyJoin> {
  bool isLoading = false;
  TextEditingController _familyID = TextEditingController();
  bool hasError = false;
  String errorText;

  @override
  void dispose() {
    _familyID.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomPopButton(),
        title: 'Join a Family',
        trailing: CustomIconButton(
          onTap: () {
            print('qr scanner');
          },
          icon: ImageIcon(
            AssetImage('assets/icons/qr.png'),
            size: 24,
          ),
        ),
      ),
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(children: [
          isLoading ? CustomProgressIndicator() : Container(),
          Container(
            child: ListView(
              children: <Widget>[
                _buildFamilyIDTextField(),
                _buildSubmitButton()
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildFamilyIDTextField() {
    return Container(
      padding: EdgeInsets.all(16),
      // contentPadding: EdgeInsets.all(30.0),
      child: TextField(
        onTap: () {
          hasError = false;
        },
        cursorColor: Colors.black87,
        controller: _familyID,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          errorText: hasError ? errorText : null,
          hintText: 'Family ID',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: RaisedButton(
        padding: EdgeInsets.all(16),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          setState(() {
            isLoading = true;
          });

          String joinStatus = await FamilyModel.joinFamily(_familyID.text);
          if (joinStatus == 'success') {
            Navigator.pop(context);
          } else {
            setState(() {
              hasError = true;
              errorText = 'The family ID doesn\'t exists, please try again';
              isLoading = false;
            });
          }
        },
        child: Text(
          'Join',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
