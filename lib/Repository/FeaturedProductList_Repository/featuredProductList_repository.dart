import 'package:ecommerce/Model/FeaturedProductList_Model/featuredProductList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class FeaturedProductListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<FeaturedProductListModel> fetchFeaturedProductListApi(
      String clientId, String ipAddress) async {
    print('clientId');
    print(clientId);
    print('clientId');
    try {
      dynamic response = await _apiServices.getGetWithoutTokenApiResponse(
          AppUrl.featuredProductListUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress);
      return response = FeaturedProductListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
