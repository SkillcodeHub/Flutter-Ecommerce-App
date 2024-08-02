import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/WishList_Model/wishList_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/WishList_Repository/wishList_repository.dart';
import 'package:flutter/material.dart';

class WishListViewmodel with ChangeNotifier {
  final _myRepo = WishListRepository();
  ApiResponse<WishListModel> wishList = ApiResponse.loading();
  setWishList(ApiResponse<WishListModel> response) {
    wishList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchWishListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setWishList(ApiResponse.loading());
    _myRepo.fetchWishListApi(clientId, ipAddress, data).then((value) {
      setWishList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setWishList(ApiResponse.error(error.toString()));
    });
  }
}
