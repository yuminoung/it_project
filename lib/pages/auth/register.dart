import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:it_project/providers/auth.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';
import 'package:provider/provider.dart';

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
      appBar: CustomAppBar(
        title: 'Register',
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
                  Navigator.pushReplacement(
                    context,
                    CustomSlideFromBottomPageRouteBuilder(
                      widget: routes['/login'],
                    ),
                  );
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
          Provider.of<Auth>(context, listen: false).registerUser(_email.text,
              _password.text, _lastname.text, _firstname.text, context);
          FocusScope.of(context).unfocus();
          print(_password.text);
          print(_email.text);
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  void registerUser() async {
    final auth = FirebaseAuth.instance;
    if (_password != null &&
        _email != null &&
        _lastname != null &&
        _firstname != null) {
      auth
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((result) async {
        final firestoreRef =
            Firestore.instance.collection('users').document(result.user.uid);
        await firestoreRef.setData(
          {
            'displayName': _firstname.text + ' ' + _lastname.text,
            'families': {}
          },
        );
        FirebaseUser account = result.user;
        var userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName = _firstname.text + ' ' + _lastname.text;
        account.updateProfile(userUpdateInfo);
        account.reload();
        Navigator.pushReplacement(context,
            CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
      }).catchError((error) {
        print(error);
      });
    }
  }
}