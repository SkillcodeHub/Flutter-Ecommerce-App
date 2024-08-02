import 'dart:async';
import 'dart:convert';

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

//   String clientId = '1';
//   String ipAddress = '192.168.0.1';
//   String? token;
//   dynamic UserData;

//   late Future<void> fetchDataFuture;
//   void initState() {
//     // userPreference.getSrId().then((value) {
//     //   setState(() {
//     //     doctorId = value!;

//     //     print('srId : $doctorId');
//     //   });
//     // });
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value!;
//         print('Token : $token');
//       });
//     });
//     super.initState();
//     fetchDataFuture = fetchData(); // Call the API only once
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
//             return Center(
//                 // child: WaveLoaderWidget(),
//                 // CircularProgressIndicator(),
//                 );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error occurred: ${snapshot.error}'),
//             );
//           } else {
//             // Render the UI with the fetched data
//             return ChangeNotifierProvider<FeaturedProductListViewmodel>.value(
//               value: featuredProductListViewmodel,
//               child: Consumer<FeaturedProductListViewmodel>(
//                 builder: (context, value, _) {
//                   switch (value.featuredProductList.status!) {
//                     case Status.LOADING:
//                       return Center(
//                         child: CircularProgressIndicator(),
//                         // child: WaveLoaderWidget(),

//                         // CircularProgressIndicator()
//                       );
//                     case Status.ERROR:
//                       String? message;
//                       if (value.featuredProductList.message !=
//                           "No Internet Connection") {
//                         String jsonString =
//                             value.featuredProductList.message.toString();

//                         // Find the start and end index of the JSON string
//                         int startIndex = jsonString.indexOf('{');
//                         int endIndex = jsonString.lastIndexOf('}');

//                         // Extract the JSON substring
//                         String jsonSubstring =
//                             jsonString.substring(startIndex, endIndex + 1);

//                         // Parse the JSON substring
//                         Map<String, dynamic> jsonResponse =
//                             json.decode(jsonSubstring);

//                         // Access the "message" field
//                         message = jsonResponse['message'];
//                       }
//                       // Print the message
//                       return value.featuredProductList.message ==
//                               "No Internet Connection"
//                           ? ErrorScreenWidget(
//                               onRefresh: () async {
//                                 // refresh();
//                               },
//                               loadingText:
//                                   value.featuredProductList.message.toString(),
//                             )
//                           : Text('data');
//                     // AlertWidget(
//                     //     onRefresh: () async {
//                     //       refresh();
//                     //     },
//                     //     loadingText: message.toString(),
//                     //   );

//                     case Status.COMPLETED:
//                       print('object');
//                       // timeZoneName = value
//                       //     .axonwebAppSettingsDetails.data!.data![0].timezoneid
//                       //     .toString();

//                       return SingleChildScrollView(
//                         child: Column(
//                           children: [
//                             Stack(
//                               children: [
//                                 Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.65, // Set a fixed height for the container
//                                   decoration: BoxDecoration(
//                                     image: DecorationImage(
//                                       image:
//                                           AssetImage('images/Big Banner.png'),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   bottom: 16.0,
//                                   left: 16.0,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'Fashion',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 30.sp,
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                       ),
//                                       // SizedBox(height: 8.0),
//                                       Text(
//                                         'sale',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 30.sp,
//                                           fontWeight: FontWeight.w900,
//                                         ),
//                                       ),
//                                       SizedBox(height: 8.0),
//                                       ElevatedButton(
//                                         onPressed: () {
//                                           // Implement click logic
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       CheckButtonScreen()));
//                                         },
//                                         child: Text(
//                                           'Check',
//                                           style: TextStyle(fontSize: 14.sp),
//                                         ),
//                                         style: ElevatedButton.styleFrom(
//                                           shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(30)),
//                                           primary: Colors.red,
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 45.0,
//                                             vertical: 12.0,
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 10.0),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: 16.0),
//                                 Padding(
//                                   padding: EdgeInsets.all(12.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'New',
//                                             style: TextStyle(
//                                               fontSize: 19.sp,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             "You've never seen it before!",
//                                             style: TextStyle(
//                                                 fontSize: 10.sp,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: textPrimaryLightColor),
//                                           ),
//                                         ],
//                                       ),
//                                       Text('View all')
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 Container(
//                                   width: MediaQuery.of(context)
//                                       .size
//                                       .width, // Set a specific width
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount:
//                                         9, // Or the number of items you want to display
//                                     itemBuilder: (context, index) {
//                                       // Alternate between the two images based on the index
//                                       String imageUrl = index % 2 == 0
//                                           ? 'images/Product card_new.png'
//                                           : 'images/Product card_new_2.png';

//                                       return SmallImageCard(imageUrl: imageUrl);
//                                     },
//                                   ),
//                                 ),
//                                 SizedBox(height: 16.0),
//                                 Padding(
//                                   padding: EdgeInsets.all(8.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Sale',
//                                             style: TextStyle(
//                                               fontSize: 19.sp,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           Text(
//                                             "Super summer sale",
//                                             style: TextStyle(
//                                                 fontSize: 10.sp,
//                                                 fontWeight: FontWeight.bold,
//                                                 color: textPrimaryLightColor),
//                                           ),
//                                         ],
//                                       ),
//                                       Text('View all')
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 8.0),
//                                 SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Row(
//                                     children: [
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new_2.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new_2.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new_2.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new_2.png'),
//                                       SmallImageCard(
//                                           imageUrl:
//                                               'images/Product card_new.png'),
//                                       // Add more SmallImageCard() widgets as needed
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 16.0),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class SmallImageCard extends StatelessWidget {
//   final String imageUrl;
//   final String? text; // Added an optional text parameter

//   SmallImageCard({required this.imageUrl, this.text});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(8.0),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(8.0),
//         child: Stack(
//           children: [
//             Image.asset(
//               imageUrl,
//               height: 24.h,
//               fit: BoxFit.cover,
//             ),
//             // if (text != null) // Check if text is not null
//             // Positioned(
//             //   top: 8.0, // Adjust the position as needed
//             //   left: 8.0,
//             //   child: Container(
//             //     padding: EdgeInsets.all(4),
//             //     decoration: BoxDecoration(
//             //       borderRadius: BorderRadius.circular(8),
//             //       color: Colors.black,
//             //     ),
//             //     child: Text(
//             //       // text!,
//             //       "New",
//             //       style: TextStyle(
//             //         color: Colors.white, // Adjust the text color as needed
//             //         fontWeight: FontWeight.bold,
//             //       ),
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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
    return SingleChildScrollView(
      child: Column(
        children: [
          buildBannerSection(context),
          buildNewProductsSection(context),
          buildSaleSection(context),
          buildTopRatedSection(context),
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
                .featuredProductList.data!.topRatedProductList!.length,
            itemBuilder: (context, index) {
              String imageUrl = index % 2 == 0
                  ? 'images/Product card_new.png'
                  : 'images/Product card_new_2.png';
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
}

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
      return url.replaceAll('http://localhost', 'http://10.0.2.2');
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
            // Row(
            //   children: List.generate(
            //     widget.averageRating.toInt(),
            //     (index) => Icon(
            //       index < 4 ? Icons.star : Icons.star_border,
            //       size: 16,
            //       color: Colors.yellow,
            //     ),
            //   ),
            // ),
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
