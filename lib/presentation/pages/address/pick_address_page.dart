import '../../../index.dart';

class PickAddressPage extends StatefulWidget {
  const PickAddressPage({
    super.key,
    required this.signUp,
    required this.isMoved,
    required this.googleMapController,
  });
  final bool signUp;
  final bool isMoved;
  final GoogleMapController? googleMapController;

  @override
  State<PickAddressPage> createState() => _PickAddressPageState();
}

class _PickAddressPageState extends State<PickAddressPage> {
  late LatLng _latLng;

  late GoogleMapController _mapController;

  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    _latLng = LocationController.to.initialPosition!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LocationController>(
        builder: (controller) {
          return SizedBox(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target: _latLng,
                    zoom: 16.0,
                  ),
                  markers: Set<Marker>.of(controller.pickMarkers),
                  onCameraMove: (position) => _cameraPosition = position,
                  onCameraIdle: () =>
                      controller.updateCameraPosition(_cameraPosition, false),
                      
                ),
                Positioned(
                  bottom: getProportionateScreenHeight(50),
                  right: getProportionateScreenWidth(15),
                  left: getProportionateScreenWidth(15),
                  child: BtnWidget(
                    title: controller.isZone
                        ? widget.isMoved
                            ? 'Pick Address'
                            : 'Pick Location'
                        : 'Service is not avaiable in your area',
                    backgroundColor:
                        controller.isLoading || controller.isBtnDisabled
                            ? AppColors.black.withOpacity(0.4)
                            : AppColors.primaryColor,
                    onPressed: () {
                      if (controller.pickPosition?.latitude != 0 &&
                          controller.pickPlacemark.name != null) {
                        if (widget.isMoved) {
                          if (widget.googleMapController != null) {
                            widget.googleMapController!.moveCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(
                                    controller.pickPosition!.latitude,
                                    controller.pickPosition!.longitude,
                                  ),
                                  zoom: 16.0,
                                ),
                              ),
                            );
                            controller.setPickAddress();
                          }
                          /*
                          Get.back() create update problem
                          list, a value
                          */
                          Get.toNamed(AppRoutes.address);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
