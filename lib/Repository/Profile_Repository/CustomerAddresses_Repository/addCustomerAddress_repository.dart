import 'package:ecommerce/Data/Network/BaseApiServices.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/NetworkApiService.dart';

class AddCustomerAddressRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> addCustomerAddressapi(
      String ipAddress, Map<String, String> data) async {
    print(data.toString());

    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.addcustomerAddressUrl + "?ipAddress=" + ipAddress, data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
