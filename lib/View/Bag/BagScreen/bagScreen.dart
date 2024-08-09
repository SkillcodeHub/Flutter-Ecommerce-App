// import 'dart:async';
// import 'dart:convert';

// import 'package:ecommerce/Data/Response/status.dart';
// import 'package:ecommerce/Model/cartList_Model/cartList_model.dart';
// import 'package:ecommerce/Res/colors.dart';
// import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
// import 'package:ecommerce/Utils/utils.dart';
// import 'package:ecommerce/View/Bag/BagScreen/orderConfirmationScreen.dart';
// import 'package:ecommerce/View_Model/CartList_View_Model/cartList_view_model.dart';
// import 'package:flutter/material.dart';
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
//   double platformFee = 19.00;
//   double orderTotal = 0;
//   late Future<void> fetchDataFuture;
//   String clientId = ClientId;
//   String ipAddress = IpAddress;

//   @override
//   void initState() {
//     super.initState();

//     // _calculateTotals();
//     fetchDataFuture = fetchData(); // Call the API only once
//   }

//   Future<void> fetchData() async {
//     Timer(Duration(microseconds: 20), () {
//       final cartListViewmodel =
//           Provider.of<CartListViewmodel>(context, listen: false);
//       Map<String, String> data = {'customerId': CustomerId};

//       cartListViewmodel.fetchCartListApi(clientId, ipAddress, data);
//     });
//   }

//   // final List<CartItem> cartItems = [
//   //   CartItem(
//   //     brand: 'GAP',
//   //     name: 'Men Logo Print Zip-Front Hoodie',
//   //     size: 'L',
//   //     quantity: 1,
//   //     price: 1959.00,
//   //     availableSizes: ['39', '40', '42', '44', '46', '48'],
//   //     maxQuantity: 10,
//   //     originalPrice: 2799.00,
//   //     discount: 30,
//   //     savings: 840.00,
//   //     imageUrl: 'images/sale_photo_2.png',
//   //     leftInStock: 7,
//   //   ),
//   //   CartItem(
//   //     brand: 'LEVIS',
//   //     name: 'Men Mid-Wash Slim Tapered Fit Jeans',
//   //     size: '34',
//   //     quantity: 1,
//   //     price: 1332.00,
//   //     availableSizes: ['39', '40', '42', '44', '46', '48'],
//   //     maxQuantity: 10,
//   //     originalPrice: 3599.00,
//   //     discount: 63,
//   //     savings: 2267.00,
//   //     imageUrl: 'images/sale_photo_2.png',
//   //     leftInStock: 1,
//   //   ),
//   //   CartItem(
//   //     brand: 'Kvetoo',
//   //     name: 'Ribbed High-Neck Pullover',
//   //     size: 'L',
//   //     quantity: 1,
//   //     price: 750.00,
//   //     availableSizes: ['39', '40', '42', '44', '46', '48'],
//   //     maxQuantity: 10,
//   //     originalPrice: 2499.00,
//   //     discount: 70,
//   //     savings: 1749.00,
//   //     imageUrl: 'images/sale_photo_2.png',
//   //     leftInStock: null,
//   //   ),

//   //   // Add more CartItem objects here for other products
//   // ];

//   // void _calculateTotals() {
//   //   orderAmount = 0;
//   //   orderSaving = 0;
//   //   orderTotal = 0;

//   //   for (var item in cartItems) {
//   //     orderAmount += item.originalPrice * item.quantity;
//   //     orderSaving += item.savings * item.quantity;
//   //   }

//   //   orderTotal = orderAmount - orderSaving + platformFee;
//   // }

//   // void _updateCartItem(int index, CartItem updatedItem) {
//   //   setState(() {
//   //     cartItems[index] = updatedItem;
//   //     _calculateTotals();
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final cartListViewmodel =
//         Provider.of<CartListViewmodel>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         // leading:

