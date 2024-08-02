class RefundPolicyModel {
  List<RefundPolicyContentList>? refundPolicyContentList;
  bool? status;

  RefundPolicyModel({this.refundPolicyContentList, this.status});

  RefundPolicyModel.fromJson(Map<String, dynamic> json) {
    if (json['refundPolicyContentList'] != null) {
      refundPolicyContentList = <RefundPolicyContentList>[];
      json['refundPolicyContentList'].forEach((v) {
        refundPolicyContentList!.add(new RefundPolicyContentList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.refundPolicyContentList != null) {
      data['refundPolicyContentList'] =
          this.refundPolicyContentList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class RefundPolicyContentList {
  int? id;
  ClientDetails? clientDetails;
  String? refundPolicyContent;
  String? createdBy;
  String? updatedBy;

  RefundPolicyContentList(
      {this.id,
      this.clientDetails,
      this.refundPolicyContent,
      this.createdBy,
      this.updatedBy});

  RefundPolicyContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    refundPolicyContent = json['refundPolicyContent'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    data['refundPolicyContent'] = this.refundPolicyContent;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}

class ClientDetails {
  int? id;
  String? clientName;
  String? companyName;
  String? gstNo;
  String? address;

  ClientDetails(
      {this.id, this.clientName, this.companyName, this.gstNo, this.address});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['clientName'];
    companyName = json['companyName'];
    gstNo = json['gstNo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientName'] = this.clientName;
    data['companyName'] = this.companyName;
    data['gstNo'] = this.gstNo;
    data['address'] = this.address;
    return data;
  }
}
