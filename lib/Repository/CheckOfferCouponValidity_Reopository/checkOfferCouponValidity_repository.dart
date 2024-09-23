import 'package:ecommerce/Model/CheckOfferCouponValidity_Model/checkOfferCouponValidity_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class CheckOfferCouponValidityRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CheckOfferCouponValidityModel> fetchCheckOfferCouponValidityApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.wishlistbycustomerUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = CheckOfferCouponValidityModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
