class OrderdetailbyorderedproductModel {
  bool? status;
  List<OrderedProductList>? orderedProductList;

  OrderdetailbyorderedproductModel({this.status, this.orderedProductList});

  OrderdetailbyorderedproductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['orderedProductList'] != null) {
      orderedProductList = <OrderedProductList>[];
      json['orderedProductList'].forEach((v) {
        orderedProductList!.add(new OrderedProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.orderedProductList != null) {
      data['orderedProductList'] =
          this.orderedProductList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderedProductList {
  int? id;
  ClientDetails? clientDetails;
  OrderDetails? orderDetails;
  CustomerDetails? customerDetails;
  ProductDetails? productDetails;
  String? qty;
  String? unitPrice;
  String? finalAmount;
  String? lastTrackedStatus;
  List<ShippingAddress>? shippingAddress;
  List<TrackingStatusHistory>? trackingStatusHistory;

  OrderedProductList(
      {this.id,
      this.clientDetails,
      this.orderDetails,
      this.customerDetails,
      this.productDetails,
      this.qty,
      this.unitPrice,
      this.finalAmount,
      this.lastTrackedStatus,
      this.shippingAddress,
      this.trackingStatusHistory});

  OrderedProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    orderDetails = json['orderDetails'] != null
        ? new OrderDetails.fromJson(json['orderDetails'])
        : null;
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    productDetails = json['productDetails'] != null
        ? new ProductDetails.fromJson(json['productDetails'])
        : null;
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    finalAmount = json['finalAmount'];
    lastTrackedStatus = json['lastTrackedStatus'];
    if (json['shippingAddress'] != null) {
      shippingAddress = <ShippingAddress>[];
      json['shippingAddress'].forEach((v) {
        shippingAddress!.add(new ShippingAddress.fromJson(v));
      });
    }
    if (json['trackingStatusHistory'] != null) {
      trackingStatusHistory = <TrackingStatusHistory>[];
      json['trackingStatusHistory'].forEach((v) {
        trackingStatusHistory!.add(new TrackingStatusHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.clientDetails != null) {
      data['clientDetails'] = this.clientDetails!.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.toJson();
    }
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails!.toJson();
    }
    if (this.productDetails != null) {
      data['productDetails'] = this.productDetails!.toJson();
    }
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['finalAmount'] = this.finalAmount;
    data['lastTrackedStatus'] = this.lastTrackedStatus;
    if (this.shippingAddress != null) {
      data['shippingAddress'] =
          this.shippingAddress!.map((v) => v.toJson()).toList();
    }
    if (this.trackingStatusHistory != null) {
      data['trackingStatusHistory'] =
          this.trackingStatusHistory!.map((v) => v.toJson()).toList();
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
  String? city;
  String? state;
  String? pincode;

  ClientDetails(
      {this.id,
      this.clientName,
      this.companyName,
      this.gstNo,
      this.address,
      this.city,
      this.state,
      this.pincode});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['clientName'];
    companyName = json['companyName'];
    gstNo = json['gstNo'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientName'] = this.clientName;
    data['companyName'] = this.companyName;
    data['gstNo'] = this.gstNo;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}

class OrderDetails {
  int? id;
  String? orderNo;
  String? totalAmount;
  Null? discountAmount;
  Null? grossAmount;
  String? shippingAmount;
  Null? taxableAmount;
  String? netAmount;
  String? orderStatus;
  String? paymentType;
  String? paymentStatus;
  String? transectionId;
  String? orderDate;

  OrderDetails(
      {this.id,
      this.orderNo,
      this.totalAmount,
      this.discountAmount,
      this.grossAmount,
      this.shippingAmount,
      this.taxableAmount,
      this.netAmount,
      this.orderStatus,
      this.paymentType,
      this.paymentStatus,
      this.transectionId,
      this.orderDate});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['orderNo'];
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    grossAmount = json['grossAmount'];
    shippingAmount = json['shippingAmount'];
    taxableAmount = json['taxableAmount'];
    netAmount = json['netAmount'];
    orderStatus = json['orderStatus'];
    paymentType = json['paymentType'];
    paymentStatus = json['paymentStatus'];
    transectionId = json['transectionId'];
    orderDate = json['orderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderNo'] = this.orderNo;
    data['totalAmount'] = this.totalAmount;
    data['discountAmount'] = this.discountAmount;
    data['grossAmount'] = this.grossAmount;
    data['shippingAmount'] = this.shippingAmount;
    data['taxableAmount'] = this.taxableAmount;
    data['netAmount'] = this.netAmount;
    data['orderStatus'] = this.orderStatus;
    data['paymentType'] = this.paymentType;
    data['paymentStatus'] = this.paymentStatus;
    data['transectionId'] = this.transectionId;
    data['orderDate'] = this.orderDate;
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

class ProductDetails {
  int? id;
  ProductDetail? productDetail;
  VariantDetail? variantDetail;

  ProductDetails({this.id, this.productDetail, this.variantDetail});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productDetail = json['productDetail'] != null
        ? new ProductDetail.fromJson(json['productDetail'])
        : null;
    variantDetail = json['variantDetail'] != null
        ? new VariantDetail.fromJson(json['variantDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetail != null) {
      data['productDetail'] = this.productDetail!.toJson();
    }
    if (this.variantDetail != null) {
      data['variantDetail'] = this.variantDetail!.toJson();
    }
    return data;
  }
}

class ProductDetail {
  int? id;
  MainCategoryDetails? mainCategoryDetails;
  MainCategoryDetails? categoryDetails;
  MainCategoryDetails? subCategoryDetails;
  String? productname;
  String? productDescription;
  String? productShortDescription;
  String? saleStartsAt;
  String? minSalePrice;
  String? stockStatus;
  String? isQualityRuleApply;
  String? minQuantity;
  String? maxQuantity;
  String? outofstockSelling;
  Null? productStock;
  String? sku;
  Null? gst;
  bool? isProductHasDiscount;
  String? productStatus;
  String? publishStatus;
  Null? activationDate;
  Null? publishTime;
  Null? isDiscountApplicable;
  Null? discountedPercentage;

  ProductDetail(
      {this.id,
      this.mainCategoryDetails,
      this.categoryDetails,
      this.subCategoryDetails,
      this.productname,
      this.productDescription,
      this.productShortDescription,
      this.saleStartsAt,
      this.minSalePrice,
      this.stockStatus,
      this.isQualityRuleApply,
      this.minQuantity,
      this.maxQuantity,
      this.outofstockSelling,
      this.productStock,
      this.sku,
      this.gst,
      this.isProductHasDiscount,
      this.productStatus,
      this.publishStatus,
      this.activationDate,
      this.publishTime,
      this.isDiscountApplicable,
      this.discountedPercentage});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryDetails = json['mainCategoryDetails'] != null
        ? new MainCategoryDetails.fromJson(json['mainCategoryDetails'])
        : null;
    categoryDetails = json['categoryDetails'] != null
        ? new MainCategoryDetails.fromJson(json['categoryDetails'])
        : null;
    subCategoryDetails = json['subCategoryDetails'] != null
        ? new MainCategoryDetails.fromJson(json['subCategoryDetails'])
        : null;
    productname = json['productname'];
    productDescription = json['productDescription'];
    productShortDescription = json['productShortDescription'];
    saleStartsAt = json['saleStartsAt'];
    minSalePrice = json['minSalePrice'];
    stockStatus = json['stockStatus'];
    isQualityRuleApply = json['isQualityRuleApply'];
    minQuantity = json['minQuantity'];
    maxQuantity = json['maxQuantity'];
    outofstockSelling = json['outofstockSelling'];
    productStock = json['productStock'];
    sku = json['sku'];
    gst = json['gst'];
    isProductHasDiscount = json['isProductHasDiscount'];
    productStatus = json['productStatus'];
    publishStatus = json['publishStatus'];
    activationDate = json['activationDate'];
    publishTime = json['publishTime'];
    isDiscountApplicable = json['isDiscountApplicable'];
    discountedPercentage = json['discountedPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.mainCategoryDetails != null) {
      data['mainCategoryDetails'] = this.mainCategoryDetails!.toJson();
    }
    if (this.categoryDetails != null) {
      data['categoryDetails'] = this.categoryDetails!.toJson();
    }
    if (this.subCategoryDetails != null) {
      data['subCategoryDetails'] = this.subCategoryDetails!.toJson();
    }
    data['productname'] = this.productname;
    data['productDescription'] = this.productDescription;
    data['productShortDescription'] = this.productShortDescription;
    data['saleStartsAt'] = this.saleStartsAt;
    data['minSalePrice'] = this.minSalePrice;
    data['stockStatus'] = this.stockStatus;
    data['isQualityRuleApply'] = this.isQualityRuleApply;
    data['minQuantity'] = this.minQuantity;
    data['maxQuantity'] = this.maxQuantity;
    data['outofstockSelling'] = this.outofstockSelling;
    data['productStock'] = this.productStock;
    data['sku'] = this.sku;
    data['gst'] = this.gst;
    data['isProductHasDiscount'] = this.isProductHasDiscount;
    data['productStatus'] = this.productStatus;
    data['publishStatus'] = this.publishStatus;
    data['activationDate'] = this.activationDate;
    data['publishTime'] = this.publishTime;
    data['isDiscountApplicable'] = this.isDiscountApplicable;
    data['discountedPercentage'] = this.discountedPercentage;
    return data;
  }
}

class MainCategoryDetails {
  int? id;
  String? mainCategoryName;

  MainCategoryDetails({this.id, this.mainCategoryName});

  MainCategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mainCategoryName = json['mainCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mainCategoryName'] = this.mainCategoryName;
    return data;
  }
}

class VariantDetail {
  int? id;
  String? variantkey;
  String? price;
  String? stock;
  String? variantImage;
  String? variantImageGallery;

  VariantDetail(
      {this.id,
      this.variantkey,
      this.price,
      this.stock,
      this.variantImage,
      this.variantImageGallery});

  VariantDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variantkey = json['variantkey'];
    price = json['price'];
    stock = json['stock'];
    variantImage = json['variantImage'];
    variantImageGallery = json['variantImageGallery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variantkey'] = this.variantkey;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['variantImage'] = this.variantImage;
    data['variantImageGallery'] = this.variantImageGallery;
    return data;
  }
}

class ShippingAddress {
  int? id;
  String? customerAddress;
  String? customerCity;
  String? customerState;
  String? customerPincode;
  String? customerCountry;

  ShippingAddress(
      {this.id,
      this.customerAddress,
      this.customerCity,
      this.customerState,
      this.customerPincode,
      this.customerCountry});

  ShippingAddress.fromJson(Map<String, dynamic> json) {
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

class TrackingStatusHistory {
  int? id;
  String? trackingStatus;
  String? updateStatusDate;

  TrackingStatusHistory({this.id, this.trackingStatus, this.updateStatusDate});

  TrackingStatusHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trackingStatus = json['trackingStatus'];
    updateStatusDate = json['updateStatusDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trackingStatus'] = this.trackingStatus;
    data['updateStatusDate'] = this.updateStatusDate;
    return data;
  }
}
