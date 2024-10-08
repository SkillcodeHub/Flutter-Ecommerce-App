import 'package:ecommerce/Repository/CartList_Repository.dart/deleteCart_repository.dart';
import 'package:ecommerce/Utils/Calender/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeleteCartViewModel with ChangeNotifier {
  final _myRepo = DeleteCartRepository();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<bool> deleteCartApi(
      String ipAddress, Map<String, String> data, BuildContext context) async {
    setLoading(true);
    try {
      final value = await _myRepo.deleteCartapi(ipAddress, data);
      setLoading(false);
      if (value['status'] == true) {
        Utils.flushBarErrorMessage(
            value['message'], Duration(seconds: 2), context);
        if (kDebugMode) {
          print(value.toString());
        }
        notifyListeners(); // Notify listeners that the data has changed
        return true;
      }
    } catch (error) {
      setLoading(false);
      Utils.flushBarErrorMessage(
          error.toString(), Duration(seconds: 2), context);
      if (kDebugMode) {
        print(error.toString());
      }
    }
    return false;
  }
}
