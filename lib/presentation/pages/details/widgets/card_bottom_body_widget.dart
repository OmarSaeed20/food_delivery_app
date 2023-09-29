import 'package:flutter/cupertino.dart';
import '../../../../index.dart';

class CardBottomBodyWidget extends StatelessWidget {
  const CardBottomBodyWidget({
    Key? key,
    this.isFav = false,
    required this.price,
    this.controller,
    required this.onPressed,
    this.onPressedIcon,
  }) : super(key: key);
  final bool isFav;
  final int price;
  final Function onPressed;
  final CartController? controller;
  final Function? onPressedIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(100),
      padding: AppConstants.paddingSE,
      decoration: BoxDecoration(
        color: AppColors.offWhite,
        borderRadius: AppConstants.borderRadiusTLTR,
      ),
      child: Row(
        children: [
          if (!isFav)
            Expanded(
              flex: 3,
              child: BtnMiunsAndPlusWidget(
                title: '${controller!.inCartItems}',
                miunsTapped: () => controller!.setQuantity(isIncrement: false),
                plusTapped: () => controller!.setQuantity(isIncrement: true),
              ),
            ),
          if (isFav)
            Expanded(
              child: IconBtnWidget(
                radius: getProportionateScreenHeight(10),
                color: AppColors.primaryColor,
                onPressed: onPressedIcon as Function(),
                icon: CupertinoIcons.heart,
                backgroundColor: AppColors.white,
                size: getProportionateScreenHeight(24),
              ),
            ),
          AppConstants.kWidthBox20,
          Expanded(
            flex: 4,
            child: BtnWidget(
              title: '\$ $price | Add to cart',
              onPressed: onPressed as Function(),
              radius: 6,
            ),
          ),
        ],
      ),
    );
  }
}
