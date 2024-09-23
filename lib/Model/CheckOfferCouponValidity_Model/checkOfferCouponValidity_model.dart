class CheckOfferCouponValidityModel {
  String? message;
  String? discountType;
  String? discountValue;
  bool? status;

  CheckOfferCouponValidityModel(
      {this.message, this.discountType, this.discountValue, this.status});

  CheckOfferCouponValidityModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    discountType = json['discountType'];
    discountValue = json['discountValue'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['discountType'] = this.discountType;
    data['discountValue'] = this.discountValue;
    data['status'] = this.status;
    return data;
  }
}
