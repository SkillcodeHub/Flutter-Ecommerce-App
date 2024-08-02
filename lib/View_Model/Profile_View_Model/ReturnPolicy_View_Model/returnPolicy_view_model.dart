import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/ReturnPolicy_Model/returnPolicy_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/ReturnPolicy_Repository/returnPolicy_repository.dart';
import 'package:flutter/material.dart';

class ReturnPolicyViewmodel with ChangeNotifier {
  final _myRepo = ReturnPolicyRepository();
  ApiResponse<ReturnPolicyModel> returnPolicy = ApiResponse.loading();
  setReturnPolicy(ApiResponse<ReturnPolicyModel> response) {
    returnPolicy = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchReturnPolicyApi(String clientId, String ipAddress) async {
    setReturnPolicy(ApiResponse.loading());
    _myRepo.fetchReturnPolicyApi(clientId, ipAddress).then((value) {
      setReturnPolicy(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setReturnPolicy(ApiResponse.error(error.toString()));
    });
  }
}
