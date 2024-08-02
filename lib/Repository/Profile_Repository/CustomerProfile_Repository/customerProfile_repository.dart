import 'package:ecommerce/Model/Profile_Repository/CustomerProfile_Model/customerDetailsById_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class CustomerDetailsByIdRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CustomerDetailsByIdModel> fetchCustomerDetailsByIdApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.customerdetailsbycustomeridUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = CustomerDetailsByIdModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
