import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    Future<void> onRefresh() async {
      try {
        await PopularProductsController.to.getProductsToList();
        await RecommendedProductsController.to.getProductsToList();
        refreshController.refreshCompleted();
      } catch (error) {
        refreshController.refreshFailed();
      }
    }

    Future<void> onLoading() async {
      try {
        await PopularProductsController.to.getProductsToList();
        await RecommendedProductsController.to.getProductsToList();
        refreshController.loadComplete();
      } catch (error) {
        refreshController.loadFailed();
      }
    }

    return SizedBox(
      height: Dimensions.screenHeight,
      width: Dimensions.screenWidth,
      child: SmartRefresher(
        header: const WaterDropHeader(),
        controller: refreshController,
        onRefresh: () async => await onRefresh(),
        onLoading: () async => await onLoading(),
        child: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.paddingTB,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                // slider body
                SliderBody(),

                // recommended text
                RecommendedText(),

                // product list view
                ListViewBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff49DEE8).withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(20, 50), 100, paint1);
    canvas.drawCircle(Offset(120, -10), 100, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
*/

class RecommendedText extends StatelessWidget {
  const RecommendedText({super.key});

  @override
  Widget build(BuildContext context) => GetBuilder<PopularProductsController>(
        builder: (controller) => Padding(
          padding: AppConstants.paddingSTEB,
          child: controller.isLoading
              ? const ShimmerText()
              : const TextWidget(
                  text: 'What are you looking for?',
                  fontWeight: FontWeight.w600,
                ),
        ),
      );
}

class ListViewBody extends StatelessWidget {
  const ListViewBody({super.key});

  @override
  Widget build(BuildContext context) =>
      GetBuilder<RecommendedProductsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const ShimmerProductList();
          } else {
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppPages.getRecommendedFood(
                        controller.products[index])),
                    child: ItemListWidget(
                      product: controller.products[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) => AppConstants.kHeightBox20,
              ),
            );
          }
        },
      );
}
