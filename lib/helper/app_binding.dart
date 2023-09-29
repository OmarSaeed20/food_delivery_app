import '../index.dart';

class AppBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    // prefs
    Get.put<DatabaseHelper>(DatabaseHelper());
    await Get.putAsync<DatabaseHelper>(() => DatabaseHelper.to.init());

    // api client
    Get.lazyPut(() => ApiClient(url: EndPoints.App_Url), fenix: true);

    // repository
    Get.lazyPut(() => PopularProductsRepo(), fenix: true);
    Get.lazyPut(() => RecommendedProductsRepo(), fenix: true);
    Get.lazyPut(() => CartRepo(), fenix: true);
    Get.lazyPut(() => AuthRepo(), fenix: true);
    Get.lazyPut(() => LocationRepo(), fenix: true);

    // controllers
    Get.lazyPut(() => MainController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => PopularProductsController(), fenix: true);
    Get.lazyPut(() => RecommendedProductsController(), fenix: true);
    Get.lazyPut(() => CartController(), fenix: true);
    Get.lazyPut(() => LocationController(), fenix: true);
  }
}
