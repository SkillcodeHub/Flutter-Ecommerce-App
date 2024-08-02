class PrivacyPolicyModel {
  List<PrivacyPolicyContentList>? privacyPolicyContentList;
  bool? status;

  PrivacyPolicyModel({this.privacyPolicyContentList, this.status});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    if (json['privacyPolicyContentList'] != null) {
      privacyPolicyContentList = <PrivacyPolicyContentList>[];
      json['privacyPolicyContentList'].forEach((v) {
        privacyPolicyContentList!.add(new PrivacyPolicyContentList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.privacyPolicyContentList != null) {
      data['privacyPolicyContentList'] =
          this.privacyPolicyContentList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class PrivacyPolicyContentList {
  int? id;
  ClientDetails? clientDetails;
  String? privacyPolicyContent;
  String? createdBy;
  String? updatedBy;

  PrivacyPolicyContentList(
      {this.id,
      this.clientDetails,
      this.privacyPolicyContent,
      this.createdBy,
      this.updatedBy});

  PrivacyPolicyContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    privacyPolicyContent = json['privacyPolicyContent'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    data['privacyPolicyContent'] = this.privacyPolicyContent;
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
