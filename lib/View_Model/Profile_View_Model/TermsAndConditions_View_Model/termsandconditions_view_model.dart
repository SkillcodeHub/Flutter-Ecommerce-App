import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/TermsAndConditions_Model/termsAndConditions_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/TermsAndConditions_Repository/termsandconditions_repository.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsViewmodel with ChangeNotifier {
  final _myRepo = TermsAndConditionsRepository();
  ApiResponse<TermsAndConditionsModel> termsAndConditions =
      ApiResponse.loading();
  setTermsAndConditions(ApiResponse<TermsAndConditionsModel> response) {
    termsAndConditions = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchTermsAndConditionsApi(
      String clientId, String ipAddress) async {
    setTermsAndConditions(ApiResponse.loading());
    _myRepo.fetchTermsAndConditionsApi(clientId, ipAddress).then((value) {
      setTermsAndConditions(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setTermsAndConditions(ApiResponse.error(error.toString()));
    });
  }
}
