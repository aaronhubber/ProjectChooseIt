import 'dart:convert';

ImageModel imageModelJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  int id;
  String description;
  String genre;
  String images;

  ImageModel({this.id, this.description, this.genre, this.images});

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
      description: json["description"],
      genre: json["genre"],
      images: json["images"],
      id: json["id"]);

  Map<String, dynamic> toJson() => {
        "description": description,
        "genre": genre,
        "images": images,
        "id": id,
      };
}
