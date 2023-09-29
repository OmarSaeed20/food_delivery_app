import '../../../index.dart';

class SliderBody extends StatefulWidget {
  const SliderBody({Key? key}) : super(key: key);

  @override
  State<SliderBody> createState() => _SliderBodyState();
}

class _SliderBodyState extends State<SliderBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  double currentIndex = 0.0;
  /*
   controller => عبارة عن وحدة تحكم للصفحة لكي نقدر ع الاتصال بها
   viewportFraction =>  فقط وليس المحتوي الذي بها pageViewلكن من يسار ويمين ال padding تشبه ال
   currentPageValue => لمعرفة قيمة الصفحة الحالية
   الي التالي ثم التالي zero الخاص بها يبدا من index الصفحة الاولي ال
  */
  @override
  void initState() {
    /*
     addListener => controller تساعدنا في الحصول ع القيمة الاحدث(يسارا و يمينا) للصفحة الحالية بواسطة وحدة التحكم للصفحة
    */
    pageController.addListener(() {
      /*
       setState => لتحديث القيمة عند حدوث تغيير فورا
      */
      setState(() => currentIndex = pageController.page!);
    });
    super.initState();
  }
  /*
  @override
  void dispose() {
    /*
     dispose => تساعدنا عندما نغادر الشاشة من التخلص من القيم المحفوظة تلقائيا
    */
    pageController.dispose();
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductsController>(
      builder: (controller) {
        if (controller.isLoading) {
          return SizedBox(
            height: getProportionateScreenHeight(280),
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) =>
                  ShimmerSlider(index: index, currentIndex: currentIndex),
              itemCount: 6,
            ),
          );
        } else {
          return Stack(
            clipBehavior: Clip.none,
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              // slider section
              SizedBox(
                height: getProportionateScreenHeight(280),
                // position => الموضع او المكانة
                child: PageView.builder(
                  controller: pageController,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                          AppPages.getPopularFood(controller.products[index])),
                      child: ItemSliderWidget(
                        index: index,
                        currentIndex: currentIndex,
                        product: controller.products[index],
                      ),
                    );
                  },
                  itemCount: controller.products.length,
                ),
              ),
              // dots indicator
              Positioned(
                bottom: getProportionateScreenHeight(5),
                right: 0,
                left: 0,
                child: DotsIndicator(controller, currentIndex),
              ),
            ],
          );
        }
      },
    );
  }
}

class DotsIndicator extends StatelessWidget {
  const DotsIndicator(
    this.controller,
    this.currentIndex, {
    super.key,
  });
  final PopularProductsController controller;
  final double currentIndex;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.products.length,
          (i) {
            return Container(
              height: getProportionateScreenHeight(5),
              width: i == currentIndex.toInt()
                  ? getProportionateScreenHeight(15)
                  : getProportionateScreenHeight(10),
              margin: AppConstants.paddingSE / 6,
              decoration: BoxDecoration(
                borderRadius: AppConstants.borderRadius,
                color: i == currentIndex.toInt()
                    ? AppColors.iconColor2
                    : AppColors.grey.withOpacity(0.2),
              ),
            );
          },
        ),
      );
}
