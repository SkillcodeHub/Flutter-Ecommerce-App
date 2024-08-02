import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/WishList_View_Model/wishList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  get json => null;
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
      final wishListViewmodel =
          Provider.of<WishListViewmodel>(context, listen: false);
      Map<String, String> data = {'customerId': CustomerId};

      wishListViewmodel.fetchWishListApi(clientId, ipAddress, data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishListViewmodel =
        Provider.of<WishListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Wishlist',
          style: TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Handle shopping bag button press
                },
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
                    '17',
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
            return ChangeNotifierProvider<WishListViewmodel>.value(
                value: wishListViewmodel,
                child: Consumer<WishListViewmodel>(
                  builder: (context, value, _) {
                    switch (value.wishList.status!) {
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

  Widget handleError(WishListViewmodel value) {
    String? message;
    if (value.wishList.message != "No Internet Connection") {
      String jsonString = value.wishList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.wishList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.wishList.message.toString(),
          )
        : Text('data');
  }

  // Widget _buildCompletedUI(
  //   BuildContext context,
  //   WishListViewmodel wishListViewmodel,
  // ) {
  //   return GridView.count(
  //     crossAxisCount: 2,
  //     childAspectRatio: 0.55,
  //     padding: EdgeInsets.all(16),
  //     mainAxisSpacing: 16,
  //     crossAxisSpacing: 16,
  //     children: [
  //       WishlistItem(
  //         brand: 'Adidas',
  //         name: 'Adilette Shower Sliders',
  //         price: '₹ 1,799',
  //         originalPrice: '₹ 2,999',
  //         discount: '40% off',
  //         imageUrl: 'images/sale_photo_2.png',
  //       ),
  //       WishlistItem(
  //         brand: 'Adidas Originals',
  //         name: 'Adilette Lite Sliders',
  //         price: '₹ 1,410',
  //         originalPrice: '₹ 2,999',
  //         discount: '53% off',
  //         imageUrl: 'images/sale_photo_2.png',
  //       ),
  //       WishlistItem(
  //         brand: 'Nike',
  //         name: 'Victori One Printed Slide',
  //         price: '',
  //         originalPrice: '',
  //         discount: '',
  //         imageUrl: 'images/sale_photo_2.png',
  //       ),
  //     ],
  //   );
  // }
  Widget _buildCompletedUI(
    BuildContext context,
    WishListViewmodel wishListViewmodel,
  ) {
    // Assuming the API response is stored in wishListViewmodel.wishList.data
    final wishlistItems = wishListViewmodel.wishList.data!.wishList;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.55,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      padding: EdgeInsets.all(8),
      itemCount: wishlistItems!.length,
      itemBuilder: (context, index) {
        final item = wishlistItems[index];

        List<String> imageUrls = [];
        try {
          imageUrls = List<String>.from(
              jsonDecode(item.productDetails!.productGallery.toString()));
        } catch (e) {
          print('Error parsing image URLs: $e');
        }

        String firstImageUrl = imageUrls.isNotEmpty
            ? imageUrls.first
            : 'https://example.com/placeholder.jpg'; // Use a placeholder if no image is available

        return WishlistItem(
          brand: item.clientDetails!.companyName.toString(),
          name: item.productDetails!.productName.toString(),
          price: item.productDetails!.productPrice.toString(),
          originalPrice: item.productDetails!.productPrice.toString(),
          // discount: item.discount,
          imageUrl: firstImageUrl,
          // onDelete: () {
          //   // Implement delete functionality
          //   wishListViewmodel.removeFromWishlist(item.id);
          // },
          // onAddToBag: () {
          //   // Implement add to bag functionality
          //   wishListViewmodel.addToBag(item.id);
          // },
        );
      },
    );
  }
}

class WishlistItem extends StatelessWidget {
  final String brand;
  final String name;
  final String price;
  final String originalPrice;
  // final String discount;
  final String imageUrl;

  const WishlistItem({
    Key? key,
    required this.brand,
    required this.name,
    required this.price,
    required this.originalPrice,
    // required this.discount,
    required this.imageUrl,
  }) : super(key: key);
  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost', 'http://10.0.2.2');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 24.h,
                child: Image.network(
                  convertLocalhost(imageUrl),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
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
                      Icons.favorite,
                      color: appSecondaryColor,
                      size: 2.h,
                    ),
                    onPressed: () {
                      // Handle favorite button press
                    },
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(brand, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text(price, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Text(
                      originalPrice,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 12,
                      ),
                    ),
                    // Text(
                    //   discount,
                    //   style: TextStyle(color: Colors.green, fontSize: 12),
                    // ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      height: 4.h,
                      width: 4.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          style: BorderStyle.solid,
                          color: Colors.grey.shade700,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_rounded,
                          size: 2.5.h,
                          color: Colors.grey.shade700,
                        ),
                        onPressed: () {
                          // Handle delete
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Add To Bag',
                            style: TextStyle(fontSize: 10.sp)),
                        onPressed: () {
                          // Handle add to bag
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          backgroundColor: appSecondaryColor,
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
