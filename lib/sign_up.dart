import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/welcome.dart';

class SignUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }


}

class _SignUpState extends State<SignUp>{

  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomePage()));
      }
      catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Login App'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email'
                ),
                onSaved: (input) => email = input,
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onSaved: (input) => password = input,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password'
                ),
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            RaisedButton(
              onPressed: signUp,
              child: Text('Sign in'),
            )

          ],
        ),
      ),
    );
  }

}