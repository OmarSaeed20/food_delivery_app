import 'dart:developer';
import '../../index.dart';

class ApiClient extends GetConnect implements GetxService {
  static ApiClient get to => Get.find();
  String? token;
  String? url;
  Map<String, String> _headers = {};
  ApiClient({this.url}) {
    baseUrl = url;
    timeout = 60.seconds;
    token = DatabaseHelper.to.getString(EndPoints.User_Token);
    _headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token",
    };
  }
// update header when user register or login
  Map<String, dynamic> updateHeader(String token) {
    return _headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Authorization": "Bearer $token",
      "HttpHeaders.contentTypeHeader": "application/json"
    };
  }

  // get data
  // url => end points
  Future<Response> getData({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      Response response = await get(url, headers: header ?? _headers);
      log('${response.body}');

      return response;
    } catch (error) {
      log('$error');
      return Response(statusCode: 404, statusText: '$error');
    }
  }

  // post data
  Future<Response> postData({
    required String url,
    required Map<dynamic, dynamic> body,
  }) async {
    try {
      Response response = await post(url, body, headers: _headers);
      log('${response.body}');

      return response;
    } catch (error) {
      log('$error');
      return Response(statusCode: 404, statusText: '$error');
    }
  }
}


// Api Client ---> السيرفر
// Repository ---> المستودع
// Models
// Ui
// Json ==>  Map<String , dynamic>


/*
Explain Json

void main(){
  Map<String , dynamic> = {
    "name" : "Mohamed",
    "age" : 21,
    "city" : "Cairo",
    "address" : 
    [
      {
        "Name" : "Role",
        "City" : "Asyut",
      },
      
      {
        "Name" : "Omar",
        "City" : "Cairo",
      }
    ],
  };
}

class Person{
  String? name;
  String? city;
  int? age;
  List<Address>? address;


  Person({
    this.name,
    this.city,
    this.age,
    this.address,
  });
  /// From Json
  Person.fromJson(Map<String , dynaimc> json) {
    name = json["name"];
    age = json["age"];
    city = json["city"];
    if(json["address"] != null){
      address = <Address>[]; or address = [];
      (json["address"] as List).forEach((e){
        address.add(Address.fromJson(e));
      });
    }
   

  }
}
/// Address
class Address{
  String? name;
  String? city;

  Address({
    this.name,
    this.city,
  });
  Address.fromJson(Map<String , dynamic> json){
    name = json["Name"];
    city = json["City"];

  }

}

 */