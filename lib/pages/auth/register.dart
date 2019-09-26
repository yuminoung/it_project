import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _firstname = TextEditingController();
  TextEditingController _lastname = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              _firstnameField(),
              _lastnameField(),
              _emailField(),
              _passwordField(),
              _confirmPasswordField(),
              _registerButton(),
              FlatButton(
                child: Text('Already have an account?'),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              )
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


  Widget _emailField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _email,
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _password,
        obscureText: true,
        maxLines: 1,
        // keyboardType: TextInputType.visiblePassword,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _password,
        obscureText: true,
        maxLines: 1,
        // keyboardType: TextInputType.visiblePassword,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Confirm Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget _registerButton() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text('Register'),
        onPressed: () {
          registerUser();
          FocusScope.of(context).unfocus();
          print(_password.text);
          print(_email.text);
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  void registerUser() async {
    if (_password != null && _email != null && 
    _lastname != null && _firstname != null) {
      final auth = FirebaseAuth.instance;

      auth
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((result) async {
        final firestoreRef =
            Firestore.instance.collection('users').document(result.user.uid);
        await firestoreRef.setData(
          {
            'id': result.user.uid,
            'first_name': _firstname.text,
            'last_name': _lastname.text,
            'family': null,
          },
        );
        FirebaseUser account = result.user;
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _firstname.text + ' ' + _lastname.text;
        account.updateProfile(userUpdateInfo);
        account.reload();
        Navigator.pushReplacementNamed(context, '/');
      }).catchError((error) {
        print(error);
      });
    }
  }
}
