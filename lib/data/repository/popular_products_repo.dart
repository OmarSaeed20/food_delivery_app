import '../../index.dart';

class PopularProductsRepo {
  static PopularProductsRepo get to => Get.find();

  /// get product data from api
  Future<Response> getProductsData() async {
    return await ApiClient.to.getData(url: EndPoints.Popular_Products_Uri);
  }
}