//         //     IconButton(
//         //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//         //   onPressed: () {
//         //     Navigator.pop(context);
//         //   },
//         // ),
//         backgroundColor: Colors.white,
//         title: Text(
//           'Bag products)',
//           // 'Bag (${cartItems.length} products)',
//           style: TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
//         ),
//         // title: Text('Bag (${cartItems.length} products)'),
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
//     CartListViewmodel customerAddressesViewmodel,
//   ) {
//     return Stack(
//       children: [
//         SingleChildScrollView(
//           padding: EdgeInsets.only(bottom: 80),
//           child: Column(
//             children: [
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount:
//                     customerAddressesViewmodel.cartList.data!.cartList!.length,
//                 itemBuilder: (context, index) => CartItemWidget(
//                   item: customerAddressesViewmodel
//                       .cartList.data!.cartList![index],
//                   // onUpdate: (updatedItem) =>
//                   //     _updateCartItem(index, updatedItem),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Center(
//                   child: Text(
//                     'Assured Quality | 100% Handpicked | Easy Exchange',
//                     style: TextStyle(color: Colors.grey.shade500),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.local_offer),
//                 title: Text('Apply coupon'),
//                 trailing: Text('Select', style: TextStyle(color: Colors.blue)),
//                 onTap: () {},
//               ),
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   'Order Payment Details',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               OrderSummaryItem(
//                   'Order Amount', '₹ ${orderAmount.toStringAsFixed(2)}'),
//               OrderSummaryItem(
//                   'Order Saving', '- ₹ ${orderSaving.toStringAsFixed(2)}',
//                   isGreen: true),
//               OrderSummaryItem('Convenience Fee', ''),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Delivery Fee'),
//                     Row(
//                       children: [
//                         Text('Free', style: TextStyle(color: Colors.green)),
//                         SizedBox(width: 5),
//                         Text(
//                           '₹ 99.00',
//                           style:
//                               TextStyle(decoration: TextDecoration.lineThrough),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               OrderSummaryItem(
//                   'Platform Fee', '₹ ${platformFee.toStringAsFixed(2)}'),
//               Divider(),
//               OrderSummaryItem(
//                   'Order Total', '₹ ${orderTotal.toStringAsFixed(2)}',
//                   isBold: true),
//               Container(
//                 padding: EdgeInsets.all(16),
//                 color: Colors.green[50],
//                 child: Center(
//                   child: Text(
//                     'Cheers! You saved ₹ ${orderSaving.toStringAsFixed(2)}',
//                     style: TextStyle(color: Colors.green),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: 0,
//           right: 0,
//           bottom: 0,
//           child: Container(
//             padding: EdgeInsets.all(16),
//             color: Colors.white,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       '₹ ${orderTotal.toStringAsFixed(2)}',
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     Text('View details', style: TextStyle(color: Colors.blue)),
//                   ],
//                 ),
//                 ElevatedButton(
//                   child: Text(
//                     'Proceed to Payment',
//                     style: TextStyle(fontSize: 14.sp),
//                   ),
//                   style: ElevatedButton.styleFrom(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30)),
//                     primary: Colors.red,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 45.0,
//                       vertical: 12.0,
//                     ),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => OrderConfirmationScreen()),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class CartItemWidget extends StatelessWidget {
//   final CartList item;
//   // final Function(CartItem) onUpdate;

//   CartItemWidget({required this.item
//       // , required this.onUpdate
//       });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(8),
//       child: Padding(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Image.asset(item.variantDetails!.variantImage.toString(),
//                 Image.asset('images/sale_photo_2.png',
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
//                       Text(item.customerDetails!.customerName.toString(),
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(item.productDetails!.productName.toString()),
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
//                                   Text('₹ ${(item.variantDetails!.price!)}',
//                                       // '₹ ${(item.variantDetails!.price! * item.qty.toInt()).toStringAsFixed(2)}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold)),
//                                   SizedBox(width: 1.w),
//                                   // Text(
//                                   //     '₹ ${(item.originalPrice * item.quantity).toStringAsFixed(2)}',
//                                   //     style: TextStyle(
//                                   //         decoration:
//                                   //             TextDecoration.lineThrough,
//                                   //         color: Colors.grey.shade400)),
//                                   SizedBox(width: 1.w),
//                                   // Text('(${item.discount}%)',
//                                   //     style: TextStyle(
//                                   //         color: Colors.grey.shade400)),
//                                 ],
//                               ),
//                               SizedBox(height: 1.h),
//                               // Text(
//                               //     'You save ₹ ${(item.savings * item.quantity).toStringAsFixed(2)}',
//                               //     style:
//                               //         TextStyle(color: Colors.green.shade700)),
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
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // void _showSizeSelector(BuildContext context) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return SizeSelectorSheet(
//   //         currentSize: item.size,
//   //         availableSizes: item.availableSizes,
//   //         onSizeSelected: (newSize) {
//   //           Navigator.pop(context);
//   //           onUpdate(item.copyWith(size: newSize));
//   //         },
//   //       );
//   //     },
//   //   );
//   // }

//   // void _showQuantitySelector(BuildContext context) {
//   //   showModalBottomSheet(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return QuantitySelectorSheet(
//   //         currentQuantity: item.quantity,
//   //         maxQuantity: item.maxQuantity,
//   //         leftInStock: item.leftInStock,
//   //         onQuantitySelected: (newQuantity) {
//   //           Navigator.pop(context);
//   //           final updatedItem = item.copyWith(quantity: newQuantity);
//   //           onUpdate(updatedItem);
//   //         },
//   //       );
//   //     },
//   //   );
//   // }
// }

// class SizeSelectorSheet extends StatelessWidget {
//   final String currentSize;
//   final List<String> availableSizes;
//   final Function(String) onSizeSelected;

//   SizeSelectorSheet(
//       {required this.currentSize,
//       required this.availableSizes,
//       required this.onSizeSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Select Size',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 16),
//           Wrap(
//             spacing: 8,
//             runSpacing: 8,
//             children: availableSizes
//                 .map((size) => ElevatedButton(
//                       child: Text(size),
//                       style: ElevatedButton.styleFrom(
//                         primary:
//                             size == currentSize ? Colors.black : Colors.white,
//                         onPrimary:
//                             size == currentSize ? Colors.white : Colors.black,
//                       ),
//                       onPressed: () => onSizeSelected(size),
//                     ))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuantitySelectorSheet extends StatefulWidget {
//   final int currentQuantity;
//   final int maxQuantity;
//   final int? leftInStock;
//   final Function(int) onQuantitySelected;

//   QuantitySelectorSheet({
//     required this.currentQuantity,
//     required this.maxQuantity,
//     this.leftInStock,
//     required this.onQuantitySelected,
//   });

//   @override
//   State<QuantitySelectorSheet> createState() => _QuantitySelectorSheetState();
// }

// class _QuantitySelectorSheetState extends State<QuantitySelectorSheet> {
//   late int _quantity;

//   @override
//   void initState() {
//     super.initState();
//     _quantity = widget.currentQuantity;
//   }

//   void _incrementQuantity() {
//     if (_quantity < (widget.leftInStock ?? widget.maxQuantity)) {
//       setState(() {
//         _quantity++;
//       });
//     }
//   }

//   void _decrementQuantity() {
//     if (_quantity > 1) {
//       setState(() {
//         _quantity--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text('Select Quantity',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.remove),
//                 onPressed: _quantity > 1 ? _decrementQuantity : null,
//               ),
//               Text(_quantity.toString(), style: TextStyle(fontSize: 20)),
//               IconButton(
//                 icon: Icon(Icons.add),
//                 onPressed:
//                     _quantity < (widget.leftInStock ?? widget.maxQuantity)
//                         ? _incrementQuantity
//                         : null,
//               ),
//             ],
//           ),
//           if (widget.leftInStock != null && widget.leftInStock! <= 5)
//             Text('${widget.leftInStock} left',
//                 style: TextStyle(color: Colors.red)),
//           SizedBox(height: 16),
//           ElevatedButton(
//             child: Text('Update'),
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30)),
//               primary: Colors.red,
//               padding: EdgeInsets.symmetric(
//                 horizontal: 45.0,
//                 vertical: 12.0,
//               ),
//             ),
//             onPressed: () {
//               widget.onQuantitySelected(_quantity);
//               // Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class OrderSummaryItem extends StatefulWidget {
//   final String title;
//   final String value;
//   final bool isGreen;
//   final bool isBold;

