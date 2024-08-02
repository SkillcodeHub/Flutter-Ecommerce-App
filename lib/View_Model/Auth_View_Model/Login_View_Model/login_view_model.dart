import 'dart:async';

import 'package:ecommerce/Repository/Login_Repository/login_repository/login_repository.dart';
import 'package:ecommerce/Utils/Calender/utils.dart';
import 'package:ecommerce/View/Auth/loginScreenPage.dart';
import 'package:ecommerce/View/NavigationBar/myNavigationBar.dart';
import 'package:ecommerce/View/SharePreferences/sharePreference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = LoginRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(Map<String, String> data, BuildContext context) async {
    setLoading(true);
    await _myRepo.loginapi(data).then((value) {
      if (value['status'] == true) {
        // Utils.flushBarErrorMessage(
        //     "OTP Send Successfully", Duration(seconds: 2), context);
        UserPreferences userPreference = UserPreferences();
        print("value['access'].toString()");
        // print(value.toString());
        print("111111111111111111${value['access'].toString()}");
        print("value['access'].toString()");
        userPreference.setEmail(data['username'].toString());
        userPreference.setToken(value['access'].toString());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(
                      indexNumber: 0,
                    )),
            (route) => false);
        Timer(Duration(seconds: 2), () {
          setLoading(false);
        });

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
        final authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        Utils.flushBarErrorMessage(
            value['message'], Duration(seconds: 2), context);
      }
      ;
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 2), context);

      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(
      Map<String, String> data, BuildContext context) async {
    setLoading(true);
    await _myRepo.registerapi(data).then((value) {
      if (value['status'] == true) {
        Utils.flushBarErrorMessage(
            "User Register Successfully", Duration(seconds: 2), context);

        Timer(Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
          setLoading(false);
        });

        if (kDebugMode) {
          print(value.toString());
        }
      } else if (value['status'] == false) {
        final authViewModel =
            Provider.of<AuthViewModel>(context, listen: false);
        Utils.flushBarErrorMessage(
            value['message'], Duration(seconds: 2), context);
      }
      ;
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 2), context);
      setLoading(false);

      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
