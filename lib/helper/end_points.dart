// ignore_for_file: constant_identifier_names

class EndPoints {
  static const String App_Name = 'Food Dlivery';
  static const int App_Version = 1;

  static const String App_Url = 'http://192.168.98.118:8000';
  static const String Popular_Products_Uri = '/api/v1/products/popular';
  static const String Recommended_Products_Uri = '/api/v1/products/recommended';
  static const String Drinks_Products_Uri = '/api/v1/products/drinks';
  static const String Uploads_Uri = '$App_Url/uploads/';

  static const String User_Token = '';
  static const String User_Email = '';
  static const String User_Password = '';
  static const String User_Address = '';
  static const String Registration_Uri = '/api/v1/auth/register';
  static const String Login_Uri = '/api/v1/auth/login';
  static const String User_Info_Uri = '/api/v1/customer/info';
  static const String Geocoding_Uri = '/api/v1/config/geocode-api';
  static const String Zone_Uri = '/api/v1/config/get-zone-id';
  static const String Add_Address_Uri = '/api/v1/customer/address/add';
  static const String Address_List_Uri = '/api/v1/customer/address/list';

  static const String Cart_List = 'Cart-List';
  static const String Orders_List = 'Orders-List';
}
