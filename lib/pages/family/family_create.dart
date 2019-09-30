import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_project/widgets/custom_progress_indicator.dart';

class FamilyCreate extends StatefulWidget {
  @override
  _FamilyCreateState createState() => _FamilyCreateState();
}

class _FamilyCreateState extends State<FamilyCreate> {
  final TextEditingController _familyName = TextEditingController();

  bool hasError = false;
  bool isLoading = false;
  bool isValidated = false;
  String errorText;

  @override
  void dispose() {
    super.dispose();
    _familyName.dispose();
  }

  @override
  void initState() {
    super.initState();
    _familyName.addListener(_familyNameValidator);
  }

  void _familyNameValidator() {
    if (_familyName.text.isEmpty) {
      setState(() {
        hasError = true;
        isValidated = false;
        errorText = 'Family name must not be empty';
      });
    } else if (_familyName.text.length <= 3) {
      setState(() {
        hasError = true;
        isValidated = false;
        errorText = 'Your family name must longer than 3 characters';
      });
    } else {
      setState(() {
        hasError = false;
        isValidated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomIconButton(
          icon: Icon(Icons.close),
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
        title: 'Create a Family',
      ),
      body: IgnorePointer(
        ignoring: isLoading,
        child: Stack(children: [
          isLoading ? CustomProgressIndicator() : Container(),
          Container(
            // padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: ListView(
              children: <Widget>[
                _buildFamilyNameTextField(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildFamilyNameTextField() {
    return Container(
      padding: EdgeInsets.all(16),
      // contentPadding: EdgeInsets.all(30.0),
      child: TextField(
        cursorColor: Colors.black87,
        controller: _familyName,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
          errorText: hasError ? errorText : null,
          hintText: 'Family Name',
          border: OutlineInputBorder(borderSide: BorderSide.none),
          // enabledBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
          // focusedBorder:
          //     OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),
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
          if (isValidated) {
            isLoading = true;
            final familyRef =
                Firestore.instance.collection('families').document();

            var currentUser = await FirebaseAuth.instance.currentUser();
            var currentUserID = currentUser.uid;
            var currentUsername = currentUser.displayName;

            // upload
            await familyRef.setData({
              'name': _familyName.text,
              'members': {currentUserID: currentUsername},
            });
            Navigator.pop(context);
          }
        },
        child: Text(
          'Create',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
    );
  }
}
