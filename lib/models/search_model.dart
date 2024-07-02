class SearchModel {
  int? id;
  String? name;
  String? description;
  String? img;

  SearchModel({this.id,
    this.name,
    this.description,
    this.img,});

  SearchModel.fromJson(Map<String, dynamic>json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "description": this.description,
      "img": this.img,
    };
  }
}