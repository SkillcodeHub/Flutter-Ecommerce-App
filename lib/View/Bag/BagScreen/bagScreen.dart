// import 'dart:async';
// import 'dart:convert';

// import 'package:ecommerce/Data/Response/status.dart';
// import 'package:ecommerce/Model/cartList_Model/cartList_model.dart';
// import 'package:ecommerce/Res/colors.dart';
// import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
// import 'package:ecommerce/Utils/utils.dart';
// import 'package:ecommerce/View/Bag/BagScreen/orderConfirmationScreen.dart';
// import 'package:ecommerce/View_Model/CartList_View_Model/cartList_view_model.dart';
// import 'package:ecommerce/View_Model/CartList_View_Model/deleteCart_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// class BagScreen extends StatefulWidget {
//   const BagScreen({super.key});

//   @override
//   State<BagScreen> createState() => _BagScreenState();
// }

// class _BagScreenState extends State<BagScreen> {
//   double orderAmount = 0;
//   double orderSaving = 0;
//   double platformFee = 0;
//   double orderTotal = 0;
//   late Future<void> fetchDataFuture;
//   String clientId = ClientId;
//   String ipAddress = IpAddress;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData();
//   }

//   Future<void> fetchData() async {
//     Timer(Duration(microseconds: 20), () {
//       final cartListViewmodel =
//           Provider.of<CartListViewmodel>(context, listen: false);
//       Map<String, String> data = {'customerId': CustomerId};

//       cartListViewmodel.fetchCartListApi(clientId, ipAddress, data);
//     });
//   }

//   double calculateTotalPrice(CartListViewmodel viewModel) {
//     double total = 0;
//     for (var item in viewModel.cartList.data!.cartList!) {
//       total += (double.parse(item.variantDetails!.price!) * item.qty!.toInt());
//     }
//     return total;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cartListViewmodel =
//         Provider.of<CartListViewmodel>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           'Bag products',
//           style: TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               Icons.favorite_border,
//               color: Colors.black,
//             ),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<CartListViewmodel>.value(
//                 value: cartListViewmodel,
//                 child: Consumer<CartListViewmodel>(
//                   builder: (context, value, _) {
//                     switch (value.cartList.status!) {
//                       case Status.LOADING:
//                         return Center(child: CircularProgressIndicator());
//                       case Status.ERROR:
//                         return handleError(value);
//                       case Status.COMPLETED:
//                         return _buildCompletedUI(context, value);
//                     }
//                   },
//                 ));
//           }
//         },
//       ),
//     );
//   }

//   Widget handleError(CartListViewmodel value) {
//     String? message;
//     if (value.cartList.message != "No Internet Connection") {
//       String jsonString = value.cartList.message.toString();
//       int startIndex = jsonString.indexOf('{');
//       int endIndex = jsonString.lastIndexOf('}');
//       String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
//       Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
//       message = jsonResponse['message'];
//     }
//     return value.cartList.message == "No Internet Connection"
//         ? ErrorScreenWidget(
//             onRefresh: () async {},
//             loadingText: value.cartList.message.toString(),
//           )
//         : Text('data');
//   }

//   Widget _buildCompletedUI(
//     BuildContext context,
//     CartListViewmodel cartListViewmodel,
//   ) {
//     double totalPrice = calculateTotalPrice(cartListViewmodel);

