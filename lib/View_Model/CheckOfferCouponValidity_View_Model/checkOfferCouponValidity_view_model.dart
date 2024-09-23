import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/CheckOfferCouponValidity_Model/checkOfferCouponValidity_model.dart';
import 'package:ecommerce/Repository/CheckOfferCouponValidity_Reopository/checkOfferCouponValidity_repository.dart';
import 'package:flutter/material.dart';

class CheckOfferCouponValidityViewmodel with ChangeNotifier {
  final _myRepo = CheckOfferCouponValidityRepository();
  ApiResponse<CheckOfferCouponValidityModel> wishList = ApiResponse.loading();
  setCheckOfferCouponValidity(
      ApiResponse<CheckOfferCouponValidityModel> response) {
    wishList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCheckOfferCouponValidityApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setCheckOfferCouponValidity(ApiResponse.loading());
    _myRepo
        .fetchCheckOfferCouponValidityApi(clientId, ipAddress, data)
        .then((value) {
      setCheckOfferCouponValidity(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCheckOfferCouponValidity(ApiResponse.error(error.toString()));
    });
  }
}
