// import 'package:axondoctor/View/CmsUserScreen/CmsMyNavigationBar/cmsMyNavigationBar.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class AlertWidget extends StatelessWidget {
//   final Future<void> Function() onRefresh;
//   final String loadingText;

//   AlertWidget({
//     required this.onRefresh,
//     required this.loadingText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return

//         // RefreshIndicator(
//         //   onRefresh: onRefresh,
//         //   child:

//         Stack(
//       children: [
//         SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           // physics: BouncingScrollPhysics(),
//           child: Padding(
//             padding: EdgeInsets.all(15),
//             child: Container(
//               height: 74.h,
//               child: Center(
//                   child: AlertDialog(
//                 title: Center(
//                   child: Text(
//                     'Alert!',
//                     style:
//                         TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 content: Text(
//                   loadingText.toString(),
//                   style: TextStyle(
//                       // fontWeight:
//                       //     FontWeight
//                       //         .bold,
//                       fontSize: 14.sp),
//                   textAlign: TextAlign.center,
//                 ),
//                 actions: <Widget>[
//                   SizedBox(
//                     width: 80.w,
//                     child: ElevatedButton(
//                       child: Text(
//                         'OK',
//                         style: TextStyle(
//                             fontSize: 13.sp, fontWeight: FontWeight.bold),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CmsMyNavigationBar(
//                                       indexNumber: 0,
//                                     )));
//                         // Timer(Duration(seconds: 5),() =>  settingsViewModel.setLoading1(true)) ;
//                       },
//                     ),
//                   ),
//                 ],
//               )),
//             ),
//           ),
//         ),
//       ],
//     );
//     // );
//   }
// }
