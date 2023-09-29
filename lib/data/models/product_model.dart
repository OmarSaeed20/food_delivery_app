class ProductModel {
  int? totalSize;
  int? typeId;
  int? offset;
  List<Data>? data;

  ProductModel({
    this.totalSize,
    this.typeId,
    this.offset,
    this.data,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    typeId = json['type_id'];
    offset = json['offset'];
    if (json["products"] != null) {
      data = <Data>[];
      for (var item in (json['products'] as List)) {
        data!.add(Data.fromJson(item));
      }
    }
  }
}

class Data {
  int? productId;
  String? name;
  String? desc;
  int? price;
  int? stars;
  String? image;
  String? location;
  String? createdTime;
  String? updatedTime;
  int? typeId;

  Data({
    this.productId,
    this.name,
    this.desc,
    this.price,
    this.stars,
    this.image,
    this.location,
    this.createdTime,
    this.updatedTime,
    this.typeId,
  });
  Data.fromJson(Map<String, dynamic> json) {
    productId = json["id"];
    name = json["name"];
    desc = json["description"];
    price = json["price"];
    stars = json["stars"];
    image = json["img"];
    location = json["location"];
    createdTime = json["created_at"];
    updatedTime = json["updated_at"];
    typeId = json["type_id"];
  }
  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'name': name,
      'description': desc,
      'price': price,
      'stars': stars,
      'img': image,
      'location': location,
      'created_at': createdTime,
      'updated_at': updatedTime,
      'type_id': typeId,
    };
  }
}
