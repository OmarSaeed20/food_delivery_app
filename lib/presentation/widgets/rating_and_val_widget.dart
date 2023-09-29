import 'package:flutter/cupertino.dart';
import '../../index.dart';

class RatingAndValWidget extends StatelessWidget {
  const RatingAndValWidget({Key? key, required this.product}) : super(key: key);
  final Data product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBar.builder(
          initialRating: product.stars!.toDouble(),
          itemCount: 5,
          unratedColor: AppColors.grey.withOpacity(0.8),
          direction: Axis.horizontal,
          itemSize: getProportionateScreenHeight(13.0),
          itemPadding: const EdgeInsets.symmetric(horizontal: 2),
          ignoreGestures: true,
          itemBuilder: (context, i) => Icon(
            i < product.stars! ? CupertinoIcons.star_fill : CupertinoIcons.star,
            color: AppColors.primaryColor,
          ),
          onRatingUpdate: (rating) {},
        ),
        AppConstants.kWidthBox10,
        TextWidget(
          text: '${product.stars} rating',
          color: AppColors.grey.withOpacity(0.8),
          fontSize: getProportionateScreenWidth(14),
        ),
      ],
    );
  }
}
