// import 'package:ecommerce/View/Bag/BagScreen/orderDetailScreen.dart';
// import 'package:flutter/material.dart';

// class OrdersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         title: Text('Orders'),
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             // child: Container(
//             //   padding: EdgeInsets.all(8),
//             //   color: Colors.yellow[100],
//             //   child: Row(
//             //     children: [
//             //       Icon(Icons.warning, color: Colors.orange),
//             //       SizedBox(width: 8),
//             //       Expanded(
//             //         child: Text(
//             //           'Hey! Please note that AJIO or its employees wi...',
//             //           style: TextStyle(color: Colors.black87),
//             //         ),
//             //       ),
//             //       Text(
//             //         'Read More',
//             //         style: TextStyle(color: Colors.blue),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text('Showing order from Last 6 months'),
//                 OutlinedButton.icon(
//                   onPressed: () {},
//                   icon: Icon(Icons.filter_list),
//                   label: Text('FILTERS'),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text('Order ID - FN4705504360'),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Card(
//               child: ListTile(
//                 leading: Image.asset('images/sale_photo_2.png'),
//                 title: Text('Arriving By Mon, 22 Jul'),
//                 subtitle: Text('UPI'),
//                 trailing: Icon(Icons.chevron_right),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => OrderDetailsScreen()));
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'dart:async';
// import 'dart:convert';

// import 'package:ecommerce/Data/Response/status.dart';
// import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderList_model.dart';
// import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
// import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/orderList_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class OrdersScreen extends StatefulWidget {
//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   List<Products> allProducts = [];
//   late Future<void> fetchDataFuture;
//   String clientId = '1';
//   String ipAddress = '192.168.0.1';

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData(); // Call the API only once
//   }

//   Future<void> fetchData() async {
//     Timer(Duration(microseconds: 20), () {
//       final orderListViewmodel =
//           Provider.of<OrderListViewmodel>(context, listen: false);
//       Map<String, String> data = {'customerId': '1'};

//       orderListViewmodel.fetchOrderListApi(clientId, ipAddress, data);
//     });
//   }

//   String convertLocalhost(String url) {
//     return url.replaceAll('http://localhost', 'http://10.0.2.2');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orderListViewmodel =
//         Provider.of<OrderListViewmodel>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Product List'),
//       ),
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<OrderListViewmodel>.value(
//                 value: orderListViewmodel,
//                 child: Consumer<OrderListViewmodel>(
//                   builder: (context, value, _) {
//                     switch (value.orderList.status!) {
//                       case Status.LOADING:
//                         return Center(child: CircularProgressIndicator());
//                       case Status.ERROR:
//                         return handleError(value);
//                       case Status.COMPLETED:
//                         for (var order in value
//                             .orderList.data!.customerOrderList!
//                             .toList()) {
//                           allProducts.addAll(order.products!.toList());
//                         }
//                         return _buildCompletedUI(context, value);
//                     }
//                   },
//                 ));
//           }
//         },
//       ),
//     );
//   }

//   Widget handleError(OrderListViewmodel value) {
//     String? message;
//     if (value.orderList.message != "No Internet Connection") {
//       String jsonString = value.orderList.message.toString();
//       int startIndex = jsonString.indexOf('{');
//       int endIndex = jsonString.lastIndexOf('}');
//       String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
//       Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
//       message = jsonResponse['message'];
//     }
//     return value.orderList.message == "No Internet Connection"
//         ? ErrorScreenWidget(
//             onRefresh: () async {},
//             loadingText: value.orderList.message.toString(),
//           )
//         : Text('data');
//   }

//   Widget _buildCompletedUI(
//     BuildContext context,
//     OrderListViewmodel orderListViewmodel,
//   ) {
//     return ListView.builder(
//       itemCount: allProducts.length,
//       itemBuilder: (context, index) {
//         var product = allProducts[index];
//         var productDetail = product.productDetail;
//         var variantDetail = product.variantDetail;

//         return Card(
//           margin: EdgeInsets.all(8.0),
//           child: ListTile(
//             leading: Image.network(
//               // variantDetail!.variantImage.toString(),
//               convertLocalhost(variantDetail!.variantImage.toString()),

//               width: 50,
//               height: 50,
//               fit: BoxFit.cover,
//             ),
//             title: Text(productDetail!.productname.toString()),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Variant: ${variantDetail.variantkey}'),
//                 Text('Price: ₹${variantDetail.price}'),
//                 Text('Quantity: ${product.qty}'),
//               ],
//             ),
//             trailing: Text('₹${product.finalAmount}'),
//             onTap: () {
//               // Navigate to product detail page
//             },
//           ),
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderList_model.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Bag/BagScreen/orderDetailScreen.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/orderList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Map<String, dynamic>> allProductsWithOrderInfo = [];
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
      final orderListViewmodel =
          Provider.of<OrderListViewmodel>(context, listen: false);
      Map<String, String> data = {'customerId': CustomerId};

      orderListViewmodel.fetchOrderListApi(clientId, ipAddress, data);
    });
  }

  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost', 'http://10.0.2.2');
  }

  @override
  Widget build(BuildContext context) {
    final orderListViewmodel =
        Provider.of<OrderListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Orders', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<OrderListViewmodel>.value(
                value: orderListViewmodel,
                child: Consumer<OrderListViewmodel>(
                  builder: (context, value, _) {
                    switch (value.orderList.status!) {
                      case Status.LOADING:
                        return Center(child: CircularProgressIndicator());
                      case Status.ERROR:
                        return handleError(value);
                      case Status.COMPLETED:
                        allProductsWithOrderInfo.clear();
                        for (var order in value
                            .orderList.data!.customerOrderList!
                            .toList()) {
                          for (var product in order.products!.toList()) {
                            allProductsWithOrderInfo.add({
                              'product': product,
                              'orderDate': order.orderDate,
                              'orderStatus': order.orderStatus,
                              'netAmount': order.netAmount,
                              'orderedProductId': product.id
                            });
                          }
                        }
                        return _buildCompletedUI(context, value);
                    }
                  },
                ));
          }
        },
      ),
    );
  }

  Widget handleError(OrderListViewmodel value) {
    String? message;
    if (value.orderList.message != "No Internet Connection") {
      String jsonString = value.orderList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.orderList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.orderList.message.toString(),
          )
        : Text('data');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    OrderListViewmodel orderListViewmodel,
  ) {
    return ListView.builder(
      itemCount: allProductsWithOrderInfo.length,
      itemBuilder: (context, index) {
        var productInfo = allProductsWithOrderInfo[index];
        var product = productInfo['product'] as Products;
        var productDetail = product.productDetail;
        var variantDetail = product.variantDetail;

        return InkWell(
          onTap: () {
            print("productInfo['orderedProductId']");
            print(productInfo['orderedProductId']);
            print("productInfo['orderedProductId']");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsScreen(
                          orderedProductId:
                              productInfo['orderedProductId'].toString(),
                        )));
          },
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        productInfo['orderDate'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Text(
                      //       'Total',
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //     Text(
                      //       '₹ ${product.finalAmount}',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      Text(
                        'Order #${productInfo['orderNo']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Divider(),
                  Row(
                    children: [
                      Image.network(
                        convertLocalhost(
                            variantDetail!.variantImage.toString()),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productDetail!.productname.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('Qty : ${product.qty}'),
                          ],
                        ),
                      ),
                      Text(
                        '₹${productInfo['netAmount']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ship to',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(
                    'View order details',
                    style: TextStyle(color: Colors.green),
                  ),
                  if (productInfo['orderStatus'] == 'Confirm')
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
