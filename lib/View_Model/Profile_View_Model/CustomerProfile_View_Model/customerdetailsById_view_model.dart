import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/CustomerProfile_Model/customerDetailsById_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/CustomerProfile_Repository/customerProfile_repository.dart';
import 'package:flutter/material.dart';

class CustomerDetailsByIdViewmodel with ChangeNotifier {
  final _myRepo = CustomerDetailsByIdRepository();
  ApiResponse<CustomerDetailsByIdModel> customerDetailsById =
      ApiResponse.loading();
  setCustomerDetailsById(ApiResponse<CustomerDetailsByIdModel> response) {
    customerDetailsById = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCustomerDetailsByIdApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setCustomerDetailsById(ApiResponse.loading());
    _myRepo
        .fetchCustomerDetailsByIdApi(clientId, ipAddress, data)
        .then((value) {
      setCustomerDetailsById(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCustomerDetailsById(ApiResponse.error(error.toString()));
    });
  }
}
