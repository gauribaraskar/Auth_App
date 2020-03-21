import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/sign_up.dart';
import 'package:flutterapp/welcome.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String email = '';
  String password = '';

  final _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomePage()));
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
              onPressed: signIn,
              child: Text('Sign in'),
            ),
            RaisedButton(
              onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp())),
              child: Text('Sign in'),
            )

          ],
        ),
      ),
    );
  }
}