//     return cartListViewmodel.cartList.data!.cartList!.length != 0
//         ? Stack(
//             children: [
//               SingleChildScrollView(
//                 padding: EdgeInsets.only(bottom: 80),
//                 child: Column(
//                   children: [
//                     ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       itemCount:
//                           cartListViewmodel.cartList.data!.cartList!.length,
//                       itemBuilder: (context, index) => CartItemWidget(
//                         item: cartListViewmodel.cartList.data!.cartList![index],
//                         onRemove: () {
//                           setState(() {
//                             cartListViewmodel.cartList.data!.cartList!
//                                 .removeAt(index);
//                           });
//                         },
//                       ),
//                     ),
//                     Column(children: [
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Center(
//                           child: Text(
//                             'Assured Quality | 100% Handpicked | Easy Exchange',
//                             style: TextStyle(color: Colors.grey.shade500),
//                           ),
//                         ),
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.local_offer),
//                         title: Text('Apply coupon'),
//                         trailing: Text('Select',
//                             style: TextStyle(color: Colors.blue)),
//                         onTap: () {},
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(16),
//                         child: Text(
//                           'Order Payment Details',
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       OrderSummaryItem(
//                           'Order Amount', '₹ ${totalPrice.toStringAsFixed(2)}'),
//                       OrderSummaryItem('Order Saving',
//                           '- ₹ ${orderSaving.toStringAsFixed(2)}',
//                           isGreen: true),
//                       OrderSummaryItem('Convenience Fee', ''),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Delivery Fee'),
//                             Row(
//                               children: [
//                                 Text('Free',
//                                     style: TextStyle(color: Colors.green)),
//                                 SizedBox(width: 5),
//                                 Text(
//                                   '₹ 99.00',
//                                   style: TextStyle(
//                                       decoration: TextDecoration.lineThrough),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       OrderSummaryItem('Platform Fee',
//                           '₹ ${platformFee.toStringAsFixed(2)}'),
//                       Divider(),
//                       OrderSummaryItem('Order Total',
//                           '₹ ${(totalPrice + platformFee).toStringAsFixed(2)}',
//                           isBold: true),
//                       Container(
//                         padding: EdgeInsets.all(16),
//                         color: Colors.green[50],
//                         child: Center(
//                           child: Text(
//                             'Cheers! You saved ₹ ${orderSaving.toStringAsFixed(2)}',
//                             style: TextStyle(color: Colors.green),
//                           ),
//                         ),
//                       ),
//                     ]),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.white,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             '₹ ${(totalPrice + platformFee).toStringAsFixed(2)}',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text('View details',
//                               style: TextStyle(color: Colors.blue)),
//                         ],
//                       ),
//                       ElevatedButton(
//                         child: Text(
//                           'Proceed to Payment',
//                           style: TextStyle(fontSize: 14.sp),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30)),
//                           primary: Colors.red,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 45.0,
//                             vertical: 12.0,
//                           ),
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     OrderConfirmationScreen()),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )
//         : EmptyCartPage();
//   }
// }

// class EmptyCartPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Spacer(),
//             Text(
//               'Your Bag is Empty!',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'You have products in your Wishlist waiting to be yours',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black54,
//               ),
//             ),
//             SizedBox(height: 30),
//             Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 OutlinedButton(
//                   onPressed: () {
//                     // Handle continue shopping action
//                   },
//                   style: OutlinedButton.styleFrom(
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     'Continue Shopping',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle add from wishlist action
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.black,
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     'Add from Wishlist',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CartItemWidget extends StatelessWidget {
//   final CartList item;
//   final Function onRemove;

//   CartItemWidget({required this.item, required this.onRemove});
//   String convertLocalhost(String url) {
//     return url.replaceAll('http://localhost:8000', ngrokUrl);
//   }

//   @override
//   Widget build(BuildContext context) {
//     double itemTotal =
//         double.parse(item.variantDetails!.price!) * item.qty!.toInt();

//     return Card(
//       margin: EdgeInsets.all(8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Image.network(
//                     convertLocalhost(
//                         item.variantDetails!.variantImage.toString()),
//                     width: 100,
//                     height: 150,
//                     fit: BoxFit.cover,
//                     errorBuilder: (context, error, stackTrace) =>
//                         Icon(Icons.error)),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(item.productDetails!.productName.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(item.clientDetails!.companyName.toString()),
//                       Row(
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               // _showSizeSelector(context);
//                             },
//                             child: Chip(
//                                 padding: EdgeInsets.all(0),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 label: Row(
//                                   children: [
//                                     Text(
//                                         'Size ${item.variantDetails!.variantkey}'),
//                                     Icon(Icons.arrow_drop_down)
//                                   ],
//                                 )),
//                           ),
//                           SizedBox(width: 8),
//                           GestureDetector(
//                             onTap: () {
//                               // _showQuantitySelector(context);
//                             },
//                             child: Chip(
//                                 padding: EdgeInsets.all(0),
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(5)),
//                                 label: Row(
//                                   children: [
//                                     Text('Qty ${item.qty}'),
//                                     Icon(Icons.arrow_drop_down)
//                                   ],
//                                 )),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   Text('₹ ${itemTotal.toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(width: 1.w),
//                                 ],
//                               ),
//                               SizedBox(height: 1.h),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 6),
//             Divider(
//               color: Colors.grey.shade400,
//             ),
//             Align(
//               alignment: Alignment.topRight,
//               child: TextButton(
//                 child: Text('Remove'),
//                 onPressed: () async {
//                   Map<String, String> data = {
//                     'clientId': ClientId,
//                     'id': item.id.toString(),
//                     'isDelete': 'Yes',
//                   };

//                   final deleteCartViewModel =
//                       Provider.of<DeleteCartViewModel>(context, listen: false);

