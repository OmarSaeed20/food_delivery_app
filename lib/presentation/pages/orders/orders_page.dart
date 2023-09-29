import 'dart:convert';
import 'package:intl/intl.dart';
import '../../../index.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<CartModel> ordersList =
        CartController.to.getOrdersListFromLocalStorage();
    final Map<String, int> cartItemsPerOrder = {};
    for (int i = 0; i < ordersList.length; i++) {
      if (cartItemsPerOrder.containsKey(ordersList[i].time)) {
        /* 
        update item in list
        */
        cartItemsPerOrder.update('${ordersList[i].time}', (val) => ++val);
      } else {
        /*
         put item --- put if absent--> key, value
        */
        cartItemsPerOrder.putIfAbsent('${ordersList[i].time}', () => 1);
      }
    }
    List<int> itemsPerOrderVal() {
      return cartItemsPerOrder.entries.map((element) => element.value).toList();
    }

    // key --> time
    List<String> itemsPerOrderKey() {
      return cartItemsPerOrder.entries.map((element) => element.key).toList();
    }

    int counter = 0;
    Map<int, CartModel> items = {};

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        padding: AppConstants.paddingSTEB,
        children: [
          for (int i = 0; i < itemsPerOrderVal().length; i++)
            Container(
              height: getProportionateScreenHeight(120),
              margin: EdgeInsetsDirectional.only(
                  bottom: getProportionateScreenHeight(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (() {
                    DateTime dateTime =
                        DateTime.parse(ordersList[counter].time!);
                    String formattedTime =
                        DateFormat('d MMMM, EEEE hh:mm a').format(dateTime);
                    return TextWidget(
                      text: formattedTime,
                      fontSize: getProportionateScreenWidth(15.0),
                    );
                  }()),
                  AppConstants.kHeightBox10,
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Wrap(
                          direction: Axis.horizontal,
                          children: List.generate(
                            itemsPerOrderVal()[i],
                            (index) {
                              if (counter < ordersList.length) {
                                counter++;
                              }
                              return index <= 2
                                  ? Container(
                                      height: getProportionateScreenHeight(65),
                                      width: getProportionateScreenHeight(65),
                                      margin: EdgeInsetsDirectional.only(
                                          end: getProportionateScreenWidth(5)),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            AppConstants.borderRadius / 2,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              '${EndPoints.Uploads_Uri}${ordersList[counter - 1].image}'),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          height: getProportionateScreenHeight(80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const TextWidget(text: 'Total'),
                              TextWidget(
                                text: '${itemsPerOrderVal()[i]} Items',
                              ),
                              AppConstants.kHeightBox5,
                              BtnWidget(
                                title: 'one more',
                                height: getProportionateScreenHeight(30),
                                fontSize: getProportionateScreenWidth(12),
                                backgroundColor: AppColors.transparent,
                                borderColor: AppColors.primaryColor,
                                titleColor: AppColors.primaryColor,
                                onPressed: () {
                                  for (int j = 0; j < ordersList.length; j++) {
                                    if (ordersList[j].time ==
                                        itemsPerOrderKey()[i]) {
                                      /*
                                      log('Tapped ---> ${ordersList[j].productId}'); // 8, 5, 4, 3
                                      log('Tapped ---> ${ordersList[j].product!.toJson()}'); // 8, 5, 4, 3
                                      */
                                      items.putIfAbsent(
                                        ordersList[j].productId!,
                                        () => CartModel.fromJson(
                                          jsonDecode(
                                            jsonEncode(ordersList[j]),
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  /*
                                      moreOrder.entries
                                          .map((element) =>
                                              log('${element.value.toJson()}'))
                                          .toList();
                                      */
                                  CartController.to.setItemsInCart = items;
                                  Get.toNamed(AppRoutes.cart);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
/*
  List<Map<String, String>> cart =[
    // order-1
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-10 07:42:40.846783'},
    // order-2
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-13 07:42:40.846783'},
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-13 07:42:40.846783'},
    // order-3
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-14 07:42:40.846783'},
    // order-4
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-15 07:42:40.846783'},
    // order-5
    {'id': '1', 'name': 'Nutritious fruit meal in china','time':' 2023-02-16 07:42:40.846783'},
  ];
 Map<String , int> cartItemsPerOrder = {};
  for(int i=0; i< cart.length;i++){
    if(cartItemsPerOrder.containsKey(cart[i]['time'])){
      // update item
      cartItemsPerOrder.update('${cart[i]['time']}',(value)=> ++value);
    }else{
      // put item --- put if absent--> key, value
      cartItemsPerOrder.putIfAbsent('${cart[i]['time']}',()=> 1);
    }
    
  }
  print (cartItemsPerOrder.values);
  out puts ---> (1, 2, 1, 1, 1)

  print (cartItemsPerOrder);
  out puts ---> { 2023-02-10 07:42:40.846783: 1,  2023-02-13 07:42:40.846783: 2,  2023-02-14 07:42:40.846783: 1,  2023-02-15 07:42:40.846783: 1,  2023-02-16 07:42:40.846783: 1}
 
  List<int> orderTimeList() {
   return cartItemsPerOrder.entries.map((element){
    return element.value;
  }).toList();
    
  } 
  print(orderTimeList());
*/