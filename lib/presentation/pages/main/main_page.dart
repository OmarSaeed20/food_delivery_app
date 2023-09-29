import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: controller.items,
            currentIndex: controller.index,
            onTap: (index) => controller.onTapNav(index),
          ),
          body: Column(
            children: [
              HeaderBar(controller: controller),
              Expanded(child: controller.pages[controller.index]),
            ],
          ),
        );
      },
    );
  }
}

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key, required this.controller});
  final MainController controller;
  @override
  Widget build(BuildContext context) => AppBarWidget(
        isShow: false,
        title: controller.titles[controller.index],
        actions: [
          controller.index != 1
              ? OutlineBtnWidget(
                  title: 'Search',
                  icon: CupertinoIcons.search,
                  onTap: () {},
                )
              : OutlineBtnWidget(
                  title: 'Cart',
                  icon: CupertinoIcons.shopping_cart,
                  onTap: () => Get.toNamed(AppRoutes.cart),
                ),
        ],
      );
}
