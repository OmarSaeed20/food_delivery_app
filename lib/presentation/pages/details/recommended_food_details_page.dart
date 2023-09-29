import 'package:flutter/cupertino.dart';
import '../../../index.dart';

class RecommendedFoodDetailsPage extends StatelessWidget {
  const RecommendedFoodDetailsPage({
    Key? key,
    required this.product,
    required this.page,
  }) : super(key: key);
  final Data product;
  final String page;
  @override
  Widget build(BuildContext context) {
    // Data product = RecommendedProductsController.to.products[index];
    CartController.to.initProductData(product: product);
    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: getProportionateScreenHeight(60),
                title: Row(
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
                        )
                      ],
                    ),
                  ],
                ),
                pinned: true,
                expandedHeight: getProportionateScreenHeight(270),
                bottom: PreferredSize(
                  preferredSize:
                      Size.fromHeight(getProportionateScreenHeight(20)),
                  child: Container(
                    width: Dimensions.screenWidth,
                    padding: AppConstants.paddingTB / 2,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: AppConstants.borderRadiusTLTR,
                    ),
                    child: Center(
                      child: TextWidget(
                        text: '${product.name}',
                        fontSize: getProportionateScreenWidth(20),
                      ),
                    ),
                  ),
                ),
                backgroundColor: const Color(0xFFffd379).withOpacity(0.75),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image(
                    image: NetworkImage(
                        '${EndPoints.Uploads_Uri}${product.image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppConstants.paddingSTEB,
                  child: ExpandableTextWidget(text: '${product.desc}'),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: AppConstants.paddingSE / 2,
                child: BtnMiunsAndPlusWidget(
                  title: '\$ ${product.price}.00  X  ${controller.inCartItems}',
                  fontSize: getProportionateScreenWidth(20),
                  iconColor: AppColors.white,
                  backgroundColor: AppColors.primaryColor,
                  plusTapped: () => controller.setQuantity(isIncrement: true),
                  miunsTapped: () => controller.setQuantity(isIncrement: false),
                ),
              ),
              AppConstants.kHeightBox10,
              CardBottomBodyWidget(
                isFav: true,
                price: int.parse('${product.price}'),
                onPressed: () => controller.addItemToCartList(
                  product: product,
                  quantity: controller.quantity,
                ),
                onPressedIcon: () {},
              ),
            ],
          ),
        );
      },
    );
  }
}
