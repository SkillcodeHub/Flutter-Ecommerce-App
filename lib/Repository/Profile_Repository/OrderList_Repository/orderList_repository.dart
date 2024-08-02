import 'package:ecommerce/Model/Profile_Repository/OrderList_Model/orderList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class OrderListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<OrderListModel> fetchOrderListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.orderbycustomerUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = OrderListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
