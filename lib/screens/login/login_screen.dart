import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frmproject/screens/tab/tab_screen.dart';
import 'package:frmproject/utils/constants.dart';
import 'package:flutter_plus/flutter_plus.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  final _txtEmail = TextEditingController();
  final _txtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple[500],
                  Colors.deepPurple[600],
                  Colors.deepPurple[700],
                  Colors.deepPurple[800],
                ],
              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Padawns',
                    style: TextStyle(
                      color: Colors.deepPurple[900],
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildFieldEmail(),
                  SizedBox(height: 30.0),
                  _buildFieldPassword(),
                  _buildForgotPassword(),
                  _buildRememberMeCheckbox(),
                  _buildLoginButton(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot your password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.purple[600],
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember password',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  _buildFieldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email:',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: Colors.black,
            controller: _txtEmail,
            obscureText: false,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  _buildFieldPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password:',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _txtPassword,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter your password',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          if (_validator() == true) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabScreen()),
              (Route<dynamic> route) => false,
            );
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.purple,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _validator() {
    if (!_txtEmail.text.contains('@') || !_txtEmail.text.contains('.com')) {
      snackBarPlus.showText('Invalid email!',
          backgroundColor: Colors.white, textColor: Colors.deepPurple);
      return false;
    }
    if (_txtEmail.text.isEmpty) {
      snackBarPlus.showText('Your email can\'t be empty!',
          backgroundColor: Colors.white, textColor: Colors.deepPurple);
      return false;
    }
    if (_txtPassword.text.isEmpty) {
      snackBarPlus.showText('Your password can\'t be empty!',
          backgroundColor: Colors.white, textColor: Colors.deepPurple);
      return false;
    }
    if (_txtPassword.text.length < 6) {
      snackBarPlus.showText('Your password must be longer than 6 characters!',
          backgroundColor: Colors.white, textColor: Colors.deepPurple);
      return false;
    }
    return true;
  }
}
