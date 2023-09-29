import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: AppConstants.paddingSE,
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconBtnWidget(
                        onPressed: () => Get.back(),
                        icon: CupertinoIcons.back,
                        backgroundColor: AppColors.primaryColor,
                        color: AppColors.white,
                      ),
                      const Spacer(),
                      IconBtnWidget(
                        onPressed: () => Get.toNamed(AppRoutes.main),
                        icon: CupertinoIcons.home,
                        backgroundColor: AppColors.primaryColor,
                        color: AppColors.white,
                      ),
                      AppConstants.kWidthBox20,
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          IconBtnWidget(
                            onPressed: () => null,
                            icon: CupertinoIcons.shopping_cart,
                            backgroundColor: AppColors.primaryColor,
                            color: AppColors.white,
                          ),
                          CircleAvatar(
                            radius: getProportionateScreenHeight(10),
                            backgroundColor: AppColors.white,
                            child: TextWidget(
                              text: '${controller.totalQuantity}',
                              fontSize: getProportionateScreenWidth(12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                controller.getItemsFromCart.isEmpty
                    ? Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: 'No products yet !',
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: getProportionateScreenWidth(16),
                            ),
                            const SizedBox(height: 2),
                            TextWidget(
                              text:
                                  'Be the first to add products in your cart.',
                              color: AppColors.grey,
                              fontSize: getProportionateScreenWidth(14),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: controller.getItemsFromCart.length,
                          padding: AppConstants.paddingTB,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) =>
                              AppConstants.kHeightBox20,
                          itemBuilder: (context, index) =>
                              CartItem(controller: controller, index: index),
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: getProportionateScreenHeight(90),
            padding: AppConstants.paddingSE,
            decoration: BoxDecoration(
              color: AppColors.offWhite,
              borderRadius: AppConstants.borderRadiusTLTR,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const TextWidget(
                        text: 'PRICE',
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      TextWidget(
                        text: '\$ ${controller.getTotalAmount}',
                        color: AppColors.primaryColor,
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: BtnWidget(
                    title: 'Check out',
                    onPressed: () => controller.onTappedCheckout(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.controller,
    required this.index,
  });
  final CartController controller;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller
          .getFoodDetailsPage(controller.getItemsFromCart[index].product!),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: AppConstants.boxShadow,
          borderRadius: AppConstants.borderRadius * 1.5,
        ),
        height: getProportionateScreenHeight(110),
        width: Dimensions.screenWidth,
        child: Row(
          children: [
            Container(
              height: getProportionateScreenHeight(110),
              width: getProportionateScreenHeight(110),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      '${EndPoints.Uploads_Uri}${controller.getItemsFromCart[index].image}'),
                ),
              ),
            ),
            AppConstants.kWidthBox10,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${controller.getItemsFromCart[index].name}',
                    color: AppColors.grey,
                    fontSize: getProportionateScreenWidth(18),
                  ),
                  TextWidget(
                    text: 'Spicy',
                    color: AppColors.grey,
                    fontSize: getProportionateScreenWidth(14),
                  ),
                  Row(
                    children: [
                      TextWidget(
                        text: '\$ ${controller.getItemsFromCart[index].price}',
                        color: AppColors.iconColor2,
                        fontSize: getProportionateScreenWidth(18),
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      BtnMiunsAndPlusWidget(
                        title: '${controller.getItemsFromCart[index].quantity}',
                        miunsTapped: () => controller.addItemToCartList(
                          product: controller.getItemsFromCart[index].product!,
                          quantity: -1,
                        ),
                        plusTapped: () => controller.addItemToCartList(
                          product: controller.getItemsFromCart[index].product!,
                          quantity: 1,
                        ),
                      ),
                      AppConstants.kWidthBox10,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
