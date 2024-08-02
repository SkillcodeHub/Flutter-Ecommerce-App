import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderdetailbyorderedproduct_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/OrderList_Repository/orderdetailbyorderedproduct_repository.dart';
import 'package:flutter/material.dart';

class OrderdetailbyorderedproductViewmodel with ChangeNotifier {
  final _myRepo = OrderdetailbyorderedproductRepository();
  ApiResponse<OrderdetailbyorderedproductModel> orderdetailbyorderedproduct =
      ApiResponse.loading();
  setOrderdetailbyorderedproduct(
      ApiResponse<OrderdetailbyorderedproductModel> response) {
    orderdetailbyorderedproduct = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchOrderdetailbyorderedproductApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setOrderdetailbyorderedproduct(ApiResponse.loading());
    _myRepo
        .fetchOrderdetailbyorderedproductApi(clientId, ipAddress, data)
        .then((value) {
      setOrderdetailbyorderedproduct(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderdetailbyorderedproduct(ApiResponse.error(error.toString()));
    });
  }
}
