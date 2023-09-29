import 'dart:convert';
import '../index.dart';

class AppPages {
  static const String welcome = AppRoutes.welcome;
  /* 
  static getPopularFood(int index , int id) => '$popularFood?index=$index&id=$id'; like url
  index=$index&id=$id => qurey ال بعد علامة ؟ يسمي
  */

  // I do this to easy variables sending process
  static getPopularFood(Data product, {String page = 'home_page'}) =>
      '${AppRoutes.popularFood}?product=${jsonEncode(product)}&page=$page';
  /*
   jsonEncode --> convert [object] to a [json] string.
  */
  static String getRecommendedFood(Data product, {String page = 'home_page'}) =>
      '${AppRoutes.recommendedFood}?product=${jsonEncode(product)}&page=$page';

  static List<GetPage> routes = [
    GetPage(
      name: welcome,
      page: () => const WelcomePage(),
      transition: Transition.fadeIn, 
    ),
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => const MainPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.popularFood,
      page: () {
        /*
         jsonDecode --> Parses the [string] and returns the resulting [json] object.
        */
        Data? product = Data.fromJson(jsonDecode(Get.parameters['product']!));
        String? page = Get.parameters['page'];
        return PopularFoodDetailsPage(product: product, page: page!);
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.recommendedFood,
      page: () {
        Data? product = Data.fromJson(jsonDecode(Get.parameters['product']!));
        String? page = Get.parameters['page'];
        return RecommendedFoodDetailsPage(
          product: product,
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () => const OrdersPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.address,
      page: () => const AddAddressPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.pickAddress,
      page: () {
        PickAddressPage page = Get.arguments;

        return page;
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.addressList,
      page: () => const AddressListPage(),
      transition: Transition.fadeIn,
    ),
  ];
}