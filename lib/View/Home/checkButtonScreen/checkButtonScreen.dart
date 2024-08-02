import 'dart:convert';

import 'package:ecommerce/Res/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckButtonScreen extends StatefulWidget {
  const CheckButtonScreen({super.key});

  @override
  State<CheckButtonScreen> createState() => _CheckButtonScreenState();
}

class _CheckButtonScreenState extends State<CheckButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.25, // Set a fixed height for the container
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Small banner.png'),
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
                        'Street clothes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      // SizedBox(height: 8.0),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
            Column(
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
                            'Sale',
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
                                color: textPrimaryLightColor),
                          ),
                        ],
                      ),
                      Text('View all')
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SaleImageCard(imageUrl: 'images/sale_photo_2.png'),
                      SaleImageCard(imageUrl: 'images/sale_photo_1.png'),
                      SaleImageCard(imageUrl: 'images/sale_photo_2.png'),
                      SaleImageCard(imageUrl: 'images/sale_photo_1.png'),
                      SaleImageCard(
                          imageUrl:
                              'images/sale_photo_1.png'), // Add more SmallImageCard() widgets as needed
                    ],
                  ),
                ),
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
                                color: textPrimaryLightColor),
                          ),
                        ],
                      ),
                      Text('View all')
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SmallImageCard(imageUrl: 'images/Product card_new.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new_2.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new_2.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new_2.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new_2.png'),
                      SmallImageCard(imageUrl: 'images/Product card_new.png'),
                      // Add more SmallImageCard() widgets as needed
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SmallImageCard extends StatefulWidget {
  final String imageUrl;
  final String? text; // Added an optional text parameter

  SmallImageCard({required this.imageUrl, this.text});

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
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }
    // Adding half star if present
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
    }
    // Adding empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    imageUrls = List<String>.from(json.decode(widget.imageUrl));
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    print(imageUrls[0]);
    print('imageUrls[0])imageUrls[0])imageUrls[0])imageUrls[0]');
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                Image.network(
                  'http://10.0.2.2:8000/media/media/processed_71JAtYR3tLL._SY741_.jpg',
                  // imageUrls[0],
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
          Row(
            children: renderStars(4.5), // Example rating
          ),
          Text('Dorothy Perkins',
              style: TextStyle(color: textPrimaryLightColor, fontSize: 11.sp)),
          SizedBox(height: 0.2.h),
          Text('Evening Dress',
              style: TextStyle(
                  color: darkBlackFontColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 0.2.h),
          Text("1200",
              style:
                  TextStyle(color: redFontColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class SaleImageCard extends StatelessWidget {
  final String imageUrl;
  final String? text; // Added an optional text parameter

  SaleImageCard({required this.imageUrl, this.text});
  List<Widget> renderStars(double rating) {
    int fullStars = rating.floor();
    bool hasHalfStar = rating % 1 != 0;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);
    List<Widget> stars = [];
    // Adding full stars
    for (int i = 0; i < fullStars; i++) {
      stars.add(Icon(Icons.star, color: Colors.yellow));
    }
    // Adding half star if present
    if (hasHalfStar) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow));
    }
    // Adding empty stars
    for (int i = 0; i < emptyStars; i++) {
      stars.add(Icon(Icons.star_border, color: Colors.yellow));
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Stack(
              children: [
                Image.asset(
                  imageUrl,
                  height: 26.h,
                  fit: BoxFit.cover,
                ),

                // if (text != null) // Check if text is not null
                Positioned(
                  top: 8.0, // Adjust the position as needed
                  left: 8.0,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.red,
                    ),
                    child: Text(
                      // text!,
                      "-20%",
                      style: TextStyle(
                        color: Colors.white, // Adjust the text color as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: renderStars(4.5), // Example rating
          ),
          Text('Dorothy Perkins',
              style: TextStyle(color: textPrimaryLightColor, fontSize: 11.sp)),
          SizedBox(height: 0.2.h),
          Text('Evening Dress',
              style: TextStyle(
                  color: darkBlackFontColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 0.2.h),
          Text("1200",
              style:
                  TextStyle(color: redFontColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
