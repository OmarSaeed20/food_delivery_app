import '../../../index.dart';

class AddressListPage extends StatelessWidget {
  const AddressListPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocationController.to.getUserAddressList();
    return Scaffold(
      body: GetBuilder<LocationController>(
        builder: (controller) {
          return Column(
            children: [
              const AppBarWidget(title: 'My Address'),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.addressList.length,
                  itemBuilder: (context, index) {
                    return TextWidget(
                        color: AppColors.black,
                        text: controller.addressList[index].address!);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
