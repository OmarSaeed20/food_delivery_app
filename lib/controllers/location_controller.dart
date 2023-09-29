import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import '../index.dart';

class LocationController extends GetxController {
  static LocationController get to => Get.find();
  AuthController authController = AuthController.to;

  @override
  void onInit() {
    super.onInit();
    if (authController.userLoggedIn() && authController.userModel == null) {
      authController.getUserData();
    }

    if (_addressList.isNotEmpty) {
      _address.text = getUserAddress().address!;
      _cameraPosition = CameraPosition(
        target: LatLng(
          double.parse(_getAddress!['latitude']),
          double.parse(_getAddress!['longitude']),
        ),
      );

      _initialPosition = LatLng(
        double.parse(_getAddress!['latitude']),
        double.parse(_getAddress!['longitude']),
      );
    } else {
      getCurrentLocation();
    }
  }

  final TextEditingController _address = TextEditingController();
  TextEditingController get address => _address;
  final TextEditingController _name = TextEditingController();
  TextEditingController get name => _name;
  final TextEditingController _phone = TextEditingController();
  TextEditingController get phone => _phone;
  CameraPosition? _cameraPosition;
  CameraPosition? get cameraPosition => _cameraPosition;
  final List<Marker> _markers = <Marker>[];
  List<Marker> get markers => _markers;
  final List<Marker> _pickMarkers = <Marker>[];
  List<Marker> get pickMarkers => _pickMarkers;

  LatLng? _initialPosition;
  LatLng? get initialPosition => _initialPosition;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isAddAddressLoading = false;
  bool get isAddAddressLoading => _isAddAddressLoading;

