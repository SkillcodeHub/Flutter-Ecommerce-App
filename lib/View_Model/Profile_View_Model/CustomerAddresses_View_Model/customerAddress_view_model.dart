import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/CustomerAddresses_Model/customerAddresses_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/CustomerAddresses_Repository/customerAddresses_repository.dart';
import 'package:flutter/material.dart';

class CustomerAddressesViewmodel with ChangeNotifier {
  final _myRepo = CustomerAddressesRepository();
  ApiResponse<CustomerAddressesModel> customerAddressesList =
      ApiResponse.loading();
  setCustomerAddressesList(ApiResponse<CustomerAddressesModel> response) {
    customerAddressesList = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchCustomerAddressesListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    setCustomerAddressesList(ApiResponse.loading());
    _myRepo
        .fetchCustomerAddressesListApi(clientId, ipAddress, data)
        .then((value) {
      setCustomerAddressesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setCustomerAddressesList(ApiResponse.error(error.toString()));
    });
  }
}
