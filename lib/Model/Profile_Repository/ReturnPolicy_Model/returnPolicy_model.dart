class ReturnPolicyModel {
  List<ReturnPolicyContentList>? returnPolicyContentList;
  bool? status;

  ReturnPolicyModel({this.returnPolicyContentList, this.status});

  ReturnPolicyModel.fromJson(Map<String, dynamic> json) {
    if (json['returnPolicyContentList'] != null) {
      returnPolicyContentList = <ReturnPolicyContentList>[];
      json['returnPolicyContentList'].forEach((v) {
        returnPolicyContentList!.add(new ReturnPolicyContentList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.returnPolicyContentList != null) {
      data['returnPolicyContentList'] =
          this.returnPolicyContentList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ReturnPolicyContentList {
  int? id;
  ClientDetails? clientDetails;
  String? policyContent;
  String? createdBy;
  String? updatedBy;

  ReturnPolicyContentList(
      {this.id,
      this.clientDetails,
      this.policyContent,
      this.createdBy,
      this.updatedBy});

  ReturnPolicyContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    policyContent = json['policyContent'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    data['policyContent'] = this.policyContent;
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
