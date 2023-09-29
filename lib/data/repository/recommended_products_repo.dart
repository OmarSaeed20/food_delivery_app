import '../../index.dart';

class RecommendedProductsRepo {
  static RecommendedProductsRepo get to => Get.find();

  Future<Response> getProductsData() async {
    return await ApiClient.to.getData(url: EndPoints.Recommended_Products_Uri);
  }
}
