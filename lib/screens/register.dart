import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Method
  Widget uploadButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'Name = $nameString, Email = $emailString, Password = $passwordString');
          registerFirebase();
        }
      },
    );
  }

  Future<void> registerFirebase() async {
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success');
    }).catchError((response) {
      print('Error = ${response.toString()}');

      String title = response.code;
      String message = response.message;
      myAlert(title, message);
    });
  }

  void myAlert(String titleString, String messageString) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(titleString, style: TextStyle(color: Colors.red),),
          content: Text(messageString),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name :',
        labelStyle: TextStyle(
          color: Colors.blue,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'FirstName and LastName',
        helperStyle: TextStyle(
          color: Colors.blue[200],
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.face,
          size: 36.0,
          color: Colors.blue,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Name in Blank';
        }
      },
      onSaved: (String value) {
        nameString = value;
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email :',
        labelStyle: TextStyle(
          color: Colors.green,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'Email Format',
        helperStyle: TextStyle(
          color: Colors.green[200],
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.email,
          size: 36.0,
          color: Colors.green,
        ),
      ),
      validator: (String value) {
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Email Format False';
        }
      },
      onSaved: (String value) {
        emailString = value;
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password :',
        labelStyle: TextStyle(
          color: Colors.orangeAccent,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'More 6 Charactor',
        helperStyle: TextStyle(
          color: Colors.orangeAccent[200],
          fontSize: 14.0,
          fontStyle: FontStyle.italic,
        ),
        icon: Icon(
          Icons.lock,
          size: 36.0,
          color: Colors.orangeAccent,
        ),
      ),
      validator: (String value) {
        if (value.length <= 5) {
          return 'Password False';
        }
      },
      onSaved: (String value) {
        passwordString = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        actions: <Widget>[uploadButton()],
        backgroundColor: Colors.orange[700],
        title: Text('Register'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30.0),
        alignment: Alignment.topCenter,
        child: Container(
          width: 250.0,
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                nameText(),
                emailText(),
                passwordText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
