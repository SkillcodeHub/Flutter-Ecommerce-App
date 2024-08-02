import 'dart:async';

import 'package:ecommerce/Repository/Profile_Repository/CustomerProfile_Repository/editCustomerDetails_repository.dart';
import 'package:ecommerce/Utils/Calender/utils.dart';
import 'package:ecommerce/View/NavigationBar/myNavigationBar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditCustomerDetailsViewModel with ChangeNotifier {
  final _myRepo = EditCustomerDetailsRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> editCustomerDetailsApi(String clientId, String ipAddress,
      Map<String, String> data, BuildContext context) async {
    setLoading(true);
    await _myRepo
        .editCustomerDetailsapi(clientId, ipAddress, data)
        .then((value) {
      if (value['status'] == true) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(
                      indexNumber: 4,
                    )),
            (route) => false);
        setLoading(false);
        Utils.flushBarErrorMessage(
            value['message'], Duration(seconds: 2), context);
        // Navigator.pop(context);
        // Navigator.

        setLoading(false);
        if (kDebugMode) {
          print(value.toString());
        }
      }
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
