import '../../index.dart';

class CartModel {
  int? productId;
  String? name;
  int? price;
  String? image;
  int? quantity;
  bool?
      isExist; // للتاكد هل المنتج المضافة ف السلة الخاص بنا موجود ف السيرفر اما لا
  String? time;
  Data? product;

  CartModel({
    this.productId,
    this.name,
    this.price,
    this.image,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });
  CartModel.fromJson(Map<String, dynamic> json) {
    productId = json["id"];
    name = json["name"];
    price = json["price"];
    image = json["img"];
    quantity = json["quantity"];
    isExist = json["isExist"];
    time = json["time"];
    product = Data.fromJson(json['product']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'name': name,
      'price': price,
      'img': image,
      'quantity': quantity,
      'isExist': isExist,
      'time': time,
      'product': product!.toJson(),
    };
  }
}
