import 'package:ecommerce/Model/Profile_Repository/TermsAndConditions_Model/termsAndConditions_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class TermsAndConditionsRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<TermsAndConditionsModel> fetchTermsAndConditionsApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.termsAndConditionsUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = TermsAndConditionsModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
