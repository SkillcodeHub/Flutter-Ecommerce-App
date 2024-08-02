import 'package:ecommerce/Data/Response/api_response.dart';
import 'package:ecommerce/Model/Profile_Repository/RefundPolicy_Model/refundPolicy_model.dart';
import 'package:ecommerce/Repository/Profile_Repository/RefundPolicy_Repository/refundPolicy_repository.dart';
import 'package:flutter/foundation.dart';

class RefundPolicyViewmodel with ChangeNotifier {
  final _myRepo = RefundPolicyRepository();
  ApiResponse<RefundPolicyModel> refundPolicy = ApiResponse.loading();
  setRefundPolicy(ApiResponse<RefundPolicyModel> response) {
    refundPolicy = response;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> fetchRefundPolicyApi(String clientId, String ipAddress) async {
    setRefundPolicy(ApiResponse.loading());
    _myRepo.fetchRefundPolicyApi(clientId, ipAddress).then((value) {
      setRefundPolicy(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setRefundPolicy(ApiResponse.error(error.toString()));
    });
  }
}
