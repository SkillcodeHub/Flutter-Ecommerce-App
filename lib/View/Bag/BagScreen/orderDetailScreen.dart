import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/orderdetailbyorderedproduct_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/productRatings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderedProductId;

  const OrderDetailsScreen({super.key, required this.orderedProductId});
  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
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
      final orderdetailbyorderedproductModel =
          Provider.of<OrderdetailbyorderedproductViewmodel>(context,
              listen: false);

      Map<String, String> data = {'orderedProductId': widget.orderedProductId};

      orderdetailbyorderedproductModel.fetchOrderdetailbyorderedproductApi(
          clientId, ipAddress, data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderdetailbyorderedproductModel =
        Provider.of<OrderdetailbyorderedproductViewmodel>(context,
            listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Order Details', style: TextStyle(color: Colors.black)),
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
            return ChangeNotifierProvider<
                    OrderdetailbyorderedproductViewmodel>.value(
                value: orderdetailbyorderedproductModel,
                child: Consumer<OrderdetailbyorderedproductViewmodel>(
                  builder: (context, value, _) {
                    switch (value.orderdetailbyorderedproduct.status!) {
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

  Widget handleError(OrderdetailbyorderedproductViewmodel value) {
    String? message;
    if (value.orderdetailbyorderedproduct.message != "No Internet Connection") {
      String jsonString = value.orderdetailbyorderedproduct.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.orderdetailbyorderedproduct.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.orderdetailbyorderedproduct.message.toString(),
          )
        : Text('data');
  }

  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost', 'http://10.0.2.2');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    OrderdetailbyorderedproductViewmodel orderdetailbyorderedproductViewmodel,
  ) {
    var orderdetailbyorderedproduct = orderdetailbyorderedproductViewmodel
        .orderdetailbyorderedproduct.data!.orderedProductList![0];

    print(
        "orderdetailbyorderedproduct.trackingStatusHistory![0].trackingStatus");
    print(orderdetailbyorderedproduct.trackingStatusHistory![0].trackingStatus
        .toString());
    print(
        "orderdetailbyorderedproduct.trackingStatusHistory![0].trackingStatus");
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub Order ID 304853776894_1',
                          style: TextStyle(fontSize: 16)),
                      Text('COPY',
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Payment Mode Cash on Delivery',
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.headset_mic, color: Colors.blue),
                SizedBox(width: 8),
                Text('Help Centre'),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('New', style: TextStyle(color: Colors.blue)),
                ),
                Icon(Icons.chevron_right),
              ],
            ),
          ),
          SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.network(
                          convertLocalhost(orderdetailbyorderedproductViewmodel
                              .orderdetailbyorderedproduct
                              .data!
                              .orderedProductList![0]
                              .productDetails!
                              .variantDetail!
                              .variantImage
                              .toString()),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                orderdetailbyorderedproductViewmodel
                                    .orderdetailbyorderedproduct
                                    .data!
                                    .orderedProductList![0]
                                    .productDetails!
                                    .productDetail!
                                    .productname
                                    .toString(),
                                style: TextStyle(fontSize: 16)),
                            SizedBox(height: 4),
                            Text('₹133 • All issue easy returns',
                                style: TextStyle(color: Colors.grey)),
                            Text('Size: Free Size',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('How was the product?'),
                  SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: List.generate(5,
                  //       (index) => Icon(Icons.star_border, color: Colors.grey)),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                        5,
                        (index) => GestureDetector(
                              onTap: () => _showRatingBottomSheet(context,
                                  orderdetailbyorderedproductViewmodel),
                              child:
                                  Icon(Icons.star_border, color: Colors.grey),
                            )),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Very Bad', style: TextStyle(color: Colors.grey)),
                      Text('Bad', style: TextStyle(color: Colors.grey)),
                      Text('Ok-Ok', style: TextStyle(color: Colors.grey)),
                      Text('Good', style: TextStyle(color: Colors.grey)),
                      Text('Very Good', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text('Order Tracking',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  if (orderdetailbyorderedproduct
                          .trackingStatusHistory![0].trackingStatus
                          .toString() ==
                      'confirm')
                    Column(
                      children: [
                        _buildOrderTrackingStep(
                          'Order Placed',
                          orderdetailbyorderedproduct
                              .trackingStatusHistory![0].updateStatusDate
                              .toString(),
                          true,
                        ),
                        _buildOrderTrackingStep('Dispatch', '', false),
                        _buildOrderTrackingStep('Arrive Today', '', false),
                        _buildOrderTrackingStep('Delivered', '', false,
                            isLast: true),
                      ],
                    ),
                  if (orderdetailbyorderedproduct
                          .trackingStatusHistory![0].trackingStatus
                          .toString() ==
                      'dispatch')
                    Column(
                      children: [
                        _buildOrderTrackingStep('Order Placed', '', true),
                        _buildOrderTrackingStep(
                          'Dispatch',
                          orderdetailbyorderedproduct
                              .trackingStatusHistory![0].updateStatusDate
                              .toString(),
                          true,
                        ),
                        _buildOrderTrackingStep('Arrive Today', '', false),
                        _buildOrderTrackingStep('Delivered', '', false,
                            isLast: true),
                      ],
                    ),
                  if (orderdetailbyorderedproduct
                          .trackingStatusHistory![0].trackingStatus
                          .toString() ==
                      'arrivalToday')
                    Column(
                      children: [
                        _buildOrderTrackingStep('Order Placed', '', true),
                        _buildOrderTrackingStep('Dispatch', '', true),
                        _buildOrderTrackingStep(
                          'Arrive Today',
                          orderdetailbyorderedproduct
                              .trackingStatusHistory![0].updateStatusDate
                              .toString(),
                          true,
                        ),
                        _buildOrderTrackingStep('Delivered', '', false,
                            isLast: true),
                      ],
                    ),
                  if (orderdetailbyorderedproduct
                          .trackingStatusHistory![0].trackingStatus
                          .toString() ==
                      'delivered')
                    Column(
                      children: [
                        _buildOrderTrackingStep('Order Placed', '', true),
                        _buildOrderTrackingStep('Dispatch', '', true),
                        _buildOrderTrackingStep('Arrive Today', '', true),
                        _buildOrderTrackingStep(
                            'Delivered',
                            orderdetailbyorderedproduct
                                .trackingStatusHistory![0].updateStatusDate
                                .toString(),
                            true,
                            isLast: true),
                      ],
                    ),
                  SizedBox(height: 16),
                  Text('SHOW MORE ▼',
                      style: TextStyle(
                          color: Colors.purple, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.open_in_new),
                          label: Text('Open Tracking Link'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, onPrimary: Colors.black),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                          label: Text('Share'),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, onPrimary: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 16),
          _buildDetailRow(
            title: 'Return / Exchange Order',
            value: 'Not available',
            onTap: () {
              showReturnExchangeBottomSheet(context);
            },
          ),
          _buildDetailRow(
            title: 'Download Invoice',
            value: '',
            onTap: () {
              // showReturnExchangeBottomSheet(context);
            },
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text('Order Details',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text('Price Details (1 Item)'),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Price'),
                      Text(orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .finalAmount
                          .toString()),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order Total',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          orderdetailbyorderedproductViewmodel
                              .orderdetailbyorderedproduct
                              .data!
                              .orderedProductList![0]
                              .finalAmount
                              .toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // SizedBox(height: 1.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Delivery Address',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text(orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .shippingAddress![0]
                          .customerAddress
                          .toString() +
                      ', ' +
                      orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .shippingAddress![0]
                          .customerCity
                          .toString() +
                      ', ' +
                      orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .shippingAddress![0]
                          .customerState
                          .toString() +
                      ', ' +
                      orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .shippingAddress![0]
                          .customerCountry
                          .toString() +
                      ', ' +
                      orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .shippingAddress![0]
                          .customerPincode
                          .toString()),
                ],
              ),
            ),
          ),
          // SizedBox(height: 1.h),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Supplier',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('SH NASIMA MNUFACTURER'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRatingBottomSheet(
    BuildContext context,
    OrderdetailbyorderedproductViewmodel orderdetailbyorderedproductViewmodel,
  ) {
    int rating = 0;
    TextEditingController description = TextEditingController();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        orderdetailbyorderedproductViewmodel
                            .orderdetailbyorderedproduct
                            .data!
                            .orderedProductList![0]
                            .clientDetails!
                            .companyName!
                            .toString(),
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(orderdetailbyorderedproductViewmodel
                        .orderdetailbyorderedproduct
                        .data!
                        .orderedProductList![0]
                        .productDetails!
                        .productDetail!
                        .productname
                        .toString()),
                    Image.network(
                      convertLocalhost(orderdetailbyorderedproductViewmodel
                          .orderdetailbyorderedproduct
                          .data!
                          .orderedProductList![0]
                          .productDetails!
                          .variantDetail!
                          .variantImage
                          .toString()),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              rating = index + 1;
                            });
                            print('Current rating: $rating');
                          },
                          child: Icon(
                            index < rating ? Icons.star : Icons.star_border,
                            color: Colors.yellow,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: TextFormField(
                        controller: description,
                        keyboardType: TextInputType.text,
                        maxLines: 12,
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter a Description',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Skip'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('Final rating: $rating');

                              Map<String, String> data = {
                                'clientId': clientId,
                                'customerId':
                                    orderdetailbyorderedproductViewmodel
                                        .orderdetailbyorderedproduct
                                        .data!
                                        .orderedProductList![0]
                                        .customerDetails!
                                        .id
                                        .toString(),
                                'productId':
                                    orderdetailbyorderedproductViewmodel
                                        .orderdetailbyorderedproduct
                                        .data!
                                        .orderedProductList![0]
                                        .productDetails!
                                        .productDetail!
                                        .id
                                        .toString(),
                                'starRating': rating.toString(),
                                'reviewComment': description.text,
                                'ratingDate': formattedDate,
                                'created_by':
                                    orderdetailbyorderedproductViewmodel
                                        .orderdetailbyorderedproduct
                                        .data!
                                        .orderedProductList![0]
                                        .customerDetails!
                                        .customerName!
                                        .toString(),
                              };

                              final addProductRatingsViewModel =
                                  Provider.of<AddProductRatingsViewModel>(
                                      context,
                                      listen: false);

                              addProductRatingsViewModel.addProductRatingsApi(
                                  ipAddress, data, context);
                            },
                            child: Text('Submit'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOrderTrackingStep(
      String title, String? subtitle, bool isCompleted,
      {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Colors.green : Colors.grey.shade300,
              ),
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: isCompleted ? Colors.green : Colors.grey.shade300,
              ),
          ],
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle.toString(), style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  void showReturnExchangeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Return / Exchange not available',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Sorry! You cannot return or exchange this item as it was delivered more than 7 days ago. In case of any concerns, please reach out to us from the \'Help\' section on the app.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('OK'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow({
    required String title,
    required String value,
    VoidCallback? onTap, // Add this parameter
  }) {
    return InkWell(
      // Wrap the Container with InkWell
      onTap: onTap, // Set the onTap callback
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Row(
              children: [
                Text(value, style: TextStyle(color: Colors.grey)),
                SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
