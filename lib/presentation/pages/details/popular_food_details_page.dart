import 'package:flutter/cupertino.dart';

import '../../../index.dart';

class PopularFoodDetailsPage extends StatelessWidget {
  const PopularFoodDetailsPage({
    Key? key,
    required this.product,
    required this.page,
  }) : super(key: key);
  final Data product;
  final String page;

  @override
  Widget build(BuildContext context) {
    // Data product = PopularProductsController.to.products[index];
    CartController.to.initProductData(product: product);
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                left: 0.0,
                top: 0.0,
                right: 0.0,
                child: Container(
                  height: getProportionateScreenHeight(300),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          '${EndPoints.Uploads_Uri}${product.image}'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: getProportionateScreenWidth(20),
                top: getProportionateScreenHeight(35),
                right: getProportionateScreenWidth(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconBtnWidget(
                      onPressed: () => page == 'cart_page'
                          ? Get.toNamed(AppRoutes.cart)
                          : Get.back(),
                      icon: CupertinoIcons.back,
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        IconBtnWidget(
                          onPressed: () => Get.toNamed(AppRoutes.cart),
                          icon: CupertinoIcons.shopping_cart,
                        ),
                        CircleAvatar(
                          radius: getProportionateScreenHeight(10),
                          backgroundColor: AppColors.primaryColor,
                          child: TextWidget(
                            text: '${controller.totalQuantity}',
                            fontSize: getProportionateScreenWidth(12),
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                top: getProportionateScreenHeight(300) -
                    getProportionateScreenHeight(20),
                child: Container(
                  padding: AppConstants.paddingSTEB,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppConstants.borderRadiusTLTR,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: '${product.name}',
                        fontSize: getProportionateScreenWidth(20),
                      ),
                      AppConstants.kHeightBox5,
                      RatingAndValWidget(product: product),
                      AppConstants.kHeightBox10,
                      RowIconAndTitleWidget(
                        dimensions: '${product.location}',
                        time: product.updatedTime!.isEmpty
                            ? DateConverter.timeCalculation(
                                product.createdTime!,
                              )
                            : DateConverter.timeCalculation(
                                product.updatedTime!,
                              ),
                      ),
                      AppConstants.kHeightBox20,
                      TextWidget(
                        text: 'Description',
                        fontSize: getProportionateScreenWidth(18),
                      ),
                      AppConstants.kHeightBox10,
                      Expanded(
                          child: ExpandableTextWidget(text: '${product.desc}')),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: CardBottomBodyWidget(
            price: product.price!,
            controller: controller,
            onPressed: () => controller.addItemToCartList(
              product: product,
              quantity: controller.quantity,
            ),
          ),
        );
      },
    );
  }
}
