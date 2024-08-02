// import 'package:axondoctor/Utils/Routes/routes_name.dart';
// import 'package:axondoctor/View/Auth/Authentication/LoginPage/login_screen.dart';
// import 'package:axondoctor/View/Auth/Authentication/OTPVerify/otpVerify_screen.dart';
// import 'package:axondoctor/View/AxonWebUserScreen/Appointment/EditAppointment/editAppointment_screen.dart';
// import 'package:axondoctor/View/AxonWebUserScreen/Dashboard/Screens/dashBoard_screen.dart';
// import 'package:axondoctor/View/AxonWebUserScreen/MyNavigationBar/myNavigationBar.dart';
// import 'package:axondoctor/View/AxonWebUserScreen/News/NewsDetails/newsDetailsScreen.dart';
// import 'package:axondoctor/View/AxonWebUserScreen/NotificationScreens/notificationAppointmentdetails_screen.dart';
// import 'package:axondoctor/View/CmsUserScreen/Home/CmsPaymentDetailsScreen/cmsPaymentDetailsScreen.dart';
// import 'package:axondoctor/View/CmsUserScreen/Home/CmsReference/CmsEditReference/cmsEditReference_screen.dart';
// import 'package:axondoctor/View/CmsUserScreen/Home/CmsSoftwareFaqs/CmsFaqsDetails/faqsDetailsScreen.dart';
// import 'package:axondoctor/View/CmsUserScreen/Home/CmsSupportTicket/CmsTicketDetailsScreen/cmsTicketDetailsScreen.dart';
// import 'package:axondoctor/View/Splash/SplashScreen/splash_screen.dart';
import 'package:ecommerce/Model/Profile_Repository/CustomerAddresses_Model/customerAddresses_model.dart';
import 'package:ecommerce/Model/Profile_Repository/CustomerProfile_Model/customerDetailsById_model.dart';
import 'package:ecommerce/Utils/Routes/routes_name.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/addressScreen/editAddressScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/profileDetailScreen.dart';
import 'package:ecommerce/View/SplashScreen/splashScreen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => SplashScreen());

      case RoutesName.editAddressScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => EditAddressScreen(
                addressList: settings.arguments as AddressList));
      case RoutesName.editProfileDetailsScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => UpdateProfileScreen(
                customerList: settings.arguments as CustomerList));
      // case RoutesName.verifyOtp:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           OtpVerifyScreen(mobile: settings.arguments as Map));
      // case RoutesName.myNevigationBar:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => MyNavigationBar(
      //             indexNumber: 0,
      //           ));

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
