import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/Model/ImageModel.dart';
import 'package:http/http.dart' as http;

import 'imageDrawer.dart';

class updateImage extends StatefulWidget {
  ImageModel imageModel;

  @override
  State<StatefulWidget> createState() {
    return updateImageState(imageModel);
  }

  updateImage(this.imageModel);
}

Future<ImageModel> updateImages(
    ImageModel imageModel, BuildContext context) async {
  var Url = "http://localhost:8080/updateworkshopimage";
  var response = await http.put(Uri.parse(Url),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(imageModel));
  String responseString = response.body;
  if (response.statusCode == 200) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return MyAlertDialog(
              title: 'Backend Response', content: response.body);
        });
  }
}

class updateImageState extends State<updateImage> {
  ImageModel imageModel;
  final minimumPadding = 5.0;
  TextEditingController imageNumber;
  bool _isEnabled = false;
  TextEditingController firstController;
  TextEditingController secondController;
  TextEditingController thirdController;
  Future<List<ImageModel>> imageModels;

    updateImageState(this.imageModel) {
    imageNumber = TextEditingController(text: this.imageModel.id.toString());
    firstController = TextEditingController(text: this.imageModel.description);
    secondController = TextEditingController(text: this.imageModel.genre);
    thirdController = TextEditingController(text: this.imageModel.images);
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Image'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => imageDrawer()));
            },
          ),
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(minimumPadding * 2),
                child: ListView(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: imageNumber,
                        enabled: _isEnabled,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter the Image ID';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Image ID',
                            hintText: 'Enter Image ID',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: firstController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter the description';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Enter The Description',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: secondController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter the genre';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Genre',
                            hintText: 'Enter Genre',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          top: minimumPadding, bottom: minimumPadding),
                      child: TextFormField(
                        style: textStyle,
                        controller: secondController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'please enter the image';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'Image',
                            hintText: 'Enter Image',
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ElevatedButton(
                      child: Text('Update Details'),
                      onPressed: () async {
                        String description = firstController.text;
                        String genre = secondController.text;
                        String image = thirdController.text;
                        ImageModel im = new ImageModel();
                        im.id = imageModel.id;
                        im.description = firstController.text;
                        im.genre = secondController.text;
                        im.images = thirdController.text;
                        ImageModel imageModels =
                            await updateImages(im, context);
                        setState(() {
                          imageModel = imageModels;
                        });
                      })
                ]))));
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
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: this.actions,
      content: Text(
        this.content,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}

// class updateImageState extends State<updateImage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update Images"),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }
// }
// }
