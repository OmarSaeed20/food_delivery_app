import 'dart:convert';
import 'dart:developer';
import '../index.dart';

class CartController extends GetxController {
  static CartController get to => Get.find();
  @override
  void onInit() {
    super.onInit();
    getCartList();
  }

  // int => يشير ع عدد المنتجات الموجودة ف سلة المشتريات
  // CartModel => ال هيتم فيه تخزين البيانات الخاصة بالمنتج المضاف للسلة model ال
  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  // cart local db
  List<String> _cart = [];
  final List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;
  // orders local db
  List<String> _orders = [];
  List<CartModel> _ordersList = [];

  // get cart data from local db and assign in _storageItems and display data in ui
  List<CartModel> _storageItems = [];
  List<CartModel> get stroageItems => _storageItems;

  // product => CartModel لكي اخذ البيانات الخاص بالمنتج المراد اضافته للسلة وتخزينها ف ال
  // quantity => لكي اعرف المستخدم العدد الذي يريد اضافته ف السلة من المنتج المراد
  void addItemToCartList({required Data product, required int quantity}) {
    int totalQuantity = 0;
    if (_items.containsKey(product.productId)) {
      // اذا كان المنتج موجود بالفعل ف السلة لكن المستخدم يريد التعديل عليه
      if (quantity != 0) {
        _items.update(
          product.productId!,
          (value) {
            totalQuantity = value.quantity! + quantity;
            return CartModel(
              productId: value.productId,
              name: value.name,
              price: value.price,
              image: value.image,
              quantity: value.quantity! + quantity,
              isExist: true,
              time: '${DateTime.now()}',
              product: product,
            );
          },
        );
        if (totalQuantity <= 0) {
          _items.remove(product.productId);
        }
      } else {
        snackBarWidget(
            title: 'Error', msg: 'You should at least add an item in the cart');
      }
    } else {
      // putIfAbsent(key, (){}) قبل اضافة المنتج الي سلة المشتريات نريد التحقق هل المنتج المراد اضافته موجود بالفعل ف السلة اما لا وذلك عن طريق
      if (quantity > 0) {
        _items.putIfAbsent(
          product.productId!,
          () {
            return CartModel(
              productId: product.productId,
              name: product.name,
              price: product.price,
              image: product.image,
              quantity: quantity,
              isExist: true,
              time: '${DateTime.now()}',
              product: product,
            );
          },
        );
      } else {
        snackBarWidget(
            title: 'Error', msg: 'You should at least add an item in the cart');
      }
    }
    // save cart data in local db
    addCartListToLocalStorage(getItemsFromCart);
    // call this method to find out product data in cart
    initProductData(product: product);
    update();
  }

  void setQuantity({required bool isIncrement}) {
    if (isIncrement == true) {
      _quantity = isCheckQuantity(_quantity + 1);
    } else {
      _quantity = isCheckQuantity(_quantity - 1);
    }
    update();
  }

