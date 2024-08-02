class CartListModel {
  bool? status;
  List<CartList>? cartList;

  CartListModel({this.status, this.cartList});

  CartListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cartList'] != null) {
      cartList = <CartList>[];
      json['cartList'].forEach((v) {
        cartList!.add(new CartList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cartList != null) {
      data['cartList'] = this.cartList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartList {
  int? id;
  ClientDetails? clientDetails;
  CustomerDetails? customerDetails;
  ProductDetails? productDetails;
  AttributeDetails? attributeDetails;
  VariantDetails? variantDetails;
  String? qty;

  CartList(
      {this.id,
      this.clientDetails,
      this.customerDetails,
      this.productDetails,
      this.attributeDetails,
      this.variantDetails,
      this.qty});

  CartList.fromJson(Map<String, dynamic> json) {
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
    attributeDetails = json['attributeDetails'] != null
        ? new AttributeDetails.fromJson(json['attributeDetails'])
        : null;
    variantDetails = json['variantDetails'] != null
        ? new VariantDetails.fromJson(json['variantDetails'])
        : null;
    qty = json['qty'];
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
    if (this.attributeDetails != null) {
      data['attributeDetails'] = this.attributeDetails!.toJson();
    }
    if (this.variantDetails != null) {
      data['variantDetails'] = this.variantDetails!.toJson();
    }
    data['qty'] = this.qty;
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
  String? productStock;
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
    data['productStock'] = this.productStock;
    data['sku'] = this.sku;
    return data;
  }
}

class AttributeDetails {
  int? id;
  String? name;
  String? value;

  AttributeDetails({this.id, this.name, this.value});

  AttributeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

class VariantDetails {
  int? id;
  String? variantkey;
  String? price;
  String? stock;
  String? variantImage;

  VariantDetails(
      {this.id, this.variantkey, this.price, this.stock, this.variantImage});

  VariantDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    variantkey = json['variantkey'];
    price = json['price'];
    stock = json['stock'];
    variantImage = json['variantImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['variantkey'] = this.variantkey;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['variantImage'] = this.variantImage;
    return data;
  }
}
