class TermsAndConditionsModel {
  List<ContentList>? contentList;
  bool? status;

  TermsAndConditionsModel({this.contentList, this.status});

  TermsAndConditionsModel.fromJson(Map<String, dynamic> json) {
    if (json['contentList'] != null) {
      contentList = <ContentList>[];
      json['contentList'].forEach((v) {
        contentList!.add(new ContentList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentList != null) {
      data['contentList'] = this.contentList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ContentList {
  int? id;
  ClientDetails? clientDetails;
  String? content;
  String? createdBy;
  String? updatedBy;

  ContentList(
      {this.id,
      this.clientDetails,
      this.content,
      this.createdBy,
      this.updatedBy});

  ContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    content = json['content'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    data['content'] = this.content;
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
