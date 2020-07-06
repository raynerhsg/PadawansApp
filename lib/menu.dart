import 'package:flutter/material.dart';
import 'package:frmproject/login.dart';
import './first.dart' as first;
import './second.dart' as second;
import './third.dart' as third;

void main() {
  runApp(new MaterialApp(home: new MenuPage()));
}

class MenuPage extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<MenuPage> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text("Padawans"),
              backgroundColor: Colors.deepPurple,
              bottom: new TabBar(controller: controller, tabs: <Tab>[
                new Tab(icon: Icon(Icons.home)),
                new Tab(icon: Icon(Icons.photo_album)),
                new Tab(icon: Icon(Icons.done))
              ])),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.deepPurple, Colors.purple])),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Material(
                            borderRadius:
                                BorderRadius.all(Radius.circular(60.0)),
                            elevation: 400,
                            child: Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Image.asset(
                                  'assets/babyyoda2x.png',
                                  width: 80,
                                  height: 80,
                                  scale: 1,
                                ))),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.input),
                  title: Text('Sair'),
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          body: new TabBarView(controller: controller, children: <Widget>[
            first.First(),
            second.Second(),
            third.Third()
          ])),
    );
  }
}
