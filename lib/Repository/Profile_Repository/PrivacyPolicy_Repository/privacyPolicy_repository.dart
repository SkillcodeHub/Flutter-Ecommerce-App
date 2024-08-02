import 'package:ecommerce/Model/Profile_Repository/PrivacyPolicy_Model/privacyPolicy_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class PrivacyPolicyRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<PrivacyPolicyModel> fetchPrivacyPolicyApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.privacyPolicyUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = PrivacyPolicyModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
