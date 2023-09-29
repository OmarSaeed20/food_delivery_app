import '../../../../index.dart';

/* 
  All Shimmer
*/
// shimmer slider
class ShimmerSlider extends StatelessWidget {
  const ShimmerSlider({
    Key? key,
    required this.index,
    required this.currentIndex,
  }) : super(key: key);
  final int index;
  final double currentIndex;
  final double scaleFactor = 0.8;
  // scaleFactor --> الجانب اليمين و الجانب اليسار  الذين سوف يظهروا بجانب الصفحة التي انا موجود فيها وانا محدد 0.8 من الصفحة السابقة وبالمثل من الصفحة التالية scaleFactor اقصد بال

  @override
  Widget build(BuildContext context) {
    return TransFormWidget(
      index: index,
      currentIndex: currentIndex,
      scaleFactor: scaleFactor,
      child: Stack(
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.baseColor,
            highlightColor: AppColors.highlightColor,
            child: Container(
              height: getProportionateScreenHeight(205),
              margin: AppConstants.paddingSE / 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: AppConstants.borderRadius,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Shimmer.fromColors(
              baseColor: AppColors.baseColor,
              highlightColor: AppColors.highlightColor,
              child: Container(
                height: getProportionateScreenHeight(100),
                width: Dimensions.screenWidth,
                margin: EdgeInsetsDirectional.fromSTEB(
                  getProportionateScreenWidth(20),
                  getProportionateScreenHeight(0),
                  getProportionateScreenWidth(20),
                  getProportionateScreenHeight(30),
                ),
                padding: EdgeInsetsDirectional.fromSTEB(
                  getProportionateScreenWidth(15),
                  getProportionateScreenHeight(10),
                  getProportionateScreenWidth(15),
                  getProportionateScreenHeight(10),
                ),
                decoration: BoxDecoration(
                  borderRadius: AppConstants.borderRadius,
                  color: AppColors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// shimmer list view
class ShimmerProductList extends StatelessWidget {
  const ShimmerProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: AppConstants.paddingSE,
            child: Row(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseColor,
                  highlightColor: AppColors.highlightColor,
                  child: Container(
                    height: getProportionateScreenHeight(120),
                    width: getProportionateScreenHeight(120),
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: AppConstants.borderRadius,
                    ),
                  ),
                ),
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: AppColors.baseColor,
                    highlightColor: AppColors.highlightColor,
                    child: Container(
                      height: getProportionateScreenHeight(100),
                      margin: const EdgeInsetsDirectional.all(0),
                      padding: AppConstants.paddingSE / 2,
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.only(
                          topRight:
                              Radius.circular(getProportionateScreenHeight(10)),
                          bottomRight:
                              Radius.circular(getProportionateScreenHeight(10)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => AppConstants.kHeightBox20,
      ),
    );
  }
}

class ShimmerCardGoogleMap extends StatelessWidget {
  const ShimmerCardGoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Container(
        height: getProportionateScreenHeight(130),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: AppConstants.borderRadius / 2,
        ),
      ),
    );
  }
}

class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.baseColor,
      highlightColor: AppColors.highlightColor,
      child: Container(
        height: getProportionateScreenHeight(15),
        width: Dimensions.screenWidth / 2,
        color: Colors.grey,
      ),
    );
  }
}
