import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderdetailbyorderedproduct_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class OrderdetailbyorderedproductRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<OrderdetailbyorderedproductModel> fetchOrderdetailbyorderedproductApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.orderdetailbyorderedproductUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = OrderdetailbyorderedproductModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
