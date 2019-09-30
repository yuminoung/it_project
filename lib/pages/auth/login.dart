import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Login',
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Form(
          child: ListView(
            children: <Widget>[
              _emailField(),
              _passwordField(),
              _loginButton(),
              FlatButton(
                child: Text('Don\'t have an account?'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    CustomSlideFromBottomPageRouteBuilder(
                      widget: routes['/register'],
                    ),
                  );
                },
              ),
              // FlatButton(
              //   child: Text('Forgot password?'),
              //   focusColor: Colors.redAccent,
              //   hoverColor: Colors.redAccent,
              //   onPressed: () {
              //     Navigator.pushReplacementNamed(context, '/register');
              //   },
              // )
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

  Widget _loginButton() {
    return Padding(
      child: RaisedButton(
        padding: EdgeInsets.all(16.0),
        child: Text('Login'),
        onPressed: () {
          FocusScope.of(context).unfocus();
          loginUser();
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  Future<void> loginUser() async {
    if (_password != null && _email != null) {
      final auth = FirebaseAuth.instance;
      auth
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((result) {
        print(result.user.uid);
        Navigator.pushReplacement(context,
            CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
      }).catchError((error) {
        print(error);
      });
    }
  }
}
