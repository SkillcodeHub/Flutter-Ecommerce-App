import 'package:ecommerce/View/Auth/loginScreenPage.dart';
import 'package:ecommerce/View/NavigationBar/myNavigationBar.dart';
import 'package:ecommerce/View/SharePreferences/sharePreference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SplashServices {
  var email;
  var token;
  UserPreferences userPreference = UserPreferences();
  // Future getProviderData() => userPreference.getToken();
  void checkAuthentication(BuildContext context) async {
    userPreference.getEmail().then((value) {
      email = value;
      print('getEmailgetEmailgetEmailgetEmailgetEmailgetEmail');
      print(email);
      print('tokentokentokentokentokentokentoken');

      print(token.toString());
      print('tokentokentokentokentokentokentoken');
      if (email == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
      // else if (email != null && token == null) {
      //   Navigator.pushAndRemoveUntil(
      //       context,
      //       MaterialPageRoute(builder: (context) => ChangeProviderScreen()),
      //       (route) => false);
      // }
      else if (email != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(
                      indexNumber: 0,
                    )),
            (route) => false);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
