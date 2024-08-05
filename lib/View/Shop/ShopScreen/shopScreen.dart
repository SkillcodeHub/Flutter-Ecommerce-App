import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Shop/ShopScreen/filterProductScreen.dart';
import 'package:ecommerce/View/Shop/ShopScreen/productDetailScreen.dart';
import 'package:ecommerce/View_Model/AllProductList_View_Model/allProductList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Model/AllProductList_Model/allProductList_model.dart';

class ShopScreen extends StatefulWidget {
  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Map<String, dynamic>> filteredProducts = [];
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
      final allProductListViewmodel =
          Provider.of<AllProductListViewmodel>(context, listen: false);
      allProductListViewmodel.fetchAllProductListApi(
          clientId.toString(), ipAddress.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProductListViewmodel =
        Provider.of<AllProductListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Light blue background
        elevation: 0, // No shadow
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FilterProductScreen()),
            );
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              enabled: false, // Disable the TextField
              decoration: InputDecoration(
                hintText: 'Search for products',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
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
            return ChangeNotifierProvider<AllProductListViewmodel>.value(
              value: allProductListViewmodel,
              child: Consumer<AllProductListViewmodel>(
                builder: (context, value, _) {
                  switch (value.allProductList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return handleError(value);
                    case Status.COMPLETED:
                      return buildCompletedUI(allProductListViewmodel, context);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget handleError(AllProductListViewmodel value) {
    String? message;
    if (value.allProductList.message != "No Internet Connection") {
      String jsonString = value.allProductList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.allProductList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.allProductList.message.toString(),
          )
        : Text('data');
  }

  Widget buildCompletedUI(
      AllProductListViewmodel allProductListViewmodel, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic here
      },
      child: Column(
        children: [
          Expanded(
            // Wrap GridView.builder with Expanded
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: allProductListViewmodel
                  .allProductList.data!.productList!.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: allProductListViewmodel
                      .allProductList.data!.productList![index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final ProductList product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    imageUrls = List<String>.from(
        json.decode(widget.product.productGallery.toString()));

    String convertLocalhost(String url) {
      return url.replaceAll('http://localhost', 'http://10.0.2.2');
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                    productId: widget.product.id.toString())));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    convertLocalhost(imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          size: 20,
                        ),
                        onPressed: () {
                          // Handle favorite button press
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ),
                  if (widget.product.discountedPercentage.toInt() > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.red,
                        child: Text(
                          '${widget.product.discountedPercentage}% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.productName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          size: 16,
                        ),
                        Text(
                          '${widget.product.saleStartsAt}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (widget.product.discountedPercentage.toInt() > 0)
                          Expanded(
                            child: Text(
                              ' (${widget.product.discountedPercentage}% off)',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < 3 ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           title: Text(
//             'Categories',
//             style:
//                 TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Icon(Icons.search, color: Colors.black),
//             ),
//           ],
//           bottom: TabBar(
//             labelColor: Colors.black,
//             indicatorColor: redFontColor,
//             tabs: [
//               Tab(text: 'Women'),
//               Tab(text: 'Men'),
//               Tab(text: 'Kids'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         color: Colors.red,
//                       ),
//                       height: 12.h,
//                       width: 100.w,
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'SUMMER SALES',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 0.5.h),
//                             Text(
//                               'Up to 50% off',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'New',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 4.1.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Clothes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Shoes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 2.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Accesories',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 3.png",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         color: Colors.red,
//                       ),
//                       height: 12.h,
//                       width: 100.w,
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'SUMMER SALES',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 0.5.h),
//                             Text(
//                               'Up to 50% off',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'New',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 4.1.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Clothes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Shoes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 2.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Accesories',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 3.png",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(15.0),
//                 child: Column(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8.0),
//                         color: Colors.red,
//                       ),
//                       height: 12.h,
//                       width: 100.w,
//                       padding: EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'SUMMER SALES',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             SizedBox(height: 0.5.h),
//                             Text(
//                               'Up to 50% off',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'New',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 4.1.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Clothes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Shoes',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 2.png",
//                     ),
//                     CustomListTile(
//                       containerContent: Padding(
//                         padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Accesories',
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       imageUrl: "images/c_image 3.png",
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomListTile extends StatelessWidget {
//   final String imageUrl;
//   final Widget containerContent;
//   final double height;
//   final double width;

//   CustomListTile({
//     required this.imageUrl,
//     required this.containerContent,
//     this.height = 95, // Default height
//     this.width = double.infinity, // Default width
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ProductListScreen()));
//       },
//       child: Container(
//         height: height,
//         width: width,
//         margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12.0), // Rounded border
//           // border: Border.all(color: Colors.grey), // Border color
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 height: double.infinity, // Full height
//                 width: double.infinity, // Full width of the left half
//                 child: containerContent, // Content for the left half
//               ),
//             ),
//             Expanded(
//               flex: 1,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(12.0),
//                   bottomRight: Radius.circular(12.0),
//                 ),
//                 child: Image.asset(
//                   imageUrl,
//                   height: double.infinity, // Full height
//                   width: double.infinity, // Full width of the right half
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
