import 'package:flutter/material.dart';
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
  TextEditingController _confirmPass = TextEditingController();

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
              RaisedButton(
                child: Text('Register'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: (){
                  if (_password.text != _confirmPass.text) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error", style: TextStyle(color: Colors.red, fontSize: 18),),
                          content: Text("The passwords does not match", style:TextStyle(color: Colors.black, fontSize: 18)),
                          actions: <Widget> [
                            FlatButton(
                              child: Text("Close"),
                              onPressed: () {Navigator.of(context).pop();}
                            )
                          ]
                        );
                      }
                    );
                  }
                  else{
                    Provider.of<Auth>(context, listen: false).registerUser(_email.text,
                    _password.text, _lastname.text, _firstname.text, context);
                    FocusScope.of(context).unfocus();
                    print(_password.text);
                    print(_email.text);
                  }
                },
              ),
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
        controller: _confirmPass,
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
}