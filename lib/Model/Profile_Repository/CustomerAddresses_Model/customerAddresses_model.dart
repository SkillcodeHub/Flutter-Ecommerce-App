class CustomerAddressesModel {
  bool? status;
  List<AddressList>? addressList;

  CustomerAddressesModel({this.status, this.addressList});

  CustomerAddressesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['addressList'] != null) {
      addressList = <AddressList>[];
      json['addressList'].forEach((v) {
        addressList!.add(new AddressList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.addressList != null) {
      data['addressList'] = this.addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressList {
  int? id;
  ClientDetails? clientDetails;
  CustomerDetails? customerDetails;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  String? customerPincode;
  String? customerCountry;

  AddressList(
      {this.id,
      this.clientDetails,
      this.customerDetails,
      this.customerAddress,
      this.customerCity,
      this.customerState,
      this.customerPincode,
      this.customerCountry});

  AddressList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    customerAddress = json['customerAddress'];
    customerCity = json['customerCity'];
    customerState = json['customerState'];
    customerPincode = json['customerPincode'];
    customerCountry = json['customerCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails!.toJson();
    }
    data['customerAddress'] = this.customerAddress;
    data['customerCity'] = this.customerCity;
    data['customerState'] = this.customerState;
    data['customerPincode'] = this.customerPincode;
    data['customerCountry'] = this.customerCountry;
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

class CustomerDetails {
  int? id;
  String? customerName;
  String? customerEmail;
  String? profileImage;
  String? customerMobile;
  Null? customerAlterMobile;

  CustomerDetails(
      {this.id,
      this.customerName,
      this.customerEmail,
      this.profileImage,
      this.customerMobile,
      this.customerAlterMobile});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    profileImage = json['profileImage'];
    customerMobile = json['customerMobile'];
    customerAlterMobile = json['customerAlterMobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['profileImage'] = this.profileImage;
    data['customerMobile'] = this.customerMobile;
    data['customerAlterMobile'] = this.customerAlterMobile;
    return data;
  }
}
