import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  // a key to reference to login page for displaying error messages
  static final GlobalKey<ScaffoldState>  _loginstate = new GlobalKey<ScaffoldState>();

  static void wrongPassword() {
    _loginstate.currentState.showSnackBar(new SnackBar(
        content: new Text("Wrong User Name or Password")));
  }

  static void loginWarning(String warning) {
    _loginstate.currentState.showSnackBar(new SnackBar(
        content: new Text(warning)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _loginstate,
      appBar: CustomAppBar(
        title: 'Login',
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
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
          Provider.of<Auth>(context, listen: false)
              .loginUser(_email.text, _password.text, context);

          // var test = FirebaseAuth.instance.signInWithCustomToken();
          // FirebaseAuth.instance.signInWithCustomToken()
          // print('current user is $test');
        },
      ),
      padding: EdgeInsets.all(8.0),
    );
  }

  // Future<void> loginUser() async {
  //   if (_password != null && _email != null) {
  //     final auth = FirebaseAuth.instance;
  //     // var user = FirebaseAuth.instance.currentUser();
  //     // IdTokenResult idTokenResult = await user.getIdToken();
  //     auth
  //         .signInWithEmailAndPassword(
  //             email: _email.text, password: _password.text)
  //         .then((result) {
  //       print('ufutdfju is $result');
  //       Navigator.pushReplacement(context,
  //           CustomSlideFromBottomPageRouteBuilder(widget: routes['/']));
  //     }).catchError((error) {
  //       print(error);
  //     });
  //   }
  // }
}
