import 'package:ecommerce/Model/cartList_Model/cartList_model.dart';
import 'package:ecommerce/Repository/CartList_Repository.dart/cartList_repository.dart';
import 'package:flutter/material.dart';

import '../../Data/Response/api_response.dart';

class CartListViewmodel with ChangeNotifier {
  final _myRepo = CartListRepository();
  ApiResponse<CartListModel> cartList = ApiResponse.loading();
  setCartList(ApiResponse<CartListModel> response) {
    cartList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCartListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setCartList(ApiResponse.loading());
    _myRepo.fetchCartListApi(clientId, ipAddress, data).then((value) {
      setCartList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCartList(ApiResponse.error(error.toString()));
    });
  }
}
