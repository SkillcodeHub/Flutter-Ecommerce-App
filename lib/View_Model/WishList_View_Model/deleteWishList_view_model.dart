import 'package:ecommerce/Repository/WishList_Repository/deleteWishList_repository.dart';
import 'package:ecommerce/Utils/Calender/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeleteWishListViewModel with ChangeNotifier {
  final _myRepo = DeleteWishListRepository();

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> deleteWishListApi(
      String ipAddress, Map<String, String> data, BuildContext context) async {
    setLoading(true);
    await _myRepo.deleteWishListapi(ipAddress, data).then((value) {
      if (value['status'] == true) {
        // Utils.flushBarErrorMessage(
        //     value['message'], Duration(seconds: 2), context);

        // Navigator.of(context).pop();
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
