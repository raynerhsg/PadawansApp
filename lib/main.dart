import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:frmproject/screens/login/login_screen.dart';
import 'package:frmproject/screens/tab/tab_screen.dart';

void main() {
  runApp(HomeScreen());
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterAppPlus(
      debugShowCheckedModeBanner: false,
      title: 'PadawansApp',
      theme: ThemeData(
        cursorColor: Colors.deepPurple,
      ),
      home: LoginScreen(),
    );
  }
}
