import 'package:ecommerce/Model/Profile_Repository/CustomerAddresses_Model/customerAddresses_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class CustomerAddressesRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CustomerAddressesModel> fetchCustomerAddressesListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.addressesByCustomerUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = CustomerAddressesModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
