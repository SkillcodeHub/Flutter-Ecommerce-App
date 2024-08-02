import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderList_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/OrderList_Repository/orderList_repository.dart';
import 'package:flutter/material.dart';

class OrderListViewmodel with ChangeNotifier {
  final _myRepo = OrderListRepository();
  ApiResponse<OrderListModel> orderList = ApiResponse.loading();
  setOrderList(ApiResponse<OrderListModel> response) {
    orderList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchOrderListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setOrderList(ApiResponse.loading());
    _myRepo.fetchOrderListApi(clientId, ipAddress, data).then((value) {
      setOrderList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setOrderList(ApiResponse.error(error.toString()));
    });
  }
}
