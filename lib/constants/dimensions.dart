import '../index.dart';

class Dimensions {
  /// Dimensions => الابعاد او المسافة
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
  static Orientation orientation = Get.context!.orientation;

  /// 1. Find screenHeight And screenWidth by MediaQuery
  /// 2. لما نحسب الطول و العرض الخاص بالشاشة نبدا نحسب الابعاد ال انا محتاجها مثال
  /// 3. لو عاوز طول معين نبدا نحسب من خلال طول الشاشة كلها علي الطول اللي انا محتاجه وكذلك العرض

}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = Dimensions.screenHeight;
  // 810 is the layout height that designer use
  return (inputHeight / 810.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = Dimensions.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}
