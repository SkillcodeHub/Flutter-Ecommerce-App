import 'dart:async';

import 'package:ecommerce/Repository/Profile_Repository/CustomerAddresses_Repository/addCustomerAddress_repository.dart';
import 'package:ecommerce/Utils/Calender/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddCustomerAddressViewModel with ChangeNotifier {
  final _myRepo = AddCustomerAddressRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> addCustomerAddressApi(
      String ipAddress, Map<String, String> data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _myRepo.addCustomerAddressapi(ipAddress, data);
      setLoading(false);
      if (value['status'] == true) {
        if (kDebugMode) {
          print(value.toString());
        }
        return true;
      } else {
        Utils.flushBarErrorMessage(value['message'] ?? 'An error occurred',
            Duration(seconds: 2), context);
        return false;
      }
    } catch (error) {
      setLoading(false);
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 2), context);
      if (kDebugMode) {
        print(error.toString());
      }
      return false;
    }
  }
  // Future<void> addCustomerAddressApi(
  //     String ipAddress, Map<String, String> data, BuildContext context) async {
  //   setLoading(true);
  //   await _myRepo.addCustomerAddressapi(ipAddress, data).then((value) {
  //     if (value['status'] == true) {
  //       Utils.flushBarErrorMessage(
  //           value['message'], Duration(seconds: 2), context);

  //       Navigator.of(context).pop();
  //       // Navigator.

  //       setLoading(false);
  //       if (kDebugMode) {
  //         print(value.toString());
  //       }
  //     }
  //   }).onError((error, stackTrace) {
  //     Utils.flushBarErrorMessage(
  //         error.toString(), Duration(seconds: 2), context);
  //     setLoading(false);

  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }
}
