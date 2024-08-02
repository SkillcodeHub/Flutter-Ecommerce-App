import 'package:ecommerce/Model/ProductDetailById_Model/productDetailById_model.dart';
import 'package:ecommerce/Res/app_url.dart';

import '../../Data/Network/BaseApiServices.dart';
import '../../Data/Network/NetworkApiService.dart';

class ProductDetailByIdRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<ProductDetailByIdModel> fetchProductDetailByIdApi(
      String clientId, String ipAddress, Map<String, String> data) async {
    print('clientId');
    print(clientId);
    print(ipAddress);
    print(data);
    print('clientId');
    try {
      dynamic response = await _apiServices.getPostFormDataApiResponse(
          AppUrl.productdetailsbyproductUrl +
              "?clientId=" +
              clientId.toString() +
              "&ipAddress=" +
              ipAddress,
          data);
      return response = ProductDetailByIdModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
