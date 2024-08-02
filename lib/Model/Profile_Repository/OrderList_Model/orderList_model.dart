class OrderListModel {
  bool? status;
  List<CustomerOrderList>? customerOrderList;

  OrderListModel({this.status, this.customerOrderList});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['customerOrderList'] != null) {
      customerOrderList = <CustomerOrderList>[];
      json['customerOrderList'].forEach((v) {
        customerOrderList!.add(new CustomerOrderList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.customerOrderList != null) {
      data['customerOrderList'] =
          this.customerOrderList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrderList {
  int? id;
  ClientDetails? clientDetails;
  CustomerDetails? customerDetails;
  String? orderNo;
  String? totalAmount;
  String? discountAmount;
  String? grossAmount;
  String? shippingAmount;
  String? netAmount;
  String? orderStatus;
  String? paymentType;
  String? paymentStatus;
  String? transectionId;
  String? orderDate;
  List<Products>? products;

  CustomerOrderList(
      {this.id,
      this.clientDetails,
      this.customerDetails,
      this.orderNo,
      this.totalAmount,
      this.discountAmount,
      this.grossAmount,
      this.shippingAmount,
      this.netAmount,
      this.orderStatus,
      this.paymentType,
      this.paymentStatus,
      this.transectionId,
      this.orderDate,
      this.products});

  CustomerOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    orderNo = json['orderNo'];
    totalAmount = json['totalAmount'];
    discountAmount = json['discountAmount'];
    grossAmount = json['grossAmount'];
    shippingAmount = json['shippingAmount'];
    netAmount = json['netAmount'];
    orderStatus = json['orderStatus'];
    paymentType = json['paymentType'];
    paymentStatus = json['paymentStatus'];
    transectionId = json['transectionId'];
    orderDate = json['orderDate'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
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
    data['orderNo'] = this.orderNo;
    data['totalAmount'] = this.totalAmount;
    data['discountAmount'] = this.discountAmount;
    data['grossAmount'] = this.grossAmount;
    data['shippingAmount'] = this.shippingAmount;
    data['netAmount'] = this.netAmount;
    data['orderStatus'] = this.orderStatus;
    data['paymentType'] = this.paymentType;
    data['paymentStatus'] = this.paymentStatus;
    data['transectionId'] = this.transectionId;
    data['orderDate'] = this.orderDate;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientDetails {
  int? id;
  String? clientName;
  String? companyName;
  String? email;
  String? website;
  String? gstNo;
  String? address;
  String? city;
  String? state;
  String? pincode;

  ClientDetails(
      {this.id,
      this.clientName,
      this.companyName,
      this.email,
      this.website,
      this.gstNo,
      this.address,
      this.city,
      this.state,
      this.pincode});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['clientName'];
    companyName = json['companyName'];
    email = json['email'];
    website = json['website'];
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
    data['email'] = this.email;
    data['website'] = this.website;
    data['gstNo'] = this.gstNo;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    return data;
  }
}

class CustomerDetails {
  int? id;
  String? customerName;
  String? customerEmail;
  String? profileImage;

  CustomerDetails(
      {this.id, this.customerName, this.customerEmail, this.profileImage});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customerName'];
    customerEmail = json['customerEmail'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customerName'] = this.customerName;
    data['customerEmail'] = this.customerEmail;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Products {
  int? id;
  ProductDetail? productDetail;
  VariantDetail? variantDetail;
  String? qty;
  String? unitPrice;
  String? finalAmount;
  String? lastTrackedStatus;
  List<Null>? trackingStatusHistory;

  Products(
      {this.id,
      this.productDetail,
      this.variantDetail,
      this.qty,
      this.unitPrice,
      this.finalAmount,
      this.lastTrackedStatus,
      this.trackingStatusHistory});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productDetail = json['productDetail'] != null
        ? new ProductDetail.fromJson(json['productDetail'])
        : null;
    variantDetail = json['variantDetail'] != null
        ? new VariantDetail.fromJson(json['variantDetail'])
        : null;
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    finalAmount = json['finalAmount'];
    lastTrackedStatus = json['lastTrackedStatus'];
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
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['finalAmount'] = this.finalAmount;
    data['lastTrackedStatus'] = this.lastTrackedStatus;
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
  String? productStock;
  String? sku;
  String? gst;
  bool? isProductHasDiscount;

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
      this.isProductHasDiscount});

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
