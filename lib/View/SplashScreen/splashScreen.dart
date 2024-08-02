import 'package:ecommerce/View/SplashScreen/splash_services.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splasheSrvices = SplashServices();

  @override
  void initState() {
    super.initState();

    // splasheSrvices.checkAuthentication(context);
    // Timer(
    //   Duration(seconds: 1),
    //   () {
    splasheSrvices.checkAuthentication(context);
    // },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Center(
              //   child: Container(
              //     height: 15.h,
              //     child: Image.asset(
              //       'images/axon.png',
              //     ),
              //   ),
              //   // Text(
              //   //   "Axon",
              //   //   style: Theme.of(context).textTheme.headline2,
              //   // ),
              // ),
              SizedBox(
                height: 1.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'E-Commerce',
                    style: TextStyle(fontSize: 13.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // UpgradeAlert(
    //   upgrader: Upgrader(
    //     canDismissDialog: false,
    //     showLater: false,
    //     showIgnore: false,
    //     showReleaseNotes: false,
    //   ),
    //   child: );
  }
}
