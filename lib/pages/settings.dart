import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it_project/widgets/all_widgets.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
        leading: CustomIconButton(
          icon: Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              _firstnameField(),
              _lastnameField(),
              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstnameField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _firstname,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'First Name',
            icon: new Icon(
              Icons.text_format,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _lastnameField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _lastname,
        maxLines: 1,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Last Name',
            icon: new Icon(
              Icons.text_format,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _confirmButton() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text('Confirm Changes'),
        onPressed: () {
          updateUser();
          FocusScope.of(context).unfocus();
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  void updateUser() async {
    if (_lastname.text != null && _firstname.text != null) {
      await FirebaseAuth.instance.currentUser().then((result) async {
        await Firestore.instance
            .collection('users')
            .document(result.uid)
            .updateData(
                {'first_name': _firstname.text, 'last_name': _lastname.text});
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _firstname.text + ' ' + _lastname.text;
        result.updateProfile(userUpdateInfo);
        result.reload();
        Navigator.pop(context);
      });
    }
  }
}
