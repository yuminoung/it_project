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
              _emailField(),
              _passwordField(),
              _registerButton(),
            ],
          ),
        ),
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
              Icons.mail_outline,
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
            hintText: 'Email',
            icon: new Icon(
              Icons.lock_outline,
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
    if (_password != null && _email != null) {
      final auth = FirebaseAuth.instance;
      final firestoreRef = Firestore.instance.collection('message').document();

      auth
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((result) {
        firestoreRef.setData(
          {
            'id': result.user.uid,
          },
        );
        Navigator.pushReplacementNamed(context, '/');
      }).catchError((error) {
        print(error);
      });
    }
  }
}
