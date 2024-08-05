class AllProductListModel {
  List<ProductList>? productList;
  bool? status;

  AllProductListModel({this.productList, this.status});

  AllProductListModel.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class ProductList {
  int? id;
  ClientDetails? clientDetails;
  VendorDetails? vendorDetails;
  MainCategoryDetails? mainCategoryDetails;
  CategoryDetails? categoryDetails;
  SubCategoryDetails? subCategoryDetails;
  String? productName;
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
  String? isFeaturedProduct;
  String? isTopSellingProduct;
  String? productGallery;
  String? productStatus;
  String? publishStatus;
  String? activationDate;
  String? publishTime;
  String? isDiscountApplicable;
  String? discountedPercentage;
  List<RelatedProducts>? relatedProducts;
  List<Attributes>? attributes;
  List<Variants>? variants;
  List<Null>? technicalDetails;
  List<AdditionalInformation>? additionalInformation;
  List<UserRatingsDetails>? userRatingsDetails;
  List<AverageRatingsDetails>? averageRatingsDetails;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  ProductList(
      {this.id,
      this.clientDetails,
      this.vendorDetails,
      this.mainCategoryDetails,
      this.categoryDetails,
      this.subCategoryDetails,
      this.productName,
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
      this.isFeaturedProduct,
      this.isTopSellingProduct,
      this.productGallery,
      this.productStatus,
      this.publishStatus,
      this.activationDate,
      this.publishTime,
      this.isDiscountApplicable,
      this.discountedPercentage,
      this.relatedProducts,
      this.attributes,
      this.variants,
      this.technicalDetails,
      this.additionalInformation,
      this.userRatingsDetails,
      this.averageRatingsDetails,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientDetails = json['clientDetails'] != null
        ? new ClientDetails.fromJson(json['clientDetails'])
        : null;
    vendorDetails = json['vendorDetails'] != null
        ? new VendorDetails.fromJson(json['vendorDetails'])
        : null;
    mainCategoryDetails = json['mainCategoryDetails'] != null
        ? new MainCategoryDetails.fromJson(json['mainCategoryDetails'])
        : null;
    categoryDetails = json['categoryDetails'] != null
        ? new CategoryDetails.fromJson(json['categoryDetails'])
        : null;
    subCategoryDetails = json['subCategoryDetails'] != null
        ? new SubCategoryDetails.fromJson(json['subCategoryDetails'])
        : null;
    productName = json['productName'];
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
    isFeaturedProduct = json['isFeaturedProduct'];
    isTopSellingProduct = json['isTopSellingProduct'];
    productGallery = json['productGallery'];
    productStatus = json['productStatus'];
    publishStatus = json['publishStatus'];
    activationDate = json['activationDate'];
    publishTime = json['publishTime'];
    isDiscountApplicable = json['isDiscountApplicable'];
    discountedPercentage = json['discountedPercentage'];
    if (json['related_products'] != null) {
      relatedProducts = <RelatedProducts>[];
      json['related_products'].forEach((v) {
        relatedProducts!.add(new RelatedProducts.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
    if (json['additionalInformation'] != null) {
      additionalInformation = <AdditionalInformation>[];
      json['additionalInformation'].forEach((v) {
        additionalInformation!.add(new AdditionalInformation.fromJson(v));
      });
    }
    if (json['userRatingsDetails'] != null) {
      userRatingsDetails = <UserRatingsDetails>[];
      json['userRatingsDetails'].forEach((v) {
        userRatingsDetails!.add(new UserRatingsDetails.fromJson(v));
      });
    }
    if (json['averageRatingsDetails'] != null) {
      averageRatingsDetails = <AverageRatingsDetails>[];
      json['averageRatingsDetails'].forEach((v) {
        averageRatingsDetails!.add(new AverageRatingsDetails.fromJson(v));
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
    if (this.vendorDetails != null) {
      data['vendorDetails'] = this.vendorDetails!.toJson();
    }
    if (this.mainCategoryDetails != null) {
      data['mainCategoryDetails'] = this.mainCategoryDetails!.toJson();
    }
    if (this.categoryDetails != null) {
      data['categoryDetails'] = this.categoryDetails!.toJson();
    }
    if (this.subCategoryDetails != null) {
      data['subCategoryDetails'] = this.subCategoryDetails!.toJson();
    }
    data['productName'] = this.productName;
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
    data['isFeaturedProduct'] = this.isFeaturedProduct;
    data['isTopSellingProduct'] = this.isTopSellingProduct;
    data['productGallery'] = this.productGallery;
    data['productStatus'] = this.productStatus;
    data['publishStatus'] = this.publishStatus;
    data['activationDate'] = this.activationDate;
    data['publishTime'] = this.publishTime;
    data['isDiscountApplicable'] = this.isDiscountApplicable;
    data['discountedPercentage'] = this.discountedPercentage;
    if (this.relatedProducts != null) {
      data['related_products'] =
          this.relatedProducts!.map((v) => v.toJson()).toList();
    }
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    }
    if (this.variants != null) {
      data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    }
    if (this.additionalInformation != null) {
      data['additionalInformation'] =
          this.additionalInformation!.map((v) => v.toJson()).toList();
    }
    if (this.userRatingsDetails != null) {
      data['userRatingsDetails'] =
          this.userRatingsDetails!.map((v) => v.toJson()).toList();
    }
    if (this.averageRatingsDetails != null) {
      data['averageRatingsDetails'] =
          this.averageRatingsDetails!.map((v) => v.toJson()).toList();
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

class VendorDetails {
  int? id;
  String? vendorName;
  String? vendorStore;

  VendorDetails({this.id, this.vendorName, this.vendorStore});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendorName'];
    vendorStore = json['vendorStore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendorName'] = this.vendorName;
    data['vendorStore'] = this.vendorStore;
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

class CategoryDetails {
  int? id;
  String? categoryName;

  CategoryDetails({this.id, this.categoryName});

  CategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    return data;
  }
}

class SubCategoryDetails {
  int? id;
  String? subCategoryName;

  SubCategoryDetails({this.id, this.subCategoryName});

  SubCategoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryName = json['subCategoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subCategoryName'] = this.subCategoryName;
    return data;
  }
}

class RelatedProducts {
  int? id;
  String? productName;
  String? productDescription;
  String? productShortDescription;
  String? productPrice;
  String? productStock;
  String? minSalePrice;
  String? stockStatus;
  String? isQualityRuleApply;
  String? minQuantity;
  String? maxQuantity;
  String? outofstockSelling;
  String? sku;
  String? gst;

  RelatedProducts(
      {this.id,
      this.productName,
      this.productDescription,
      this.productShortDescription,
      this.productPrice,
      this.productStock,
      this.minSalePrice,
      this.stockStatus,
      this.isQualityRuleApply,
      this.minQuantity,
      this.maxQuantity,
      this.outofstockSelling,
      this.sku,
      this.gst});

  RelatedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productShortDescription = json['productShortDescription'];
    productPrice = json['productPrice'];
    productStock = json['productStock'];
    minSalePrice = json['minSalePrice'];
    stockStatus = json['stockStatus'];
    isQualityRuleApply = json['isQualityRuleApply'];
    minQuantity = json['minQuantity'];
    maxQuantity = json['maxQuantity'];
    outofstockSelling = json['outofstockSelling'];
    sku = json['sku'];
    gst = json['gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productShortDescription'] = this.productShortDescription;
    data['productPrice'] = this.productPrice;
    data['productStock'] = this.productStock;
    data['minSalePrice'] = this.minSalePrice;
    data['stockStatus'] = this.stockStatus;
    data['isQualityRuleApply'] = this.isQualityRuleApply;
    data['minQuantity'] = this.minQuantity;
    data['maxQuantity'] = this.maxQuantity;
    data['outofstockSelling'] = this.outofstockSelling;
    data['sku'] = this.sku;
    data['gst'] = this.gst;
    return data;
  }
}

class Attributes {
  int? id;
  String? name;
  String? value;

  Attributes({this.id, this.name, this.value});

  Attributes.fromJson(Map<String, dynamic> json) {
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

class Variants {
  int? id;
  Attributes? attributeDetails;
  String? variantkey;
  String? price;
  String? stock;
  String? variantImage;
  String? variantImageGallery;

  Variants(
      {this.id,
      this.attributeDetails,
      this.variantkey,
      this.price,
      this.stock,
      this.variantImage,
      this.variantImageGallery});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributeDetails = json['attributeDetails'] != null
        ? new Attributes.fromJson(json['attributeDetails'])
        : null;
    variantkey = json['variantkey'];
    price = json['price'];
    stock = json['stock'];
    variantImage = json['variantImage'];
    variantImageGallery = json['variantImageGallery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributeDetails != null) {
      data['attributeDetails'] = this.attributeDetails!.toJson();
    }
    data['variantkey'] = this.variantkey;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['variantImage'] = this.variantImage;
    data['variantImageGallery'] = this.variantImageGallery;
    return data;
  }
}

class AdditionalInformation {
  int? id;
  ProductDetails? productDetails;
  String? title;
  String? value;

  AdditionalInformation({this.id, this.productDetails, this.title, this.value});

  AdditionalInformation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productDetails = json['productDetails'] != null
        ? new ProductDetails.fromJson(json['productDetails'])
        : null;
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productDetails != null) {
      data['productDetails'] = this.productDetails!.toJson();
    }
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}

class ProductDetails {
  int? id;
  String? productName;
  String? productDescription;
  String? productShortDescription;
  String? productPrice;
  String? productStock;
  String? sku;
  String? gst;

  ProductDetails(
      {this.id,
      this.productName,
      this.productDescription,
      this.productShortDescription,
      this.productPrice,
      this.productStock,
      this.sku,
      this.gst});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['productName'];
    productDescription = json['productDescription'];
    productShortDescription = json['productShortDescription'];
    productPrice = json['productPrice'];
    productStock = json['productStock'];
    sku = json['sku'];
    gst = json['gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productName'] = this.productName;
    data['productDescription'] = this.productDescription;
    data['productShortDescription'] = this.productShortDescription;
    data['productPrice'] = this.productPrice;
    data['productStock'] = this.productStock;
    data['sku'] = this.sku;
    data['gst'] = this.gst;
    return data;
  }
}

class UserRatingsDetails {
  int? id;
  CustomerDetails? customerDetails;
  String? starRating;
  String? reviewComment;
  String? ratingDate;

  UserRatingsDetails(
      {this.id,
      this.customerDetails,
      this.starRating,
      this.reviewComment,
      this.ratingDate});

  UserRatingsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerDetails = json['customerDetails'] != null
        ? new CustomerDetails.fromJson(json['customerDetails'])
        : null;
    starRating = json['starRating'];
    reviewComment = json['reviewComment'];
    ratingDate = json['ratingDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customerDetails != null) {
      data['customerDetails'] = this.customerDetails!.toJson();
    }
    data['starRating'] = this.starRating;
    data['reviewComment'] = this.reviewComment;
    data['ratingDate'] = this.ratingDate;
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

class AverageRatingsDetails {
  int? id;
  String? totalRatings;
  String? totalRatingValue;
  String? averageRating;
  String? fiveStarRating;
  String? fourStarRating;
  String? threeStarRating;
  String? twoStarRating;
  String? oneStarRating;

  AverageRatingsDetails(
      {this.id,
      this.totalRatings,
      this.totalRatingValue,
      this.averageRating,
      this.fiveStarRating,
      this.fourStarRating,
      this.threeStarRating,
      this.twoStarRating,
      this.oneStarRating});

  AverageRatingsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalRatings = json['totalRatings'];
    totalRatingValue = json['totalRatingValue'];
    averageRating = json['averageRating'];
    fiveStarRating = json['fiveStarRating'];
    fourStarRating = json['fourStarRating'];
    threeStarRating = json['threeStarRating'];
    twoStarRating = json['twoStarRating'];
    oneStarRating = json['oneStarRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalRatings'] = this.totalRatings;
    data['totalRatingValue'] = this.totalRatingValue;
    data['averageRating'] = this.averageRating;
    data['fiveStarRating'] = this.fiveStarRating;
    data['fourStarRating'] = this.fourStarRating;
    data['threeStarRating'] = this.threeStarRating;
    data['twoStarRating'] = this.twoStarRating;
    data['oneStarRating'] = this.oneStarRating;
    return data;
  }
}
