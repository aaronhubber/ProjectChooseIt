import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/Model/ImageModel.dart';
import 'package:flutter_project/Screens/getImage.dart';
import 'package:http/http.dart' as http;

class deleteImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return deleteImageState();
  }
}

Future<ImageModel> deleteImages(String description, String genre, String images) async {
  var Url = "http://localhost:8080/removeworkshopimage";
  var response = await http.delete(
    Uri.parse(Url),
    headers: <String, String>{
      "Content-Type": "application/json;charset=UTF-8,"
    },
  );
  return ImageModel.fromJson(jsonDecode(response.body));
}

class deleteImageState extends State<deleteImage> {
  @override
  Widget build(BuildContext context) {
    return getImages();
          }

  }
