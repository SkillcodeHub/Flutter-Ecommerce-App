import 'package:ecommerce/Model/cartList_Model/cartList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class CartListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<CartListModel> fetchCartListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.cartListUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = CartListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
