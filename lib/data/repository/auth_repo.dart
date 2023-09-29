import '../../index.dart';

class AuthRepo {
  static AuthRepo get to => Get.find();
 
  Future<Response> signUp({
    required SignUpBodyModel signUpBodyModel,
  }) async {
    return await ApiClient.to.postData(
        url: EndPoints.Registration_Uri, body: signUpBodyModel.toJson());
  }

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    return await ApiClient.to.postData(
      url: EndPoints.Login_Uri,
      body: {'email': email, 'password': password},
    );
  }

  // get user data
  Future<Response> getUserData() async {
    return await ApiClient.to.getData(url: EndPoints.User_Info_Uri);
  }

  // save user token
  Future<bool> saveUserToken(String token) async {
    // update user token
    ApiClient.to.token = token;
    // update header
    ApiClient.to.updateHeader(token);
    // save user token in local db
    return await DatabaseHelper.to.setString(EndPoints.User_Token, token);
  }

  // save user phone in local db
  Future<bool> saveUserPhone(String phone) async {
    return await DatabaseHelper.to.setString(EndPoints.User_Email, phone);
  }

  // save user password in local db
  Future<bool> saveUserPassword(String password) async {
    return await DatabaseHelper.to.setString(EndPoints.User_Password, password);
  }

  // get user token from local db
  String getUserToken() {
    return DatabaseHelper.to.getString(EndPoints.User_Token);
  }

  String getUserPhone() {
    return DatabaseHelper.to.getString(EndPoints.User_Email);
  }

  String getUserPassword() {
    return DatabaseHelper.to.getString(EndPoints.User_Password);
  }

  bool userLoggedIn() {
    return DatabaseHelper.to.containsKey(EndPoints.User_Token);
  }

  // remove user data from local db
  bool removeUserDataPrefs() {
    DatabaseHelper.to.remove(EndPoints.User_Token);
    DatabaseHelper.to.remove(EndPoints.User_Email);
    DatabaseHelper.to.remove(EndPoints.User_Password);
    saveUserToken('');
    return true;
  }
}