  Position? _position;
  Position? _pickPosition;
  Position? get position => _position;
  Position? get pickPosition => _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> _allAddressList = [];
  List<AddressModel> get allAddressList => _allAddressList;
  List<String> addressTypeList = ['Home', 'Office', 'Others'];
  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.bag_fill,
    CupertinoIcons.location_solid,
  ];
  int _addressTypeIndex = 0;
  int get addressTypeIndex => _addressTypeIndex;
  Map<String, dynamic>? _getAddress;
  Map<String, dynamic>? get getAddress => _getAddress;

  GoogleMapController? _googleMapController;
  GoogleMapController? get googleMapController => _googleMapController;
  bool _updateLocationData = true;
  final bool _changeLocationData = true;
  ResponseModel? _response;
  // Markers
  Marker _setMarker(LatLng latLng) => Marker(
        markerId: const MarkerId('1'),
        position: latLng,
        infoWindow: const InfoWindow(title: 'Current Location'),
      );
  /*
    for service zone
  */
  final bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  /*
  whether the user is in service zone or not
  */
  bool _isZone = false;
  bool get isZone => _isZone;

  /*
  showing and hiding btn as the map loads
  */
  bool _isBtnDisabled = true;
  bool get isBtnDisabled => _isBtnDisabled;

  Future<void> getCurrentLocation() async {
    await isLocationServiceEnabled().then(
      (position) {
        _initialPosition = LatLng(position.latitude, position.longitude);

        _cameraPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 16.0,
        );
        _markers.add(_setMarker(_initialPosition!));
        googleMapController?.showMarkerInfoWindow(const MarkerId('1'));
      },
    );
    update();
  }

  Future<Position> isLocationServiceEnabled() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (isServiceEnabled) {
      await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  /*
  set setCameraPosition(CameraPosition position) => _cameraPosition = position;
  */
  void setCameraPosition(CameraPosition position) {
    _cameraPosition = position;
    update();
  }

  void setMapController(GoogleMapController googleMapController) {
    _googleMapController = googleMapController;
    update();
  }

  Future<void> updateCameraPosition(
      CameraPosition position, bool fromLocation) async {
    if (_updateLocationData) {
      _isLoading = true;
      update();
      try {
        if (fromLocation) {
          _position = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 1.0,
            heading: 1.0,
            speed: 1.0,
            speedAccuracy: 1.0,
          );
          _markers.add(
            _setMarker(
                LatLng(position.target.latitude, position.target.longitude)),
          );
          googleMapController!.showMarkerInfoWindow(const MarkerId('1'));
        } else {
          _pickPosition = Position(
            longitude: position.target.longitude,
            latitude: position.target.latitude,
            timestamp: DateTime.now(),
            accuracy: 1.0,
            altitude: 1.0,
            heading: 1.0,
            speed: 1.0,
            speedAccuracy: 1.0,
          );
        }

        // ResponseModel response = await getZone(
        //   '${position.target.latitude}',
        //   '${position.target.longitude}',
        //   false,
        // );
        // /*
        //   if btn value is false we are in the service area
        // */
        // _isBtnDisabled = !response.isSuccess;
        if (_changeLocationData) {
          String address = await getAddressFromGeocoding(
            LatLng(position.target.latitude, position.target.longitude),
          );
          fromLocation
              ? _placemark = Placemark(name: address)
              : _pickPlacemark = Placemark(name: address);
        }
        _isLoading = false;
        update();
      } catch (error) {
        log('error in update camera position ---> $error');
      }
    } else {
      _updateLocationData = true;
      update();
    }
  }

  Future<String> getAddressFromGeocoding(LatLng latLng) async {
    String address = '';
    Response response = await LocationRepo.to.getAddressFromGeocoding(latLng);
    if (response.statusText == 'OK') {
      address =
          '${response.body['results'][0]['address_components'][1]['long_name']}, '
          '${response.body['results'][0]['address_components'][2]['long_name']}, '
          '${response.body['results'][0]['address_components'][3]['long_name']}';

      log('address from geocoding api ---> $address');
      update();
    } else {
      log('error in get address from geocoding api ---> ${response.statusText}');
    }
    return address;
  }

  AddressModel getUserAddress() {
    AddressModel? addressModel;
    /*
    converting to map using jsonDecode()
    */
    _getAddress = jsonDecode(LocationRepo.to.getUserAddressFromLocalStorage());
    try {
      addressModel = AddressModel.fromJson(_getAddress!);
    } catch (error) {
      log('error in get user address ---> $error');
    }
    return addressModel!;
  }

  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addUserAddress() async {
    try {
      _isAddAddressLoading = true;
      update();
      AddressModel addressModel = AddressModel();
      addressModel
        ..addressType = addressTypeList[addressTypeIndex]
        ..contactPersonName = _name.text.trim()
        ..contactPersonNumber = _phone.text.trim()
        ..address = address.text.trim()
        ..latitude = '${position!.latitude}'
        ..longitude = '${position!.longitude}';
      Response response = await LocationRepo.to.addUserAddress(addressModel);
      if (response.statusCode == 200) {
        await getUserAddressList();
        _response = ResponseModel(true, response.body['message']);
        await saveUserAddressInLocalStorage(addressModel);
      } else {
        _response = ResponseModel(false, '${response.statusText}');
      }
      _isAddAddressLoading = false;
      update();
    } catch (error) {
      log('error in add user address ---> $error');
    }
    return _response!;
  }

  void onTappedAddAddress() async {
    ResponseModel response = await addUserAddress();
    if (response.isSuccess) {
      Get.toNamed(AppRoutes.main);
    } else {
      snackBarWidget(title: 'Error', msg: response.message);
    }
  }

  Future<void> getUserAddressList() async {
    try {
      Response response = await LocationRepo.to.getUserAddressList();
      if (response.statusCode == 200) {
        _addressList = <AddressModel>[];
        _allAddressList = <AddressModel>[];
        for (var address in response.body) {
          _addressList.add(AddressModel.fromJson(address));
          _allAddressList.add(AddressModel.fromJson(address));
        }
        _response = ResponseModel(true, 'successfully');
      } else {
        _addressList = <AddressModel>[];
        _allAddressList = <AddressModel>[];
        _response = ResponseModel(false, '${response.statusText}');
      }
      update();
    } catch (error) {
      log('error in get user address list ---> $error');
    }
  }

  Future<bool> saveUserAddressInLocalStorage(AddressModel addressModel) async {
    bool? val;
    try {
      String address = jsonEncode(addressModel.toJson());
      val = await LocationRepo.to.saveUserAddressInLocalStorage(address);
    } catch (error) {
      log('error in save user address in local db ---> $error');
    }
    return val!;
  }

  String getUserAddressFromLocalStorage() {
    return LocationRepo.to.getUserAddressFromLocalStorage();
  }

  void clearAddressList() {
    _addressList = [];
    _allAddressList = [];
    update();
  }

  void setPickAddress() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateLocationData = false;
    update();
  }

  Future<ResponseModel> getZone(
      String lat, String lng, bool isMarkerLoaded) async {
    try {
      if (isMarkerLoaded) {
        _isLoading = true;
        update();
      }
      Response response = await LocationRepo.to.getZone(lat, lng);
      if (response.statusCode == 200) {
        _isZone = true;
        _response = ResponseModel(true, response.body['zone_id']);
      } else {
        _isZone = false;
        _response = ResponseModel(false, '${response.statusText}');
      }
      if (isMarkerLoaded == false) {
        _isLoading = false;
      }
      update();
    } catch (error) {
      log('error in get zone ---> $error');
    }
    return _response!;
  }
}
