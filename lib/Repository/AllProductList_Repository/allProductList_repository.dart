import 'package:ecommerce/Model/AllProductList_Model/allProductList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class AllProductListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<AllProductListModel> fetchAllProductListApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.allProductListUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = AllProductListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
