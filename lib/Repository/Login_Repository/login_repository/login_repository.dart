import 'package:ecommerce/Data/Network/BaseApiServices.dart';
import 'package:ecommerce/Res/app_url.dart';
import 'package:ecommerce/Utils/utils.dart';

import '../../../Data/Network/NetworkApiService.dart';

class LoginRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginapi(Map<String, String> data) async {
    print(data.toString());

    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.loginUrl + "?clientId=" + ClientId + "&ipAddress=" + IpAddress,
          data);

      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerapi(Map<String, String> data) async {
    print(data.toString());

    try {
      dynamic response = await _apiServices.getPostWithoutTokenApiResponse(
          AppUrl.signupUrl + "?ipAddress=192.168.0.1", data);
      print(response);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
