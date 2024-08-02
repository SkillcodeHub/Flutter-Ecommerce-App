library utils;

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import "package:flutter/material.dart";
import "package:sizer/sizer.dart";

class Utils {
  // static toastMessage(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //   );
  // }

  static void flushBarErrorMessage(
      String message, Duration duration, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.all(15),
        message: message,
        duration: duration,
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.grey.shade800,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade800,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 3.3.h,
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              // Wrap the Text widget with Expanded
              child: Text(
                message,
                style: TextStyle(fontSize: 10.sp),
                overflow: TextOverflow.visible, // Set overflow to visible
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }

  static snackBar1(String message, Duration duration, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey.shade800,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 3.3.h,
            ),
            SizedBox(
              width: 3.w,
            ),
            Expanded(
              // Wrap the Text widget with Expanded
              child: Text(
                message,
                overflow: TextOverflow.visible, // Set overflow to visible
              ),
            ),
          ],
        ),
        duration: duration,
      ),
    );
  }
}