//   OrderSummaryItem(this.title, this.value,
//       {this.isGreen = false, this.isBold = false});

//   @override
//   State<OrderSummaryItem> createState() => _OrderSummaryItemState();
// }

// class _OrderSummaryItemState extends State<OrderSummaryItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(widget.title),
//           Text(
//             widget.value,
//             style: TextStyle(
//               color: widget.isGreen ? Colors.green : null,
//               fontWeight: widget.isBold ? FontWeight.bold : null,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CartItem {
//   final String brand;
//   final String name;
//   final String size;
//   int quantity;
//   final double price;
//   final List<String> availableSizes;
//   final int maxQuantity;
//   final double originalPrice;
//   final int discount;
//   final double savings;
//   final String imageUrl;
//   final int? leftInStock;

//   CartItem({
//     required this.brand,
//     required this.name,
//     required this.size,
//     required this.quantity,
//     required this.price,
//     required this.availableSizes,
//     required this.maxQuantity,
//     required this.originalPrice,
//     required this.discount,
//     required this.savings,
//     required this.imageUrl,
//     required this.leftInStock,
//   });

//   CartItem copyWith({
//     String? size,
//     int? quantity,
//   }) {
//     return CartItem(
//       brand: this.brand,
//       name: this.name,
//       size: size ?? this.size,
//       quantity: quantity ?? this.quantity,
//       price: this.price,
//       availableSizes: this.availableSizes,
//       maxQuantity: this.maxQuantity,
//       originalPrice: this.originalPrice,
//       discount: this.discount,
//       savings: this.savings,
//       imageUrl: this.imageUrl,
//       leftInStock: this.leftInStock,
//     );
//   }

