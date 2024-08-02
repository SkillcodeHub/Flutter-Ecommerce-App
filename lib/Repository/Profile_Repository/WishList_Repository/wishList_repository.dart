import 'package:ecommerce/Model/WishList_Model/wishList_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../../Data/Network/BaseApiServices.dart';
import '../../../Data/Network/NetworkApiService.dart';

class WishListRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<WishListModel> fetchWishListApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.wishlistbycustomerUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = WishListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
