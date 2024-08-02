import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/PrivacyPolicy_Model/privacyPolicy_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/PrivacyPolicy_Repository/privacyPolicy_repository.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyViewmodel with ChangeNotifier {
  final _myRepo = PrivacyPolicyRepository();
  ApiResponse<PrivacyPolicyModel> privacyPolicy = ApiResponse.loading();
  setPrivacyPolicy(ApiResponse<PrivacyPolicyModel> response) {
    privacyPolicy = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchPrivacyPolicyApi(String clientId, String ipAddress) async {
    setPrivacyPolicy(ApiResponse.loading());
    _myRepo.fetchPrivacyPolicyApi(clientId, ipAddress).then((value) {
      setPrivacyPolicy(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setPrivacyPolicy(ApiResponse.error(error.toString()));
    });
  }
}
