import '../../index.dart';

class LocationRepo {
  static LocationRepo get to => Get.find();
  Future<Response> getAddressFromGeocoding(LatLng latLng) {
    return ApiClient.to.getData(
      url: '${EndPoints.Geocoding_Uri}'
          '?lat=${latLng.latitude}&lng=${latLng.longitude}',
    );
  }

  Future<Response> addUserAddress(AddressModel addressModel) async {
    return await ApiClient.to.postData(
      url: EndPoints.Add_Address_Uri,
      body: addressModel.toJson(),
    );
  }

  Future<Response> getUserAddressList() async {
    return await ApiClient.to.getData(url: EndPoints.Address_List_Uri);
  }

  Future<bool> saveUserAddressInLocalStorage(String address) async {
    ApiClient.to
        .updateHeader(DatabaseHelper.to.getString(EndPoints.User_Token));
    return await DatabaseHelper.to.setString(EndPoints.User_Address, address);
  }

  String getUserAddressFromLocalStorage() {
    return DatabaseHelper.to.getString(EndPoints.User_Address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await ApiClient.to
        .getData(url: '${EndPoints.Zone_Uri}?lat=$lat&lng=$lng');
  }
}
