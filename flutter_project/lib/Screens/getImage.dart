import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/Model/ImageModel.dart';
import 'package:flutter_project/Screens/imageDrawer.dart';
import 'package:flutter_project/Screens/removeImage.dart';
import 'package:flutter_project/Screens/updateImage.dart';
import 'package:http/http.dart' as http;

class getImages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return getAllImagesState();
  }
}

class getAllImagesState extends State<getImages> {
  var images = List<ImageModel>.generate(200, (index) => null);

  Future<List<ImageModel>> getImages() async {
    var data =
        await http.get(Uri.parse("http://localhost:8080/getallworkshopimages"));
    var jsonData = json.decode(data.body);

    List<ImageModel> image = [];
    for (var e in jsonData) {
      ImageModel imageModel = new ImageModel();
      imageModel.id = e["id"];
      imageModel.description = e["description"];
      imageModel.genre = e["genre"];
      imageModel.images = e["images"];
      image.add(imageModel);
    }
    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Images"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => imageDrawer()));
          },
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: getImages(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(child: Center(child: Icon(Icons.error)));
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('ID' + ' ' + 'Description' + ' ' + 'Genre' + ' ' + 'Image'),
                    subtitle: Text('${snapshot.data[index].id}' +
                        '${snapshot.data[index].description}' +
                        '${snapshot.data[index].genre}' + 
                        '${snapshot.data[index].images}'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(snapshot.data[index])));
                    },
                  );
                });
            }
        ),
        )
      );
  
  }
}
class DetailPage extends StatelessWidget {
  ImageModel imageModel;

  DetailPage(this.imageModel);

  deleteImage1(ImageModel imageModel) async {
    final url = Uri.parse('http://localhost:8080/removeworkshopimage');
    final request = http.Request("DELETE", url);
    request.headers
        .addAll(<String, String>{"Content-type": "application/json"});
    request.body = jsonEncode(imageModel);
    final response = await request.send();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(imageModel.description),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => updateImage(imageModel)));
              })
        ],
      ),
      body: Container(
        child: Text('Description' +
            ' ' +
            imageModel.description +
            ' ' +
            'Genre' +
            imageModel.genre + ' ' + 'Images' + imageModel.images),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteImage1(imageModel);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => deleteImage()));
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
