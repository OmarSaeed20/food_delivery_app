import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: AppConstants.paddingSTEB,
            child: Column(
              children: [
                SmallUserCard(
                  name: controller.userLoggedIn()
                      ? controller.userModel?.name ?? 'Loading ...'
                      : 'Sign Up',
                  image: '',
                ),
                AppConstants.kHeightBox20,
                SettingsItemWidget(
                  icon: CupertinoIcons.person_alt,
                  backgroundColor: const Color(0xFF6E5DCF),
                  title: 'Modify',
                  subtitle: 'Tap to change your data',
                  onTap: () {},
                ),
                SettingsItemWidget(
                  icon: CupertinoIcons.location_solid,
                  backgroundColor: AppColors.iconColor2,
                  title: 'Location',
                  subtitle: 'Tap to find your address',
                  onTap: () => Get.toNamed(AppRoutes.address),
                ),
                SettingsItemWidget(
                  icon: CupertinoIcons.bell_fill,
                  backgroundColor: AppColors.iconColor1,
                  title: 'Notifications',
                  subtitle: 'Tap to show all your notifications',
                  onTap: () {},
                ),
                SettingsItemWidget(
                  icon: CupertinoIcons.exclamationmark_circle_fill,
                  backgroundColor: AppColors.primaryColor,
                  title: 'About',
                  subtitle: 'Learn more about (Food Delivery) app',
                  onTap: () {},
                ),
                SettingsItemWidget(
                  backgroundColor: const Color(0xFFF44336),
                  icon: CupertinoIcons.power,
                  title: 'Sign Out',
                  trailing: const SizedBox.shrink(),
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
