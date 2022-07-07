import 'package:flutter/material.dart';
import 'package:flutter_project/Screens/addImage.dart';
import 'package:flutter_project/Screens/getImage.dart';

class imageDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return imageDrawerState();
  }
}

class imageDrawerState extends State<imageDrawer> {
  final minimunPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChooseIt"),
      ),
      body: Center(child: Text("ChoseIt- A world of CHOICE")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.only(top: minimunPadding, bottom: minimunPadding),
          children: <Widget>[
            DrawerHeader(
              child: Text("Image Central"),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text("Add WorkShop Image"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => addImage()));
              },
            ),
            ListTile(
              title: Text("Get All Images"),
              onTap: () {Navigator.push(context,
                    MaterialPageRoute(builder: (context) => getImages()));
              },
            )
          ],
        ),
      ),
    );
  }
}