  int isCheckQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      snackBarWidget(title: 'Error', msg: 'It can\'t be reduced');
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) >= 20) {
      snackBarWidget(title: 'Error', msg: 'It can\'t be more than that');
      return 20;
    } else {
      return quantity;
    }
  }

  /// _inCartItems + _quantity => لكي يقدر المستخدم ع التعديل _quantity لان المستخدم لما يضيف في السلة 5 منتجات مثلا ويجي يضيف تاني اكون عارف عدد المنتجات ال موجودة في السلة لاني انا هظهر عددهم للمستخدم مكان
  void initProductData({required Data product}) {
    _quantity = 0;
    _inCartItems = 0;

    bool? isExist;
    isExist = isExistInCart(productId: int.parse('${product.productId}'));
    log('Exist In Cart $isExist');
    // Exist => to known this product exist in cart or not
    if (isExist) {
      _inCartItems = getQuantity(product: product);
      log('Product Id = ${product.productId}');
    }
    // if this product Exist in cart _quantity == _inCartItems
    log('Quantity = $_inCartItems');
    // get quantity after added item in cart and store in inCartItems to edit it (- or +)
    /*
    _items.forEach(
      (key, value) {
        log("the name item in Cart = " "  ${value.name}");
        log("the quantity item in Cart = " "  ${value.quantity}");
      },
    );
    */
  }

  bool isExistInCart({required int productId}) {
    // يساوي العدد الموجود ف السلة quantity عاوز لما المستخدم يدخل ع منتج معين وهذا المنتج مضاف ف السلة يكون عدد ال
    if (_items.containsKey(productId)) {
      return true;
    } else {
      return false;
    }
  }

  int getQuantity({required Data product}) {
    // عاوز احسب العدد الموجود ف السلة بالنسبة للمنتج ال المستخدم واقف فيه
    int quantity = 0;
    if (_items.containsKey(product.productId)) {
      _items.forEach((key, value) {
        quantity = value.quantity!;
      });
    }
    return quantity;
  }

  int get totalQuantity {
    // إظهار العدد الكلي الموجود فالسلة للمستخدم
    int totalQuantity = 0;
    _items.forEach(
      (key, value) {
        // += => totalQuantity = totalQuantity + value.quantity!;
        totalQuantity += value.quantity!;
      },
    );
    return totalQuantity;
  }

  // get all items in cart
  List<CartModel> get getItemsFromCart {
    return _items.entries.map((element) => element.value).toList();
  }

  // get total price in cart
  int get getTotalAmount {
    int total = 0;
    _items.forEach((key, value) {
      total += value.price! * value.quantity!;
    });
    /*
    for (var element in getItemsInCart) {
      return total = element.price! * element.quantity!;
    }
    */
    return total;
  }

  // get index product to go to food details page
  void getFoodDetailsPage(Data product) {
    int popularIndex = PopularProductsController.to.products.indexWhere(
      (element) => element.productId == product.productId,
    );
    if (popularIndex >= 0) {
      Get.toNamed(AppPages.getPopularFood(product, page: 'cart_page'));
    } else {
      Get.toNamed(AppPages.getRecommendedFood(product, page: 'cart_page'));
    }
    update();
  }

  // add cart data local db
  void addCartListToLocalStorage(List<CartModel> cartList) {
    try {
      /* 
      remove cart list and orders list because of the time difference
      prefs.remove(EndPoints.Cart_List);
      prefs.remove(EndPoints.Orders_List);
      */
      _cart = [];
      String time = '${DateTime.now()}';
      /*
      convert object to string because sharedPrefs only accepts strings
      */
      for (var element in cartList) {
        element.time = time;
        _cart.add(jsonEncode(element));
      }
      DatabaseHelper.to.setList(EndPoints.Cart_List, _cart);
      getCartListFromLocalStorage();
      update();
    } catch (error) {
      log('error in add items in cart $error');
    }
  }

  // get cart data from local db
  List<CartModel> getCartListFromLocalStorage() {
    if (DatabaseHelper.to.containsKey(EndPoints.Cart_List)) {
      _cart = (DatabaseHelper.to.getList(EndPoints.Cart_List));
    }
    for (var element in _cart) {
      _cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    log('Cart ---> ${_cartList.map((element) => element.toJson()).toList()}');

    return _cartList;
  }

  // get cart data list
  List<CartModel> getCartList() {
    setCartList = getCartListFromLocalStorage();
    return _storageItems;
  }

  // set cart data list
  set setCartList(List<CartModel> items) {
    _storageItems = items;
    for (int i = 0; i < _storageItems.length; i++) {
      _items.putIfAbsent(
          _storageItems[i].product!.productId!, () => _storageItems[i]);
    }
  }

  // add orders data to local db
  void addOrdersListToLocalStorage() {
    try {
      for (var element in _cart) {
        _orders.add(element);
      }
      DatabaseHelper.to.setList(EndPoints.Orders_List, _orders);
      getOrdersListFromLocalStorage();
      update();
    } catch (error) {
      log('error in add items in orders $error');
    }
  }

  // get orders data from local db
  List<CartModel> getOrdersListFromLocalStorage() {
    _ordersList = [];
    if (DatabaseHelper.to.containsKey(EndPoints.Orders_List)) {
      _orders = [];
      _orders = (DatabaseHelper.to.getList(EndPoints.Orders_List));
    }

    for (var element in _orders) {
      /*
       convert object to string because sharedPrefs only accepts strings
      */
      _ordersList.add(CartModel.fromJson(jsonDecode(element)));
    }
    log('Orders ---> ${_ordersList.map((element) => element.toJson()).toList()}');

    return _ordersList.reversed.toList();
  }

  // add items to orders list
  void addItemsToOrdersList() {
    addOrdersListToLocalStorage();
    removeCart();
  }

  void onTappedCheckout() {
    if (AuthController.to.userLoggedIn()) {
      if (LocationController.to.addressList.isEmpty) {
        Get.toNamed(AppRoutes.address);
      } else {
        addItemsToOrdersList();
      }
    } else {
      Get.toNamed(AppRoutes.auth);
    }
  }

  void removeCart() {
    _items = {};
    _cart = [];
    _inCartItems = 0;
    DatabaseHelper.to.remove(EndPoints.Cart_List);
    update();
  }

  // one more this order
  set setItemsInCart(Map<int, CartModel> setItems) {
    _items = {};
    _items = (setItems);
    // add cart data in local db
    addCartListToLocalStorage(getItemsFromCart);
    update();
  }
}
