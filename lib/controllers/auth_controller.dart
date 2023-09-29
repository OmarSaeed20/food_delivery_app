import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../index.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    if (userLoggedIn()) {
      getUserData();
    }
  }

  // loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;

  // response model (result)
  ResponseModel? _response;
  // get user data

  UserModel? _userModel;
  UserModel? get userModel => _userModel;

  // registration and login
  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;

  final TextEditingController _email = TextEditingController();
  TextEditingController get email => _email;

  final TextEditingController _password = TextEditingController();
  TextEditingController get password => _password;

  final TextEditingController _phone = TextEditingController();
  TextEditingController get phone => _phone;

  // check all feilds valid or not valid
  bool _isEmptyFeild = true;
  bool get isEmptyFeild => _isEmptyFeild;

  // hide password
  bool _isPassword = true;
  bool get isPassword => _isPassword;

  // check all feilds valid or not valid
  
  void isCheckFeilds(bool val) {
    _isEmptyFeild = val;
    update();
  }

  void onChangedSignIn() {
    GetUtils.isEmail(email.text) &&
            GetUtils.isLengthGreaterThan(password.text, 6)
        ? isCheckFeilds(false)
        : isCheckFeilds(true);
  }

  void onChangedSignUp() {
    GetUtils.isBlank(name.text) == false &&
            GetUtils.isLengthGreaterThan(password.text, 6) &&
            GetUtils.isEmail(email.text) &&
            GetUtils.isLengthEqualTo(phone.text, 11)
        ? isCheckFeilds(false)
        : isCheckFeilds(true);
  }

  IconData suffixIcon = CupertinoIcons.eye;
  void hiddenPassword() {
    _isPassword = !_isPassword;
    suffixIcon = _isPassword ? CupertinoIcons.eye : CupertinoIcons.eye_slash;
    update();
  }

  Future<ResponseModel> signUp() async {
    try {
      _isLoading = true;
      update();
      SignUpBodyModel signUpModel = SignUpBodyModel();
      signUpModel
        ..name = _name.text.trim()
        ..email = _email.text.trim()
        ..password = _password.text.trim()
        ..phone = _phone.text.trim();
      Response response =
          await AuthRepo.to.signUp(signUpBodyModel: signUpModel);

      if (response.statusCode == 200) {
        saveUserToken(response.body['token']);
        _response = (ResponseModel(true, response.body['token']));
      } else {
        _response = (ResponseModel(false, '${response.statusText}'));
        for (var error in response.body['errors']) {
          snackBarWidget(title: 'Error', msg: '${error['message']}');
          log('${error['message']}');
        }
      }
      _isLoading = false;
      update();
    } catch (error) {
      log('error in sign up ---> $error');
    } finally {
      if (_isLoading == true) {
        _isLoading = false;
        update();
      }
    }
    return _response!;
  }

  Future<void> onTappedSignUp() async {
    ResponseModel response = await signUp();
    if (response.isSuccess) {
      log('---- Device Token ----> ${getUserToken()}');
      Get.offNamedUntil(AppRoutes.main, (route) => false);
    } else {
      log('error in onTapped sign up ---> ${response.message}');
    }
  }

  Future<ResponseModel> signIn() async {
    try {
      _isLoading = true;
      update();
      getUserToken();

      String email = _email.text.trim();
      String password = _password.text.trim();

      Response response =
          await AuthRepo.to.signIn(email: email, password: password);
      if (response.statusCode == 200) {
        saveUserToken(response.body['token']);
        _response = (ResponseModel(true, response.body['token']));
      } else {
        _response = (ResponseModel(false, '${response.statusText}'));
        for (var error in response.body['errors']) {
          snackBarWidget(title: 'Error', msg: '${error['message']}');
          log('${error['message']}');
        }
      }
      _isLoading = false;
      update();
    } catch (error) {
      log('error in sign in ---> $error');
    } finally {
      if (_isLoading == true) {
        _isLoading = false;
        update();
      }
    }
    return _response!;
  }

  Future<void> onTappedSignIn() async {
    ResponseModel response = await signIn();
    if (response.isSuccess) {
      log('---- Device Token ----> ${getUserToken()}');
      Get.offNamedUntil(AppRoutes.main, (route) => false);
    } else {
      log('error in onTapped sign in ---> ${response.message}');
    }
  }

  // get user data
  Future<void> getUserData() async {
    try {
      _isUserLoading = true;
      /*
      update();
      */
      Response response = await AuthRepo.to.getUserData();
      if (response.statusCode == 200) {
        _userModel = UserModel.fromJson(response.body);
        _response = ResponseModel(true, 'successfully');
      } else {
        _response = ResponseModel(false, '${response.statusText}');
      }
      _isUserLoading = false;
      update();
    } catch (error) {
      log('error in get user data ---> $error');
    }
  }

  // save user data in local db
  // token
  void saveUserToken(String token) => AuthRepo.to.saveUserToken(token);
  // phone
  void saveUserPhone(String phone) => AuthRepo.to.saveUserPhone(phone);
  // password
  void saveUserPassword(String password) =>
      AuthRepo.to.saveUserPassword(password);

  // get user data from local db
  // token
  String getUserToken() => AuthRepo.to.getUserToken();
  // phone number
  String getUserPhone() => AuthRepo.to.getUserPhone();
  // password
  String getUserPassword() => AuthRepo.to.getUserPassword();
  // check user loggedIn or not
  bool userLoggedIn() => AuthRepo.to.userLoggedIn();

  // remove user data from local db
  bool removeUserDataPrefs() => AuthRepo.to.removeUserDataPrefs();

  // user log out
  void userLogout() {
    try {
      if (userLoggedIn()) {
        if (removeUserDataPrefs()) {
          Get.offNamedUntil(AppRoutes.auth, (route) => false);
        }
      }
      update();
    } catch (error) {
      log('error in sign out --> $error');
    }
  }

  @override
  void dispose() {
    // clear controllers when close auth controller
    name.clear();
    email.clear();
    password.clear();
    phone.clear();
    super.dispose();
  }
}