//   void updateQuantity(int newQuantity) {
//     quantity = newQuantity;
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
          'Bag products)',
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
    CartListViewmodel customerAddressesViewmodel,
  ) {
    double totalPrice = calculateTotalPrice(customerAddressesViewmodel);

    return Stack(
      children: [
        SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 80),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    customerAddressesViewmodel.cartList.data!.cartList!.length,
                itemBuilder: (context, index) => CartItemWidget(
                  item: customerAddressesViewmodel
                      .cartList.data!.cartList![index],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'Assured Quality | 100% Handpicked | Easy Exchange',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.local_offer),
                title: Text('Apply coupon'),
                trailing: Text('Select', style: TextStyle(color: Colors.blue)),
                onTap: () {},
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Order Payment Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              OrderSummaryItem(
                  'Order Amount', '₹ ${totalPrice.toStringAsFixed(2)}'),
              OrderSummaryItem(
                  'Order Saving', '- ₹ ${orderSaving.toStringAsFixed(2)}',
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
                        Text('Free', style: TextStyle(color: Colors.green)),
                        SizedBox(width: 5),
                        Text(
                          '₹ 99.00',
                          style:
                              TextStyle(decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              OrderSummaryItem(
                  'Platform Fee', '₹ ${platformFee.toStringAsFixed(2)}'),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text('View details', style: TextStyle(color: Colors.blue)),
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
                          builder: (context) => OrderConfirmationScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final CartList item;

  CartItemWidget({required this.item});
  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost:8000', ngrokUrl);
  }

  @override
  Widget build(BuildContext context) {
    double itemTotal =
        double.parse(item.variantDetails!.price!) * item.qty!.toInt();

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
                        item.variantDetails!.variantImage.toString()),
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.error)),
                // Image.asset('images/sale_photo_2.png',
                //     width: 100,
                //     height: 150,
                //     fit: BoxFit.cover,
                //     errorBuilder: (context, error, stackTrace) =>
                //         Icon(Icons.error)),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.productDetails!.productName.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(item.clientDetails!.companyName.toString()),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // _showSizeSelector(context);
                            },
                            child: Chip(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                label: Row(
                                  children: [
                                    Text(
                                        'Size ${item.variantDetails!.variantkey}'),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                )),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              // _showQuantitySelector(context);
                            },
                            child: Chip(
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                label: Row(
                                  children: [
                                    Text('Qty ${item.qty}'),
                                    Icon(Icons.arrow_drop_down)
                                  ],
                                )),
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
                                  Text('₹ ${itemTotal.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
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
                onPressed: () {},
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
