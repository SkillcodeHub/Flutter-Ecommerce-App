import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/AllProductList_Model/allProductList_model.dart';
import 'package:ecommerce/Repository/AllProductList_Repository/filterProductList_repository.dart';
import 'package:flutter/material.dart';

class FilterProductListViewmodel with ChangeNotifier {
  final _myRepo = FilterProductListRepository();
  ApiResponse<AllProductListModel> filterProductList = ApiResponse.loading();
  setFilterProductList(ApiResponse<AllProductListModel> response) {
    filterProductList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchFilterProductListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setFilterProductList(ApiResponse.loading());
    _myRepo.fetchFilterProductListApi(clientId, ipAddress, data).then((value) {
      setFilterProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFilterProductList(ApiResponse.error(error.toString()));
    });
  }
}
