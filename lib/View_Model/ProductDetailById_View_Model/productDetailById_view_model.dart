import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/ProductDetailById_Model/productDetailById_model.dart';
import 'package:ecommerce/Repository/ProductDetailById_Repository/productDetailById_repository.dart';
import 'package:flutter/material.dart';

class ProductDetailByIdViewmodel with ChangeNotifier {
  final _myRepo = ProductDetailByIdRepository();
  ApiResponse<ProductDetailByIdModel> productDetailById = ApiResponse.loading();
  setProductDetailById(ApiResponse<ProductDetailByIdModel> response) {
    productDetailById = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchProductDetailByIdApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setProductDetailById(ApiResponse.loading());
    _myRepo.fetchProductDetailByIdApi(clientId, ipAddress, data).then((value) {
      setProductDetailById(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setProductDetailById(ApiResponse.error(error.toString()));
    });
  }
}
