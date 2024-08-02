// // import 'package:flutter/material.dart';

// // class ShopScreen extends StatefulWidget {
// //   const ShopScreen({super.key});

// //   @override
// //   State<ShopScreen> createState() => _ShopScreenState();
// // }

// import 'package:flutter/material.dart';

// class ShopScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         );
//   }
// }

import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/View/Shop/ShopScreen/productListScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Summer Sales',
//       home: SummerSalesScreen(),
//     );
//   }
// }

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // leading:

          //     IconButton(
          //   icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          backgroundColor: Colors.white,
          title: Text(
            'Categories',
            style:
                TextStyle(color: titleFontColor, fontWeight: FontWeight.bold),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: Colors.black),
            ),
          ],
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: redFontColor,
            tabs: [
              Tab(text: 'Women'),
              Tab(text: 'Men'),
              Tab(text: 'Kids'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.red,
                      ),
                      height: 12.h,
                      width: 100.w,
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUMMER SALES',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'Up to 50% off',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 4.1.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Clothes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shoes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 2.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Accesories',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 3.png",
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.red,
                      ),
                      height: 12.h,
                      width: 100.w,
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUMMER SALES',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'Up to 50% off',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 4.1.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Clothes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shoes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 2.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Accesories',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 3.png",
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.red,
                      ),
                      height: 12.h,
                      width: 100.w,
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SUMMER SALES',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'Up to 50% off',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'New',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 4.1.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Clothes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Shoes',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 2.png",
                    ),
                    CustomListTile(
                      containerContent: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Accesories',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      imageUrl: "images/c_image 3.png",
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

// class VerticalList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: [
//         ListTile(
//           title: Text(
//             'New',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           trailing: SizedBox(
//             width: 50.w,
//             height: 20.h,
//             child: Image.asset(
//               'images/c_image 4.1.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         ListTile(
//           title: Text(
//             'Clothes',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           trailing: SizedBox(
//             width: 80.0,
//             height: 80.0,
//             child: Image.asset(
//               'images/c_image.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         ListTile(
//           title: Text(
//             'Shoes',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           trailing: SizedBox(
//             width: 80.0,
//             height: 80.0,
//             child: Image.asset(
//               'images/c_image 2.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         ListTile(
//           title: Text(
//             'Accessories',
//             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//           ),
//           trailing: SizedBox(
//             width: 80.0,
//             height: 80.0,
//             child: Image.asset(
//               'images/c_image 3.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class CustomListTile extends StatelessWidget {
  final String imageUrl;
  final Widget containerContent;
  final double height;
  final double width;

  CustomListTile({
    required this.imageUrl,
    required this.containerContent,
    this.height = 95, // Default height
    this.width = double.infinity, // Default width
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductListScreen()));
      },
      child: Container(
        height: height,
        width: width,
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), // Rounded border
          // border: Border.all(color: Colors.grey), // Border color
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity, // Full height
                width: double.infinity, // Full width of the left half
                child: containerContent, // Content for the left half
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                child: Image.asset(
                  imageUrl,
                  height: double.infinity, // Full height
                  width: double.infinity, // Full width of the right half
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
