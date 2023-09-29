import 'dart:async';
import 'dart:developer';

import '../index.dart';

class RecommendedProductsController extends GetxController {
  static RecommendedProductsController get to => Get.find();
  @override
  onInit() {
    super.onInit();
    getProductsToList();
  }

  List<Data> _products = [];
  List<Data> get products => _products;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getProductsToList() async {
    _isLoading = true;
    update();
    Response response = await RecommendedProductsRepo.to.getProductsData();
    if (response.statusCode == 200) {
      _products = <Data>[];
      Timer(
        1.seconds,
        () {
          _products.addAll(ProductModel.fromJson(response.body).data!);
          _isLoading = false;
          update();
        },
      );
    } else {
      log('there error in get recommended products ${response.statusText}');
    }
  }
}
