import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/FeaturedProductList_Model/featuredProductList_model.dart';
import 'package:ecommerce/Repository/FeaturedProductList_Repository/featuredProductList_repository.dart';
import 'package:flutter/material.dart';

class FeaturedProductListViewmodel with ChangeNotifier {
  final _myRepo = FeaturedProductListRepository();
  ApiResponse<FeaturedProductListModel> featuredProductList =
      ApiResponse.loading();
  setFeaturedProductList(ApiResponse<FeaturedProductListModel> response) {
    featuredProductList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchFeaturedProductListApi(
      String clientId, String ipAddress) async {
    setFeaturedProductList(ApiResponse.loading());
    _myRepo.fetchFeaturedProductListApi(clientId, ipAddress).then((value) {
      setFeaturedProductList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setFeaturedProductList(ApiResponse.error(error.toString()));
    });
  }
}
