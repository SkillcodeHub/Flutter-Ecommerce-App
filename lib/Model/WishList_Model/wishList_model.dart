class WishListModel {
  bool? status;
  List<WishList>? wishList;

  WishListModel({this.status, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['wishList'] != null) {
      wishList = <WishList>[];
      json['wishList'].forEach((v) {
        wishList!.add(new WishList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.wishList != null) {
      data['wishList'] = this.wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WishList {
  int? id;
  ClientDetails? clientDetails;
  CustomerDetails? customerDetails;
  ProductDetails? productDetails;

  WishList(
      {this.id, this.clientDetails, this.customerDetails, this.productDetails});

  WishList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    productDetails = json['productDetails'] != null
        ? new ProductDetails.fromJson(json['productDetails'])
        : null;
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
    if (this.productDetails != null) {
      data['productDetails'] = this.productDetails!.toJson();
    }
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

  CustomerDetails({this.id, this.customerName, this.customerEmail});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    return data;
  }
}

class ProductDetails {
  int? id;
  int? mainCategoryId;
  String? mainCategoryName;
  int? categoryId;
  String? categoryName;
  int? subCategoryId;
  String? subCategoryName;
  String? productName;
  String? productDescription;
  String? productShortDescription;
  String? productPrice;
  String? productGallery;
  Null? productStock;
  String? sku;

  ProductDetails(
      {this.id,
      this.mainCategoryId,
      this.mainCategoryName,
      this.categoryId,
      this.categoryName,
      this.subCategoryId,
      this.subCategoryName,
      this.productName,
      this.productDescription,
      this.productShortDescription,
      this.productPrice,
      this.productGallery,
      this.productStock,
      this.sku});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryId = json['mainCategoryId'];
    mainCategoryName = json['mainCategoryName'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productShortDescription = json['productShortDescription'];
    productPrice = json['productPrice'];
    productGallery = json['productGallery'];
    productStock = json['productStock'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mainCategoryId'] = this.mainCategoryId;
    data['mainCategoryName'] = this.mainCategoryName;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['subCategoryId'] = this.subCategoryId;
    data['subCategoryName'] = this.subCategoryName;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productShortDescription'] = this.productShortDescription;
    data['productPrice'] = this.productPrice;
    data['productGallery'] = this.productGallery;
    data['productStock'] = this.productStock;
    data['sku'] = this.sku;
    return data;
  }
}
