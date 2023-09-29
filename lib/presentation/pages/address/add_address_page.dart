import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
      builder: (controller) {
        (() {
          controller.address.text = controller.placemark.name ?? '';
          controller.name.text = AuthController.to.userModel?.name ?? '';
          controller.phone.text = AuthController.to.userModel?.phone ?? '';
          if (controller.addressList.isNotEmpty) {
            controller.address.text = controller.getUserAddress().address ?? '';
          }
        }());
        return Scaffold(
          body: Column(
            children: [
              const AppBarWidget(title: 'Add Address'),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: getProportionateScreenHeight(130),
                        width: Dimensions.screenWidth,
                        margin: AppConstants.paddingSTE / 2,
                        decoration: BoxDecoration(
                          color: AppColors.transparent,
                          border: Border.all(
                              width: 2, color: AppColors.primaryColor),
                          borderRadius: AppConstants.borderRadius / 2,
                        ),
                        child: controller.cameraPosition == null
                            ? const ShimmerCardGoogleMap()
                            : ClipRRect(
                                borderRadius: AppConstants.borderRadius / 2,
                                child: GoogleMap(
                                  initialCameraPosition:
                                      controller.cameraPosition!,
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  indoorViewEnabled: true,
                                  mapToolbarEnabled: false,
                                  markers: Set<Marker>.of(controller.markers),
                                  onTap: (LatLng latLng) {
                                    Get.toNamed(
                                      AppRoutes.pickAddress,
                                      arguments: PickAddressPage(
                                        signUp: false,
                                         isMoved: true,
                                        googleMapController:
                                            controller.googleMapController,
                                      ),
                                    );
                                  },
                                  onCameraIdle: () =>
                                      controller.updateCameraPosition(
                                          controller.cameraPosition!, true),
                                  onCameraMove: (postion) =>
                                      controller.setCameraPosition(postion),
                                  onMapCreated: (googleMapController) =>
                                      controller.setMapController(
                                          googleMapController),
                                ),
                              ),
                      ),
                      Padding(
                        padding: AppConstants.paddingSTEB,
                        child: Column(
                          children: [
                            SizedBox(
                              height: getProportionateScreenHeight(45),
                              width: Dimensions.screenWidth,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Tooltip(
                                    message: controller.addressTypeList[index],
                                    child: GestureDetector(
                                      onTap: () =>
                                          controller.setAddressTypeIndex(index),
                                      child: Container(
                                        height:
                                            getProportionateScreenHeight(45),
                                        width: getProportionateScreenHeight(45),
                                        decoration: BoxDecoration(
                                          color: controller.addressTypeIndex ==
                                                  index
                                              ? AppColors.primaryColor
                                              : AppColors.white,
                                          borderRadius:
                                              AppConstants.borderRadius / 2,
                                          boxShadow:
                                              controller.addressTypeIndex !=
                                                      index
                                                  ? AppConstants.boxShadow
                                                  : null,
                                        ),
                                        child: Icon(
                                          controller.icons[index],
                                          color: controller.addressTypeIndex ==
                                                  index
                                              ? AppColors.white
                                              : AppColors.primaryColor,
                                          size:
                                              getProportionateScreenHeight(20),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: controller.addressTypeList.length,
                                separatorBuilder: (context, index) =>
                                    AppConstants.kWidthBox10,
                              ),
                            ),
                            AppConstants.kHeightBox20,
                            TextInputWidget(
                              title: 'Dlivery address',
                              controller: controller.address,
                              prefixIcon: CupertinoIcons.location_solid,
                            ),
                            AppConstants.kHeightBox20,
                            TextInputWidget(
                              title: 'User name',
                              type: TextInputType.name,
                              controller: controller.name,
                              prefixIcon: CupertinoIcons.person_alt,
                            ),
                            AppConstants.kHeightBox20,
                            TextInputWidget(
                              title: 'Phone number',
                              type: TextInputType.phone,
                              controller: controller.phone,
                              prefixIcon: CupertinoIcons.phone_solid,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Padding(
            padding: AppConstants.paddingSTEB,
            child: BtnWidget(
              title: 'Save address',
              isLoading: controller.isAddAddressLoading,
              backgroundColor: controller.isLoading
                  ? AppColors.black.withOpacity(0.2)
                  : AppColors.primaryColor,
              onPressed: () => controller.onTappedAddAddress(),
            ),
          ),
        );
      },
    );
  }
}
