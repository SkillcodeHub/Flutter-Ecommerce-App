class CustomerDetailsByIdModel {
  bool? status;
  List<CustomerList>? customerList;

  CustomerDetailsByIdModel({this.status, this.customerList});

  CustomerDetailsByIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['customerList'] != null) {
      customerList = <CustomerList>[];
      json['customerList'].forEach((v) {
        customerList!.add(new CustomerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.customerList != null) {
      data['customerList'] = this.customerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerList {
  int? id;
  ClientDetails? clientDetails;
  String? customerName;
  String? customerEmail;
  String? customerMobile;
  String? customerAlterMobile;
  String? profileImage;
  List<CustomrAddresses>? customrAddresses;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  CustomerList(
      {this.id,
      this.clientDetails,
      this.customerName,
      this.customerEmail,
      this.customerMobile,
      this.customerAlterMobile,
      this.profileImage,
      this.customrAddresses,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  CustomerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    customerMobile = json['customerMobile'];
    customerAlterMobile = json['customerAlterMobile'];
    profileImage = json['profileImage'];
    if (json['customrAddresses'] != null) {
      customrAddresses = <CustomrAddresses>[];
      json['customrAddresses'].forEach((v) {
        customrAddresses!.add(new CustomrAddresses.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['customerMobile'] = this.customerMobile;
    data['customerAlterMobile'] = this.customerAlterMobile;
    data['profileImage'] = this.profileImage;
    if (this.customrAddresses != null) {
      data['customrAddresses'] =
          this.customrAddresses!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

class CustomrAddresses {
  int? id;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  String? customerPincode;
  String? customerCountry;

  CustomrAddresses(
      {this.id,
      this.customerAddress,
      this.customerCity,
      this.customerState,
      this.customerPincode,
      this.customerCountry});

  CustomrAddresses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerAddress = json['customerAddress'];
    customerCity = json['customerCity'];
    customerState = json['customerState'];
    customerPincode = json['customerPincode'];
    customerCountry = json['customerCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerAddress'] = this.customerAddress;
    data['customerCity'] = this.customerCity;
    data['customerState'] = this.customerState;
    data['customerPincode'] = this.customerPincode;
    data['customerCountry'] = this.customerCountry;
    return data;
  }
}
