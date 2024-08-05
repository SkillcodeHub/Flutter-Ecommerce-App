import 'package:ecommerce/Model/AllProductList_Model/allProductList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class FilterProductListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<AllProductListModel> fetchFilterProductListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.filterProductListUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = AllProductListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
