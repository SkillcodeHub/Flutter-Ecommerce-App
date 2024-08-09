import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/SharePreferences/sharePreference.dart';
import 'package:ecommerce/View_Model/FeaturedProductList_View_Model/featuredProductList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Data/Response/status.dart';
import '../../Shop/ShopScreen/productDetailScreen.dart';

// class HomeScreen extends StatefulWidget {
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   UserPreferences userPreference = UserPreferences();
//   String clientId = ClientId;
//   String ipAddress = IpAddress;

//   String? token;
//   dynamic UserData;

//   late Future<void> fetchDataFuture;

//   @override
//   void initState() {
//     super.initState();
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//         print('Token : $token');
//       });
//     });
//     fetchDataFuture = fetchData();
//   }

//   Future<void> fetchData() async {
//     Timer(Duration(microseconds: 20), () {
//       final featuredProductListViewmodel =
//           Provider.of<FeaturedProductListViewmodel>(context, listen: false);
//       featuredProductListViewmodel.fetchFeaturedProductListApi(
//           clientId.toString(), ipAddress.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final featuredProductListViewmodel =
//         Provider.of<FeaturedProductListViewmodel>(context, listen: false);

//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<FeaturedProductListViewmodel>.value(
//               value: featuredProductListViewmodel,
//               child: Consumer<FeaturedProductListViewmodel>(
//                 builder: (context, value, _) {
//                   switch (value.featuredProductList.status!) {
//                     case Status.LOADING:
//                       return Center(child: CircularProgressIndicator());
//                     case Status.ERROR:
//                       return handleError(value);
//                     case Status.COMPLETED:
//                       return buildCompletedUI(context);
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget handleError(FeaturedProductListViewmodel value) {
//     String? message;
//     if (value.featuredProductList.message != "No Internet Connection") {
//       String jsonString = value.featuredProductList.message.toString();
//       int startIndex = jsonString.indexOf('{');
//       int endIndex = jsonString.lastIndexOf('}');
//       String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
//       Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
//       message = jsonResponse['message'];
//     }
//     return value.featuredProductList.message == "No Internet Connection"
//         ? ErrorScreenWidget(
//             onRefresh: () async {},
//             loadingText: value.featuredProductList.message.toString(),
//           )
//         : Text('data');
//   }

//   Widget buildCompletedUI(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           buildBannerSection(context),
//           buildNewProductsSection(context),
//           buildSaleSection(context),
//           buildTopRatedSection(context),
//         ],
//       ),
//     );
//   }

//   Widget buildBannerSection(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height * 0.65,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('images/Big Banner.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Positioned(
//           bottom: 16.0,
//           left: 16.0,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Fashion',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30.sp,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               Text(
//                 'sale',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30.sp,
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               SizedBox(height: 8.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //         builder: (context) => CheckButtonScreen()));
//                 },
//                 child: Text('Check', style: TextStyle(fontSize: 14.sp)),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30)),
//                   primary: Colors.red,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 45.0,
//                     vertical: 12.0,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildNewProductsSection(BuildContext context) {
//     final featuredProductListViewmodel =
//         Provider.of<FeaturedProductListViewmodel>(context, listen: false);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: 16.0),
//         Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'New',
//                     style: TextStyle(
//                       fontSize: 19.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "You've never seen it before!",
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimaryLightColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Text('View all')
//             ],
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Container(
//           height: 37.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: featuredProductListViewmodel
//                 .featuredProductList.data!.featuredProductList!.length,
//             itemBuilder: (context, index) {
//               String imageUrl = index % 2 == 0
//                   ? 'images/Product card_new.png'
//                   : 'images/Product card_new_2.png';
//               return SmallImageCard(
//                 productId: featuredProductListViewmodel
//                     .featuredProductList.data!.featuredProductList![index].id
//                     .toString(),
//                 imageUrl: featuredProductListViewmodel.featuredProductList.data!
//                     .featuredProductList![index].productGallery
//                     .toString(),
//                 productName: featuredProductListViewmodel.featuredProductList
//                     .data!.featuredProductList![index].productName
//                     .toString(),
//                 minSalePrice: featuredProductListViewmodel.featuredProductList
//                     .data!.featuredProductList![index].minSalePrice
//                     .toString(),
//                 saleStartsAt: featuredProductListViewmodel.featuredProductList
//                     .data!.featuredProductList![index].saleStartsAt
//                     .toString(),
//                 discountedPercentage: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .featuredProductList![index]
//                     .discountedPercentage
//                     .toString(),
//                 averageRating: featuredProductListViewmodel
//                             .featuredProductList
//                             .data!
//                             .featuredProductList![index]
//                             .averageRatingsDetails!
//                             .length >
//                         0
//                     ? featuredProductListViewmodel
//                         .featuredProductList
//                         .data!
//                         .featuredProductList![index]
//                         .averageRatingsDetails![0]
//                         .averageRating
//                         .toString()
//                     : null,
//                 companyName: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .featuredProductList![index]
//                     .clientDetails!
//                     .companyName
//                     .toString(),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget buildSaleSection(BuildContext context) {
//     final featuredProductListViewmodel =
//         Provider.of<FeaturedProductListViewmodel>(context, listen: false);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // SizedBox(height: 16.0),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Top Selling Product',
//                     style: TextStyle(
//                       fontSize: 19.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "Super summer sale",
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimaryLightColor,
//                     ),
//                   ),
//                 ],
//               ),
//               Text('View all')
//             ],
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Container(
//           height: 37.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: featuredProductListViewmodel
//                 .featuredProductList.data!.topSellingProductList!.length,
//             itemBuilder: (context, index) {
//               String imageUrl = index % 2 == 0
//                   ? 'images/Product card_new.png'
//                   : 'images/Product card_new_2.png';
//               return SmallImageCard(
//                 productId: featuredProductListViewmodel
//                     .featuredProductList.data!.topSellingProductList![index].id
//                     .toString(),
//                 imageUrl: featuredProductListViewmodel.featuredProductList.data!
//                     .topSellingProductList![index].productGallery
//                     .toString(),
//                 productName: featuredProductListViewmodel.featuredProductList
//                     .data!.topSellingProductList![index].productName
//                     .toString(),
//                 minSalePrice: featuredProductListViewmodel.featuredProductList
//                     .data!.topSellingProductList![index].minSalePrice
//                     .toString(),
//                 saleStartsAt: featuredProductListViewmodel.featuredProductList
//                     .data!.topSellingProductList![index].saleStartsAt
//                     .toString(),
//                 discountedPercentage: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .topSellingProductList![index]
//                     .discountedPercentage
//                     .toString(),
//                 averageRating: featuredProductListViewmodel
//                             .featuredProductList
//                             .data!
//                             .topSellingProductList![index]
//                             .averageRatingsDetails!
//                             .length >
//                         0
//                     ? featuredProductListViewmodel
//                         .featuredProductList
//                         .data!
//                         .topSellingProductList![index]
//                         .averageRatingsDetails![0]
//                         .averageRating
//                         .toString()
//                     : null,
//                 companyName: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .topSellingProductList![index]
//                     .clientDetails!
//                     .companyName
//                     .toString(),
//               );
//             },
//           ),
//         ),
//         // SizedBox(height: 16.0),
//       ],
//     );
//   }

//   Widget buildTopRatedSection(BuildContext context) {
//     final featuredProductListViewmodel =
//         Provider.of<FeaturedProductListViewmodel>(context, listen: false);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // SizedBox(height: 16.0),
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Top Rated Product',
//                     style: TextStyle(
//                       fontSize: 19.sp,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     "Super summer sale",
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.bold,
//                       color: textPrimaryLightColor,
//                     ),
//                   ),
//                 ],
//               ),
//               // Text('View all')
//             ],
//           ),
//         ),
//         SizedBox(height: 8.0),
//         Container(
//           height: 37.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: featuredProductListViewmodel
//                 .featuredProductList.data!.topRatedProductList!.length,
//             itemBuilder: (context, index) {
//               // String imageUrl = index % 2 == 0
//               //     ? 'images/Product card_new.png'
//               //     : 'images/Product card_new_2.png';
//               return SmallImageCard(
//                 productId: featuredProductListViewmodel
//                     .featuredProductList.data!.topRatedProductList![index].id
//                     .toString(),
//                 imageUrl: featuredProductListViewmodel.featuredProductList.data!
//                     .topRatedProductList![index].productGallery
//                     .toString(),
//                 productName: featuredProductListViewmodel.featuredProductList
//                     .data!.topRatedProductList![index].productName
//                     .toString(),
//                 minSalePrice: featuredProductListViewmodel.featuredProductList
//                     .data!.topRatedProductList![index].minSalePrice
//                     .toString(),
//                 saleStartsAt: featuredProductListViewmodel.featuredProductList
//                     .data!.topRatedProductList![index].saleStartsAt
//                     .toString(),
//                 discountedPercentage: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .topRatedProductList![index]
//                     .discountedPercentage
//                     .toString(),
//                 averageRating: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .topRatedProductList![index]
//                     .averageRatingsDetails![0]
//                     .averageRating
//                     .toString(),
//                 companyName: featuredProductListViewmodel
//                     .featuredProductList
//                     .data!
//                     .topRatedProductList![index]
//                     .clientDetails!
//                     .companyName
//                     .toString(),
//               );
//             },
//           ),
//         ),
//         // SizedBox(height: 16.0),
//       ],
//     );
//   }
// }

// class SmallImageCard extends StatefulWidget {
//   final String productId;
//   final String imageUrl;
//   final String? text;
//   final String productName;
//   final String minSalePrice;
//   final String saleStartsAt;
//   final String discountedPercentage;
//   String? averageRating;
//   final String companyName;

//   SmallImageCard({
//     required this.productId,
//     required this.imageUrl,
//     this.text,
//     required this.productName,
//     required this.minSalePrice,
//     required this.saleStartsAt,
//     required this.discountedPercentage,
//     this.averageRating,
//     required this.companyName,
//   });

//   @override
//   State<SmallImageCard> createState() => _SmallImageCardState();
// }

// class _SmallImageCardState extends State<SmallImageCard> {
//   List<String> imageUrls = [];

//   List<Widget> renderStars(double rating) {
//     int fullStars = rating.floor();
//     bool hasHalfStar = rating % 1 != 0;
//     int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
//     List<Widget> stars = [];
//     // Adding full stars
//     for (int i = 0; i < fullStars; i++) {
//       stars.add(Icon(
//         Icons.star,
//         color: Colors.yellow,
//         size: 16,
//       ));
//     }
//     // Adding half star if present
//     if (hasHalfStar) {
//       stars.add(Icon(
//         Icons.star_half,
//         color: Colors.yellow,
//         size: 16,
//       ));
//     }
//     // Adding empty stars
//     for (int i = 0; i < emptyStars; i++) {
//       stars.add(Icon(
//         // Icons.star,
//         Icons.star_border,
//         color: Colors.yellow,
//         // color: Colors.grey.shade300,
//         size: 16,
//       ));
//     }
//     return stars;
//   }

//   @override
//   Widget build(BuildContext context) {
//     imageUrls = List<String>.from(json.decode(widget.imageUrl));
//     print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
//     print(imageUrls[0]);
//     print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
//     String convertLocalhost(String url) {
//       return url.replaceAll('http://localhost', 'http://10.0.2.2');
//     }

//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ProductDetailScreen(productId: widget.productId)));
//       },
//       child: Container(
//         // color: Colors.amber,
//         width: 40.w,
//         height: 40.h,
//         margin: EdgeInsets.all(8.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Stack(
//                 children: [
//                   Image.network(
//                     convertLocalhost(imageUrls[0])
//                     // 'http://10.0.2.2:8000/media/media/processed_71JAtYR3tLL._SY741_.jpg',
//                     ,
//                     // widget.imageUrl,
//                     height: 24.h,
//                     fit: BoxFit.cover,
//                   ),

//                   // if (text != null) // Check if text is not null
//                   // Positioned(
//                   //   top: 8.0, // Adjust the position as needed
//                   //   left: 8.0,
//                   //   child: Container(
//                   //     padding: EdgeInsets.all(4),
//                   //     decoration: BoxDecoration(
//                   //       borderRadius: BorderRadius.circular(8),
//                   //       color: Colors.black,
//                   //     ),
//                   //     child: Text(
//                   //       // text!,
//                   //       "New",
//                   //       style: TextStyle(
//                   //         color: Colors.white, // Adjust the text color as needed
//                   //         fontWeight: FontWeight.bold,
//                   //       ),
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//             Text(widget.companyName,
//                 style:
//                     TextStyle(color: textPrimaryLightColor, fontSize: 11.sp)),
//             SizedBox(height: 0.2.h),
//             Container(
//               child: Text(
//                 widget.productName,
//                 style: TextStyle(
//                     color: darkBlackFontColor,
//                     fontSize: 10.sp,
//                     fontWeight: FontWeight.bold),
//                 overflow: TextOverflow.visible,
//                 maxLines: 2,
//               ),
//             ),
//             SizedBox(height: 0.3.h),
//             Row(
//               children: [
//                 Icon(
//                   Icons.currency_rupee_sharp,
//                   size: 2.h,
//                 ),
//                 Text(widget.minSalePrice,
//                     style: TextStyle(
//                         color: redFontColor, fontWeight: FontWeight.bold)),
//                 if (widget.discountedPercentage.toInt() > 0)
//                   Text(
//                     ' (${widget.discountedPercentage}% off)',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontSize: 12,
//                     ),
//                   ),
//               ],
//             ),
//             Row(
//               children: renderStars(
//                   widget.averageRating.toDouble()), // Example rating
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//--------------------------------------------------------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'dart:convert';
// import 'dart:async';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserPreferences userPreference = UserPreferences();
  String clientId = ClientId;
  String ipAddress = IpAddress;

  String? token;
  dynamic UserData;

  late Future<void> fetchDataFuture;

  @override
  void initState() {
    super.initState();
    userPreference.getToken().then((value) {
      setState(() {
        token = value!;
        print('Token : $token');
      });
    });
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final featuredProductListViewmodel =
          Provider.of<FeaturedProductListViewmodel>(context, listen: false);
      featuredProductListViewmodel.fetchFeaturedProductListApi(
          clientId.toString(), ipAddress.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('ShopEase', style: TextStyle(fontWeight: FontWeight.bold)),
      //   actions: [
      //     IconButton(icon: Icon(Icons.search), onPressed: () {}),
      //     IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
      //   ],
      // ),

      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<FeaturedProductListViewmodel>.value(
              value: featuredProductListViewmodel,
              child: Consumer<FeaturedProductListViewmodel>(
                builder: (context, value, _) {
                  switch (value.featuredProductList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return handleError(value);
                    case Status.COMPLETED:
                      return buildCompletedUI(context);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget handleError(FeaturedProductListViewmodel value) {
    String? message;
    if (value.featuredProductList.message != "No Internet Connection") {
      String jsonString = value.featuredProductList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.featuredProductList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.featuredProductList.message.toString(),
          )
        : Text('data');
  }

  Widget buildCompletedUI(BuildContext context) {
    DateTime saleEndTime =
        DateTime.now().add(Duration(hours: 2, minutes: 15, seconds: 25));

    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic here
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 1.h),
            buildBannerSection(context),
            buildCategoriesSection(context),
            SizedBox(height: 1.h),
            LimitedTimeDealsBar(endTime: saleEndTime),
            buildFeaturedProductsGrid(context),
            buildNewProductsSection(context),
            SizedBox(height: 2.h),
            buildCarouselBanner(context),
            SizedBox(height: 2.h),
            buildSaleSection(context),
            buildTopRatedSection(context),
            // buildBrandsSection(context),
          ],
        ),
      ),
    );
  }

  Widget buildFeaturedProductsGrid(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Featured Products',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio:
                0.6, // Adjust this value to change the card height
            children: [
              ProductCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.featuredProductList![0].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![0].productGallery
                    .toString(),
                name: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![0].productName
                    .toString(),
                price: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![0].minSalePrice
                    .toString(),
                label: 'Clearance',
                buttonText: 'Shop Now',
              ),
              ProductCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.topRatedProductList![0].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .topRatedProductList![0].productGallery
                    .toString(),
                name: featuredProductListViewmodel.featuredProductList.data!
                    .topRatedProductList![0].productName
                    .toString(),
                price: featuredProductListViewmodel.featuredProductList.data!
                    .topRatedProductList![0].minSalePrice
                    .toString(),
                label: 'On Sale',
                buttonText: 'Shop Now',
              ),
              ProductCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.topSellingProductList![0].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .topSellingProductList![0].productGallery
                    .toString(),
                name: featuredProductListViewmodel.featuredProductList.data!
                    .topSellingProductList![0].productName
                    .toString(),
                price: featuredProductListViewmodel.featuredProductList.data!
                    .topSellingProductList![0].minSalePrice
                    .toString(),
                label: 'New Arrivals',
                buttonText: 'Shop Now',
              ),
              ProductCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.featuredProductList![1].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![1].productGallery
                    .toString(),
                name: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![1].productName
                    .toString(),
                price: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![1].minSalePrice
                    .toString(),
                label: 'On Sale',
                buttonText: 'Shop Now',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildBannerSection(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/Big Banner.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          left: 16.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fashion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'sale',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CheckButtonScreen()));
                },
                child: Text('Check', style: TextStyle(fontSize: 14.sp)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  primary: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 45.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCarouselBanner(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    List<String> bannerImages = [
      'images/images-1.jpeg',
      'images/images-2.jpeg',
      'images/images-3.jpeg',
      'images/images-4.jpg',
      'images/images-5.jpg',
    ];

    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        // enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.99,
      ),
      items: bannerImages.map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget buildNewProductsSection(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "You've never seen it before!",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryLightColor,
                    ),
                  ),
                ],
              ),
              Text('View all')
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 37.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredProductListViewmodel
                .featuredProductList.data!.featuredProductList!.length,
            itemBuilder: (context, index) {
              String imageUrl = index % 2 == 0
                  ? 'images/Product card_new.png'
                  : 'images/Product card_new_2.png';
              return SmallImageCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.featuredProductList![index].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .featuredProductList![index].productGallery
                    .toString(),
                productName: featuredProductListViewmodel.featuredProductList
                    .data!.featuredProductList![index].productName
                    .toString(),
                minSalePrice: featuredProductListViewmodel.featuredProductList
                    .data!.featuredProductList![index].minSalePrice
                    .toString(),
                saleStartsAt: featuredProductListViewmodel.featuredProductList
                    .data!.featuredProductList![index].saleStartsAt
                    .toString(),
                discountedPercentage: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .featuredProductList![index]
                    .discountedPercentage
                    .toString(),
                averageRating: featuredProductListViewmodel
                            .featuredProductList
                            .data!
                            .featuredProductList![index]
                            .averageRatingsDetails!
                            .length >
                        0
                    ? featuredProductListViewmodel
                        .featuredProductList
                        .data!
                        .featuredProductList![index]
                        .averageRatingsDetails![0]
                        .averageRating
                        .toString()
                    : null,
                companyName: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .featuredProductList![index]
                    .clientDetails!
                    .companyName
                    .toString(),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildSaleSection(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Selling Product',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Super summer sale",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryLightColor,
                    ),
                  ),
                ],
              ),
              Text('View all')
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 37.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredProductListViewmodel
                .featuredProductList.data!.topSellingProductList!.length,
            itemBuilder: (context, index) {
              String imageUrl = index % 2 == 0
                  ? 'images/Product card_new.png'
                  : 'images/Product card_new_2.png';
              return SmallImageCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.topSellingProductList![index].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .topSellingProductList![index].productGallery
                    .toString(),
                productName: featuredProductListViewmodel.featuredProductList
                    .data!.topSellingProductList![index].productName
                    .toString(),
                minSalePrice: featuredProductListViewmodel.featuredProductList
                    .data!.topSellingProductList![index].minSalePrice
                    .toString(),
                saleStartsAt: featuredProductListViewmodel.featuredProductList
                    .data!.topSellingProductList![index].saleStartsAt
                    .toString(),
                discountedPercentage: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .topSellingProductList![index]
                    .discountedPercentage
                    .toString(),
                averageRating: featuredProductListViewmodel
                            .featuredProductList
                            .data!
                            .topSellingProductList![index]
                            .averageRatingsDetails!
                            .length >
                        0
                    ? featuredProductListViewmodel
                        .featuredProductList
                        .data!
                        .topSellingProductList![index]
                        .averageRatingsDetails![0]
                        .averageRating
                        .toString()
                    : null,
                companyName: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .topSellingProductList![index]
                    .clientDetails!
                    .companyName
                    .toString(),
              );
            },
          ),
        ),
        // SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildTopRatedSection(BuildContext context) {
    final featuredProductListViewmodel =
        Provider.of<FeaturedProductListViewmodel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 16.0),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Top Rated Product',
                    style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Super summer sale",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: textPrimaryLightColor,
                    ),
                  ),
                ],
              ),
              // Text('View all')
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 37.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: featuredProductListViewmodel
                .featuredProductList.data!.topRatedProductList!.length,
            itemBuilder: (context, index) {
              // String imageUrl = index % 2 == 0
              //     ? 'images/Product card_new.png'
              //     : 'images/Product card_new_2.png';
              return SmallImageCard(
                productId: featuredProductListViewmodel
                    .featuredProductList.data!.topRatedProductList![index].id
                    .toString(),
                imageUrl: featuredProductListViewmodel.featuredProductList.data!
                    .topRatedProductList![index].productGallery
                    .toString(),
                productName: featuredProductListViewmodel.featuredProductList
                    .data!.topRatedProductList![index].productName
                    .toString(),
                minSalePrice: featuredProductListViewmodel.featuredProductList
                    .data!.topRatedProductList![index].minSalePrice
                    .toString(),
                saleStartsAt: featuredProductListViewmodel.featuredProductList
                    .data!.topRatedProductList![index].saleStartsAt
                    .toString(),
                discountedPercentage: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .topRatedProductList![index]
                    .discountedPercentage
                    .toString(),
                averageRating: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .topRatedProductList![index]
                    .averageRatingsDetails![0]
                    .averageRating
                    .toString(),
                companyName: featuredProductListViewmodel
                    .featuredProductList
                    .data!
                    .topRatedProductList![index]
                    .clientDetails!
                    .companyName
                    .toString(),
              );
            },
          ),
        ),
        // SizedBox(height: 16.0),
      ],
    );
  }

  Widget buildCategoriesSection(BuildContext context) {
    List<Map<String, String>> categories = [
      {'icon': 'Icons.phone_android', 'name': 'Electronics'},
      {'icon': 'Icons.shopping_bag', 'name': 'Fashion'},
      {'icon': 'Icons.home', 'name': 'Home'},
      {'icon': 'Icons.sports_soccer', 'name': 'Sports'},
      {'icon': 'Icons.book', 'name': 'Books'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Container(
                width: 80,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.category, size: 30),
                    ),
                    SizedBox(height: 8),
                    Text(categories[index]['name']!,
                        textAlign: TextAlign.center),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ... (keep other sections like buildNewProductsSection, buildSaleSection, buildTopRatedSection)

  Widget buildBrandsSection(BuildContext context) {
    List<String> brands = ['Nike', 'Adidas', 'Puma', 'Reebok', 'Under Armour'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Popular Brands',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: brands.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(child: Text(brands[index])),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ... (keep the SmallImageCard class as it is)
class ProductCard extends StatefulWidget {
  final String productId;

  final String imageUrl;
  final String name;
  final String price;
  final String label;
  final String buttonText;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productId,
    required this.name,
    required this.price,
    required this.label,
    required this.buttonText,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  List<String> imageUrls = [];

  Widget build(BuildContext context) {
    imageUrls = List<String>.from(json.decode(widget.imageUrl));
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    print(imageUrls[0]);
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    String convertLocalhost(String url) {
      return url.replaceAll('http://localhost:8000', ngrokUrl);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(productId: widget.productId)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(widget.label),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4, // Increase this value to make the image taller

              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  convertLocalhost(
                    imageUrls[0]
                    // 'https://5d70-2402-a00-142-4b45-214d-52ed-f094-95a5.ngrok-free.app/media/media/MANGO%20LOGO%20VECTOR_cHJiyMF.jpeg'
                  )


                  // 'http://10.0.2.2:8000/media/media/processed_71JAtYR3tLL._SY741_.jpg',
                  ,
                  // widget.imageUrl,
                  // height: 24.h,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   widget.label,
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     color: _getLabelColor(widget.label),
                  //     fontSize: 12,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'from \u20B9 ${widget.price.toString()}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                  productId: widget.productId)));
                    },
                    child:
                        Text(widget.buttonText, style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: Size(100, 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getBackgroundColor(String label) {
    switch (label.toLowerCase()) {
      case 'clearance':
        return Colors.grey[100]!;
      case 'on sale':
        return Colors.grey[300]!;
      case 'new arrivals':
        return Colors.green[50]!;
      default:
        return Colors.white;
    }
  }

  Color _getLabelColor(String label) {
    switch (label.toLowerCase()) {
      case 'clearance':
        return Colors.black;
      case 'on sale':
        return Colors.black87;
      case 'new arrivals':
        return Colors.green[700]!;
      default:
        return Colors.black;
    }
  }
}

class LimitedTimeDealsBar extends StatefulWidget {
  final DateTime endTime;
  LimitedTimeDealsBar({required this.endTime});

  @override
  _LimitedTimeDealsBarState createState() => _LimitedTimeDealsBarState();
}

class _LimitedTimeDealsBarState extends State<LimitedTimeDealsBar> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.endTime.difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.endTime.difference(DateTime.now());
        if (_remainingTime.inSeconds <= 0) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Text(
            'Limited Time Deals',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          color: Color(0xFFFFF3E0), // Light orange background
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ends In',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 10),
              _buildTimeUnit(
                  _remainingTime.inHours.toString().padLeft(2, '0'), 'h'),
              SizedBox(width: 5),
              _buildTimeUnit(
                  (_remainingTime.inMinutes % 60).toString().padLeft(2, '0'),
                  'm'),
              SizedBox(width: 5),
              _buildTimeUnit(
                  (_remainingTime.inSeconds % 60).toString().padLeft(2, '0'),
                  's'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeUnit(String value, String unit) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            TextSpan(
              text: ' $unit',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class SaleCountdownBanner extends StatefulWidget {
//   final DateTime endTime;
//   SaleCountdownBanner({required this.endTime});

//   @override
//   _SaleCountdownBannerState createState() => _SaleCountdownBannerState();
// }

// class _SaleCountdownBannerState extends State<SaleCountdownBanner> {
//   late Timer _timer;
//   late Duration _remainingTime;

//   @override
//   void initState() {
//     super.initState();
//     _remainingTime = widget.endTime.difference(DateTime.now());
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _remainingTime = widget.endTime.difference(DateTime.now());
//         if (_remainingTime.inSeconds <= 0) {
//           _timer.cancel();
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//       decoration: BoxDecoration(
//         color: Color(0xFF8BC34A), // Light green background
//         // color: appPrimaryColor // Light green background
//       ),
//       child: Column(
//         children: [
//           Text(
//             'Limited Time Deals',
//             // 'End of Season Clearance',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 24,
//             ),
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Sale upto 30%',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//             ),
//           ),
//           SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               _buildTimeBox(_remainingTime.inDays.toString(), 'Days'),
//               SizedBox(width: 12),
//               _buildTimeBox((_remainingTime.inHours % 24).toString(), 'Hours'),
//               SizedBox(width: 12),
//               _buildTimeBox(
//                   (_remainingTime.inMinutes % 60).toString(), 'Minutes'),
//               SizedBox(width: 12),
//               _buildTimeBox(
//                   (_remainingTime.inSeconds % 60).toString(), 'Seconds'),
//             ],
//           ),
//           SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               // Add shop now functionality
//             },
//             child: Text('Shop Now'),
//             style: ElevatedButton.styleFrom(
//               primary: Colors.white,
//               onPrimary: Color(0xFF8BC34A),
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimeBox(String value, String label) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: Text(
//             value,
//             style: TextStyle(
//               color: Color(0xFF8BC34A),
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 12,
//           ),
//         ),
//       ],
//     );
//   }
// }

class SmallImageCard extends StatefulWidget {
  final String productId;
  final String imageUrl;
  final String? text;
  final String productName;
  final String minSalePrice;
  final String saleStartsAt;
  final String discountedPercentage;
  String? averageRating;
  final String companyName;

  SmallImageCard({
    required this.productId,
    required this.imageUrl,
    this.text,
    required this.productName,
    required this.minSalePrice,
    required this.saleStartsAt,
    required this.discountedPercentage,
    this.averageRating,
    required this.companyName,
  });

  @override
  State<SmallImageCard> createState() => _SmallImageCardState();
}

class _SmallImageCardState extends State<SmallImageCard> {
  List<String> imageUrls = [];

  List<Widget> renderStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating % 1 != 0;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    List<Widget> stars = [];
    // Adding full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: 16,
      ));
    }
    // Adding half star if present
    if (hasHalfStar) {
      stars.add(Icon(
        Icons.star_half,
        color: Colors.yellow,
        size: 16,
      ));
    }
    // Adding empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(
        // Icons.star,
        Icons.star_border,
        color: Colors.yellow,
        // color: Colors.grey.shade300,
        size: 16,
      ));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    imageUrls = List<String>.from(json.decode(widget.imageUrl));
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    print(imageUrls[0]);
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    String convertLocalhost(String url) {
      return url.replaceAll('http://localhost:8000', ngrokUrl);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProductDetailScreen(productId: widget.productId)));
      },
      child: Container(
        // color: Colors.amber,
        width: 40.w,
        height: 40.h,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: [
                  Image.network(
                    convertLocalhost(imageUrls[0])
                    // 'http://10.0.2.2:8000/media/media/processed_71JAtYR3tLL._SY741_.jpg',
                    ,
                    // widget.imageUrl,
                    height: 24.h,
                    fit: BoxFit.cover,
                  ),

                  // if (text != null) // Check if text is not null
                  // Positioned(
                  //   top: 8.0, // Adjust the position as needed
                  //   left: 8.0,
                  //   child: Container(
                  //     padding: EdgeInsets.all(4),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: Colors.black,
                  //     ),
                  //     child: Text(
                  //       // text!,
                  //       "New",
                  //       style: TextStyle(
                  //         color: Colors.white, // Adjust the text color as needed
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Text(widget.companyName,
                style:
                    TextStyle(color: textPrimaryLightColor, fontSize: 11.sp)),
            SizedBox(height: 0.2.h),
            Container(
              child: Text(
                widget.productName,
                style: TextStyle(
                    color: darkBlackFontColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
                maxLines: 2,
              ),
            ),
            SizedBox(height: 0.3.h),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee_sharp,
                  size: 2.h,
                ),
                Text(widget.minSalePrice,
                    style: TextStyle(
                        color: redFontColor, fontWeight: FontWeight.bold)),
                if (widget.discountedPercentage.toInt() > 0)
                  Text(
                    ' (${widget.discountedPercentage}% off)',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
            Row(
              children: renderStars(
                  widget.averageRating.toDouble()), // Example rating
            ),
          ],
        ),
      ),
    );
  }
}


























// class SaleImageCard extends StatelessWidget {
//   final String imageUrl;
//   final String? text;
//   final String productName;
//   final String minSalePrice;
//   final String saleStartsAt;

//   SaleImageCard({
//     required this.imageUrl,
//     this.text,
//     required this.productName,
//     required this.minSalePrice,
//     required this.saleStartsAt,
//   });
//   List<Widget> renderStars(double rating) {
//     int fullStars = rating.floor();
//     bool hasHalfStar = rating % 1 != 0;
//     int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
//     List<Widget> stars = [];
//     // Adding full stars
//     for (int i = 0; i < fullStars; i++) {
//       stars.add(Icon(Icons.star, color: Colors.yellow));
//     }
//     // Adding half star if present
//     if (hasHalfStar) {
//       stars.add(Icon(Icons.star_half, color: Colors.yellow));
//     }
//     // Adding empty stars
//     for (int i = 0; i < emptyStars; i++) {
//       stars.add(Icon(Icons.star_border, color: Colors.yellow));
//     }
//     return stars;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   imageUrl,
//                   height: 26.h,
//                   fit: BoxFit.cover,
//                 ),

//                 // if (text != null) // Check if text is not null
//                 Positioned(
//                   top: 8.0, // Adjust the position as needed
//                   left: 8.0,
//                   child: Container(
//                     padding: EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Colors.red,
//                     ),
//                     child: Text(
//                       // text!,
//                       "-20%",
//                       style: TextStyle(
//                         color: Colors.white, // Adjust the text color as needed
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Row(
//             children: renderStars(4.5), // Example rating
//           ),
//           Text('Dorothy Perkins',
//               style: TextStyle(color: textPrimaryLightColor, fontSize: 11.sp)),
//           SizedBox(height: 0.2.h),
//           Text('Evening Dress',
//               style: TextStyle(
//                   color: darkBlackFontColor,
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.bold)),
//           SizedBox(height: 0.2.h),
//           Text("1200",
//               style:
//                   TextStyle(color: redFontColor, fontWeight: FontWeight.bold)),
//         ],
//       ),
//     );
//   }
// }
