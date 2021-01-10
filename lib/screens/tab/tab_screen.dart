import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';
import 'package:frmproject/screens/todos/todos_screen.dart';
import 'file:///C:/Users/HP/Documents/Curso/PadawansApp/lib/screens/login/login_screen.dart';
import 'file:///C:/Users/HP/Documents/Curso/PadawansApp/lib/screens/photos/photos_screen.dart';
import '../posts/posts_screen.dart';

void main() {
  runApp(new MaterialApp(home: new TabScreen()));
}

class TabScreen extends StatefulWidget {
  MyTabsState createState() => new MyTabsState();
}

class MyTabsState extends State<TabScreen> with SingleTickerProviderStateMixin {
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
            backgroundColor: Colors.deepPurple[600],
            bottom: TabBar(
              indicatorColor: Colors.white,
              controller: controller,
              tabs: <Tab>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.photo_album)),
                Tab(icon: Icon(Icons.done))
              ],
            ),
          ),
          drawer: Drawer(
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.deepPurple[600],
                        Colors.purple[700],
                      ],
                    ),
                  ),
                  child: ContainerPlus(
                    isCircle: true,
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/yodinha.png'),
                  ),
                ),
                ListTile(
                  trailing: Icon(Icons.input, color: Colors.black),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    dialogPlus.showDefault(
                      title: 'Log out?',
                      elementsSpacing: 16,
                      buttonOneText: 'No',
                      buttonOneColor: Colors.red,
                      buttonOneCallback: () {
                        navigatorPlus.back();
                      },
                      buttonTwoText: 'Yes',
                      buttonTwoColor: Colors.green,
                      buttonTwoCallback: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          body: TabBarView(controller: controller, children: <Widget>[
            PostsScreen(),
            PhotosScreen(),
            ToDosScreen(),
          ])),
    );
  }
}
