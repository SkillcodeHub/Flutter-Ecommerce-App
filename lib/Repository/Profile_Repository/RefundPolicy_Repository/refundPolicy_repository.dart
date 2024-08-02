import 'package:ecommerce/Model/Profile_Repository/RefundPolicy_Model/refundPolicy_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class RefundPolicyRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<RefundPolicyModel> fetchRefundPolicyApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.refundPolicyUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = RefundPolicyModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
