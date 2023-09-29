import 'dart:async';
import 'dart:developer';
import '../index.dart';

class PopularProductsController extends GetxController {
  static PopularProductsController get to => Get.find();
  @override
  onInit() {
    super.onInit();
    getProductsToList();
  }

  List<Data> _products = [];
  List<Data> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// _ => class الشرطة السفلية تعني انه متغير خاص لا يمكن استدعائه خارج هذا ال
  /// تجعل متغير من نفس نوعه يشير اليه لنتمكن من استدعائه في اي مكان واي وقت get ف
  Future<void> getProductsToList() async {
    _isLoading = true;
    update();
    Response response = await PopularProductsRepo.to.getProductsData();
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
      log('there error in get popular products ${response.statusText}');
    }
  }
}
