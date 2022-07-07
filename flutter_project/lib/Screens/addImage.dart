// ignore_for_file: body_might_complete_normally_nullable

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Model/ImageModel.dart';

import 'package:http/http.dart' as http;

class addImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return addImageState();
  }
}

Future<ImageModel> addImages(String description, String genre, String images,
    BuildContext context) async {
  var Url = Uri.parse("http://localhost:8080/addworkshopimage");
  var response = await http.post(Url,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "description": description,
        "genre": genre,
        "images": images,
      }));

  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return MyAlertDialog(title: 'Backend Response', content: response.body);
      },
    );
  }
}

class addImageState extends State<addImage> {
  final minimumPadding = 5.0;
  TextEditingController firstController = TextEditingController();
  TextEditingController secondController = TextEditingController();
  TextEditingController thirdController = TextEditingController();
  ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Workshop Image"),
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.all(minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextFormField(
                  style: textStyle,
                  controller: firstController,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please add image";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Add a description for the image",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)))),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextFormField(
                  style: textStyle,
                  controller: secondController,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please add image";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Genre",
                      hintText: "Add a genre for the image",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)))),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: minimumPadding, bottom: minimumPadding),
              child: TextFormField(
                  style: textStyle,
                  controller: thirdController,
                  // ignore: missing_return
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Please add image";
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Image",
                      hintText: "Add a image",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)))),
            ),

            ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  String description = firstController.text;
                  String genre = secondController.text;
                  String image = thirdController.text;
                  ImageModel imageModels =
                      await addImages(description, genre, image, context);
                  firstController.text = '';
                  secondController.text = '';
                  thirdController.text = '';
                  setState(() {
                    imageModel = imageModels;
                  });
                })
            // ElevatedButton(
            //     onPressed: () async {
            //       String description = firstController.text;
            //       String genre = secondController.text;
            //       String image = thirdController.text;
            //     },
            //     child: Text("Submit"))
          ],
        ),
      )),
    );
  }
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  MyAlertDialog({
    this.title,
    this.content,
    this.actions = const [],
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        this.title,
      ),
      actions: this.actions,
      content: Text(
        this.content,
      ),
    );
  }
}
