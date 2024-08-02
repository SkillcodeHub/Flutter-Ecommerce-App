import 'package:ecommerce/Model/Profile_Repository/ReturnPolicy_Model/returnPolicy_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class ReturnPolicyRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ReturnPolicyModel> fetchReturnPolicyApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.returnpolicyUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = ReturnPolicyModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