//                   bool success = await deleteCartViewModel.deleteCartApi(
//                       IpAddress.toString(), data, context);
//                   if (success) {
//                     onRemove(); // Call the onRemove callback
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class OrderSummaryItem extends StatelessWidget {
//   final String title;
//   final String value;
//   final bool isGreen;
//   final bool isBold;

//   OrderSummaryItem(this.title, this.value,
//       {this.isGreen = false, this.isBold = false});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title),
//           Text(
//             value,
//             style: TextStyle(
//               color: isGreen ? Colors.green : null,
//               fontWeight: isBold ? FontWeight.bold : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Model/cartList_Model/cartList_model.dart';
import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Bag/BagScreen/orderConfirmationScreen.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/cartList_view_model.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/deleteCart_view_model.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/editCart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({super.key});

  @override
  State<BagScreen> createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  double orderAmount = 0;
  double orderSaving = 0;
  double platformFee = 0;
  double orderTotal = 0;
  late Future<void> fetchDataFuture;
  String clientId = ClientId;
  String ipAddress = IpAddress;

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final cartListViewmodel =
          Provider.of<CartListViewmodel>(context, listen: false);
      Map<String, String> data = {'customerId': CustomerId};

      cartListViewmodel.fetchCartListApi(clientId, ipAddress, data);
    });
  }

  double calculateTotalPrice(CartListViewmodel viewModel) {
    double total = 0;
    for (var item in viewModel.cartList.data!.cartList!) {
      total += (double.parse(item.variantDetails!.price!) * item.qty!.toInt());
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final cartListViewmodel =
        Provider.of<CartListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Bag products',
          style: TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<CartListViewmodel>.value(
                value: cartListViewmodel,
                child: Consumer<CartListViewmodel>(
                  builder: (context, value, _) {
                    switch (value.cartList.status!) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return handleError(value);
                      case Status.COMPLETED:
                        return _buildCompletedUI(context, value);
                    }
                  },
                ));
          }
        },
      ),
    );
  }

  Widget handleError(CartListViewmodel value) {
    String? message;
    if (value.cartList.message != "No Internet Connection") {
      String jsonString = value.cartList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.cartList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.cartList.message.toString(),
          )
        : Text('data');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    CartListViewmodel cartListViewmodel,
  ) {
    double totalPrice = calculateTotalPrice(cartListViewmodel);

    return cartListViewmodel.cartList.data!.cartList!.length != 0
        ? Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 80),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:
                          cartListViewmodel.cartList.data!.cartList!.length,
                      itemBuilder: (context, index) => CartItemWidget(
                        item: cartListViewmodel.cartList.data!.cartList![index],
                        onRemove: () {
                          setState(() {
                            cartListViewmodel.cartList.data!.cartList!
                                .removeAt(index);
                          });
                        },
                        onQuantityChanged: (newQuantity) {
                          setState(() async {
                            cartListViewmodel.cartList.data!.cartList![index]
                                .qty = newQuantity.toString();
                            Map<String, String> data = {
                              'clientId': ClientId,
                              'id': cartListViewmodel
                                  .cartList.data!.cartList![index].id
                                  .toString(),
                              'qty': newQuantity.toString(),
                              'created_by': createdBy,
                            };

                            final editCartViewModel =
                                Provider.of<EditCartViewModel>(context,
                                    listen: false);

                            bool success = await editCartViewModel.editCartApi(
                              IpAddress.toString(),
                              data,
                              context,
                            );

                            if (success) {
                              // widget.onRemove();
                            }

                            print(
                                "cartListViewmodelcartListViewmodelcartListViewmodelcartListViewmodelcartListViewmodel");
                            print(newQuantity.toString());
                            print(
                                "cartListViewmodelcartListViewmodelcartListViewmodelcartListViewmodel");
                          });
                          // You may want to update the cart on the server here
                        },
                      ),
                    ),
                    Column(children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Assured Quality | 100% Handpicked | Easy Exchange',
                            style: TextStyle(color: Colors.grey.shade500),
                          ),
                        ),
                      ),
                      ApplyCouponWidget(),

                      // ListTile(
                      //   leading: Icon(Icons.local_offer),
                      //   title: Text('Apply coupon'),
                      //   trailing: Text('Select',
                      //       style: TextStyle(color: Colors.blue)),
                      //   onTap: () {},
                      // ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Order Payment Details',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      OrderSummaryItem(
                          'Order Amount', '₹ ${totalPrice.toStringAsFixed(2)}'),
                      OrderSummaryItem('Order Saving',
                          '- ₹ ${orderSaving.toStringAsFixed(2)}',
                          isGreen: true),
                      OrderSummaryItem('Convenience Fee', ''),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Delivery Fee'),
                            Row(
                              children: [
                                Text('Free',
                                    style: TextStyle(color: Colors.green)),
                                SizedBox(width: 5),
                                Text(
                                  '₹ 99.00',
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      OrderSummaryItem('Platform Fee',
                          '₹ ${platformFee.toStringAsFixed(2)}'),
                      Divider(),
                      OrderSummaryItem('Order Total',
                          '₹ ${(totalPrice + platformFee).toStringAsFixed(2)}',
                          isBold: true),
                      Container(
                        padding: EdgeInsets.all(16),
                        color: Colors.green[50],
                        child: Center(
                          child: Text(
                            'Cheers! You saved ₹ ${orderSaving.toStringAsFixed(2)}',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '₹ ${(totalPrice + platformFee).toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('View details',
                              style: TextStyle(color: Colors.blue)),
                        ],
                      ),
                      ElevatedButton(
                        child: Text(
                          'Proceed to Payment',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          primary: Colors.red,
                          padding: EdgeInsets.symmetric(
                            horizontal: 45.0,
                            vertical: 12.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OrderConfirmationScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : EmptyCartPage();
  }
}

class ApplyCouponWidget extends StatefulWidget {
  const ApplyCouponWidget({Key? key}) : super(key: key);

  @override
  _ApplyCouponWidgetState createState() => _ApplyCouponWidgetState();
}

class _ApplyCouponWidgetState extends State<ApplyCouponWidget> {
  final TextEditingController _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
            child: Text(
              'Apply Coupon',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: const InputDecoration(
                      hintText: 'Please enter a valid coupon code',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Add your coupon application logic here
                    print('Applying coupon: ${_couponController.text}');
                  },
                  child: Text(
                    'Apply',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }
}

class EmptyCartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Text(
              'Your Bag is Empty!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'You have products in your Wishlist waiting to be yours',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 30),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Handle continue shopping action
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Continue Shopping',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle add from wishlist action
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Add from Wishlist',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartItemWidget extends StatefulWidget {
  final CartList item;
  final Function onRemove;
  final Function(int) onQuantityChanged;

  CartItemWidget({
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.item.qty!.toInt();
  }

  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost:8000', ngrokUrl);
  }

  void _incrementQuantity() {
    if (quantity < widget.item.productDetails!.maxQuantity.toInt()) {
      setState(() {
        quantity++;
      });
      widget.onQuantityChanged(quantity);
    }
  }

  void _decrementQuantity() {
    if (quantity > widget.item.productDetails!.minQuantity.toInt()) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChanged(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemTotal =
        double.parse(widget.item.variantDetails!.price!) * quantity;

    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  convertLocalhost(
                    widget.item.variantDetails!.variantImage.toString(),
                  ),
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.error),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.productDetails!.productName.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(widget.item.clientDetails!.companyName.toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _showSizeSelector(context);
                            },
                            child: Chip(
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              label: Row(
                                children: [
                                  Text(
                                    '${widget.item.variantDetails!.variantkey}',
                                  ),
                                  // Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       icon: Icon(Icons.remove),
                          //       onPressed: _decrementQuantity,
                          //     ),
                          //     Text('$quantity'),
                          //     IconButton(
                          //       icon: Icon(Icons.add),
                          //       onPressed: _incrementQuantity,
                          //     ),
                          //   ],
                          // ),

                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: _decrementQuantity,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(20)),
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                        ),
                                        child: Icon(Icons.remove,
                                            size: 18, color: Colors.grey[700]),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      child: Text(
                                        '$quantity',
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _incrementQuantity,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(20)),
                                          border: Border.all(
                                              color: Colors.grey[300]!),
                                        ),
                                        child: Icon(Icons.add,
                                            size: 18, color: Colors.grey[700]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '₹ ${itemTotal.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 1.w),
                                ],
                              ),
                              SizedBox(height: 1.h),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Divider(
              color: Colors.grey.shade400,
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                child: Text('Remove'),
                onPressed: () async {
                  Map<String, String> data = {
                    'clientId': ClientId,
                    'id': widget.item.id.toString(),
                    'isDelete': 'Yes',
                  };

                  final deleteCartViewModel =
                      Provider.of<DeleteCartViewModel>(context, listen: false);

                  bool success = await deleteCartViewModel.deleteCartApi(
                    IpAddress.toString(),
                    data,
                    context,
                  );
                  if (success) {
                    widget.onRemove();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isGreen;
  final bool isBold;

  OrderSummaryItem(this.title, this.value,
      {this.isGreen = false, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            value,
            style: TextStyle(
              color: isGreen ? Colors.green : null,
              fontWeight: isBold ? FontWeight.bold : null,
            ),
          ),
        ],
      ),
    );
  }
}
