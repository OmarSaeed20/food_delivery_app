import 'package:flutter/cupertino.dart';

import '../../index.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Data product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppConstants.paddingSE,
      child: Row(
        children: [
          // image section
          Container(
            height: getProportionateScreenHeight(120),
            width: getProportionateScreenHeight(120),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: AppConstants.borderRadius,
              image: DecorationImage(
                image: NetworkImage('${EndPoints.Uploads_Uri}${product.image}'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // details section
          Expanded(
            child: CardWidget(
              height: getProportionateScreenHeight(100),
              margin: const EdgeInsetsDirectional.all(0),
              padding: AppConstants.paddingSE / 2,
              radius: BorderRadius.only(
                topRight: Radius.circular(getProportionateScreenHeight(10)),
                bottomRight: Radius.circular(getProportionateScreenHeight(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppConstants.kHeightBox10,
                  TextWidget(
                    text: '${product.name}',
                  ),
                  AppConstants.kHeightBox5,
                  TextWidget(
                    text: '${product.desc}',
                    color: AppColors.grey.withOpacity(0.70),
                  ),
                  IconAndTitleWidget(
                    title: '${product.location}',
                    icon: CupertinoIcons.location_solid,
                    color: AppColors.primaryColor,
                    iconSize: getProportionateScreenHeight(16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
