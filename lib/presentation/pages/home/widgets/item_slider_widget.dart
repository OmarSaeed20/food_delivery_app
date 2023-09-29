import '../../../../index.dart';

class ItemSliderWidget extends StatelessWidget {
  const ItemSliderWidget({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.product,
  }) : super(key: key);
  final int index;
  final double currentIndex;
  final double scaleFactor = 0.8;
  final Data product;

  @override
  Widget build(BuildContext context) {
    return TransFormWidget(
      index: index,
      currentIndex: currentIndex,
      scaleFactor: scaleFactor,
      child: Stack(
        children: [
          // image section
          Container(
            height: getProportionateScreenHeight(205),
            margin: AppConstants.paddingSE / 4,
            decoration: BoxDecoration(
              borderRadius: AppConstants.borderRadius,
              image: DecorationImage(
                image: NetworkImage(
                  "${EndPoints.Uploads_Uri}${product.image}",
                  // url لان الصورة في الباك اند من غير  url انا ضفت ال
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // details section
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: CardWidget(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: '${product.name}',
                    fontSize: getProportionateScreenWidth(18),
                  ),
                  RatingAndValWidget(product: product),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
