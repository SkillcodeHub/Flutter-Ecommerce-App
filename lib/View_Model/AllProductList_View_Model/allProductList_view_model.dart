import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/AllProductList_Model/allProductList_model.dart';
import 'package:ecommerce/Repository/AllProductList_Repository/allProductList_repository.dart';
import 'package:flutter/material.dart';

class AllProductListViewmodel with ChangeNotifier {
  final _myRepo = AllProductListRepository();
  ApiResponse<AllProductListModel> allProductList = ApiResponse.loading();
  setAllProductList(ApiResponse<AllProductListModel> response) {
    allProductList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchAllProductListApi(String clientId, String ipAddress) async {
    setAllProductList(ApiResponse.loading());
    _myRepo.fetchAllProductListApi(clientId, ipAddress).then((value) {
      setAllProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setAllProductList(ApiResponse.error(error.toString()));
    });
  }
}
