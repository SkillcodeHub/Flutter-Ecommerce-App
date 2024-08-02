// class FeaturedProductListModel {
//   List<TopRatedProductList>? _topRatedProductList;

//   FeaturedProductListModel({List<TopRatedProductList>? topRatedProductList}) {
//     if (topRatedProductList != null) {
//       this._topRatedProductList = topRatedProductList;
//     }
//   }

//   List<TopRatedProductList>? get topRatedProductList => _topRatedProductList;
//   set topRatedProductList(List<TopRatedProductList>? topRatedProductList) =>
//       _topRatedProductList = topRatedProductList;

//   FeaturedProductListModel.fromJson(Map<String, dynamic> json) {
//     if (json['topRatedProductList'] != null) {
//       _topRatedProductList = <TopRatedProductList>[];
//       json['topRatedProductList'].forEach((v) {
//         _topRatedProductList!.add(new TopRatedProductList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this._topRatedProductList != null) {
//       data['topRatedProductList'] =
//           this._topRatedProductList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class TopRatedProductList {
//   int? _id;
//   ClientDetails? _clientDetails;
//   MainCategoryDetails? _mainCategoryDetails;
//   CategoryDetails? _categoryDetails;
//   SubCategoryDetails? _subCategoryDetails;
//   String? _productName;
//   String? _productDescription;
//   String? _productShortDescription;
//   String? _saleStartsAt;
//   String? _minSalePrice;
//   String? _stockStatus;
//   String? _isQualityRuleApply;
//   String? _minQuantity;
//   String? _maxQuantity;
//   String? _outofstockSelling;
//   Null? _productStock;
//   String? _sku;
//   String? _gst;
//   bool? _isProductHasDiscount;
//   String? _isFeaturedProduct;
//   String? _isTopSellingProduct;
//   String? _productGallery;
//   String? _productStatus;
//   String? _publishStatus;
//   String? _activationDate;
//   String? _publishTime;
//   String? _isDiscountApplicable;
//   String? _discountedPercentage;
//   List<RelatedProducts>? _relatedProducts;
//   List<Attributes>? _attributes;
//   List<Variants>? _variants;
//   List<Null>? _technicalDetails;
//   List<AdditionalInformation>? _additionalInformation;
//   List<UserRatingsDetails>? _userRatingsDetails;
//   List<AverageRatingsDetails>? _averageRatingsDetails;
//   String? _createdAt;
//   String? _updatedAt;
//   String? _createdBy;
//   String? _updatedBy;

//   TopRatedProductList(
//       {int? id,
//       ClientDetails? clientDetails,
//       MainCategoryDetails? mainCategoryDetails,
//       CategoryDetails? categoryDetails,
//       SubCategoryDetails? subCategoryDetails,
//       String? productName,
//       String? productDescription,
//       String? productShortDescription,
//       String? saleStartsAt,
//       String? minSalePrice,
//       String? stockStatus,
//       String? isQualityRuleApply,
//       String? minQuantity,
//       String? maxQuantity,
//       String? outofstockSelling,
//       Null? productStock,
//       String? sku,
//       String? gst,
//       bool? isProductHasDiscount,
//       String? isFeaturedProduct,
//       String? isTopSellingProduct,
//       String? productGallery,
//       String? productStatus,
//       String? publishStatus,
//       String? activationDate,
//       String? publishTime,
//       String? isDiscountApplicable,
//       String? discountedPercentage,
//       List<RelatedProducts>? relatedProducts,
//       List<Attributes>? attributes,
//       List<Variants>? variants,
//       List<Null>? technicalDetails,
//       List<AdditionalInformation>? additionalInformation,
//       List<UserRatingsDetails>? userRatingsDetails,
//       List<AverageRatingsDetails>? averageRatingsDetails,
//       String? createdAt,
//       String? updatedAt,
//       String? createdBy,
//       String? updatedBy}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (clientDetails != null) {
//       this._clientDetails = clientDetails;
//     }
//     if (mainCategoryDetails != null) {
//       this._mainCategoryDetails = mainCategoryDetails;
//     }
//     if (categoryDetails != null) {
//       this._categoryDetails = categoryDetails;
//     }
//     if (subCategoryDetails != null) {
//       this._subCategoryDetails = subCategoryDetails;
//     }
//     if (productName != null) {
//       this._productName = productName;
//     }
//     if (productDescription != null) {
//       this._productDescription = productDescription;
//     }
//     if (productShortDescription != null) {
//       this._productShortDescription = productShortDescription;
//     }
//     if (saleStartsAt != null) {
//       this._saleStartsAt = saleStartsAt;
//     }
//     if (minSalePrice != null) {
//       this._minSalePrice = minSalePrice;
//     }
//     if (stockStatus != null) {
//       this._stockStatus = stockStatus;
//     }
//     if (isQualityRuleApply != null) {
//       this._isQualityRuleApply = isQualityRuleApply;
//     }
//     if (minQuantity != null) {
//       this._minQuantity = minQuantity;
//     }
//     if (maxQuantity != null) {
//       this._maxQuantity = maxQuantity;
//     }
//     if (outofstockSelling != null) {
//       this._outofstockSelling = outofstockSelling;
//     }
//     if (productStock != null) {
//       this._productStock = productStock;
//     }
//     if (sku != null) {
//       this._sku = sku;
//     }
//     if (gst != null) {
//       this._gst = gst;
//     }
//     if (isProductHasDiscount != null) {
//       this._isProductHasDiscount = isProductHasDiscount;
//     }
//     if (isFeaturedProduct != null) {
//       this._isFeaturedProduct = isFeaturedProduct;
//     }
//     if (isTopSellingProduct != null) {
//       this._isTopSellingProduct = isTopSellingProduct;
//     }
//     if (productGallery != null) {
//       this._productGallery = productGallery;
//     }
//     if (productStatus != null) {
//       this._productStatus = productStatus;
//     }
//     if (publishStatus != null) {
//       this._publishStatus = publishStatus;
//     }
//     if (activationDate != null) {
//       this._activationDate = activationDate;
//     }
//     if (publishTime != null) {
//       this._publishTime = publishTime;
//     }
//     if (isDiscountApplicable != null) {
//       this._isDiscountApplicable = isDiscountApplicable;
//     }
//     if (discountedPercentage != null) {
//       this._discountedPercentage = discountedPercentage;
//     }
//     if (relatedProducts != null) {
//       this._relatedProducts = relatedProducts;
//     }
//     if (attributes != null) {
//       this._attributes = attributes;
//     }
//     if (variants != null) {
//       this._variants = variants;
//     }
//     if (technicalDetails != null) {
//       this._technicalDetails = technicalDetails;
//     }
//     if (additionalInformation != null) {
//       this._additionalInformation = additionalInformation;
//     }
//     if (userRatingsDetails != null) {
//       this._userRatingsDetails = userRatingsDetails;
//     }
//     if (averageRatingsDetails != null) {
//       this._averageRatingsDetails = averageRatingsDetails;
//     }
//     if (createdAt != null) {
//       this._createdAt = createdAt;
//     }
//     if (updatedAt != null) {
//       this._updatedAt = updatedAt;
//     }
//     if (createdBy != null) {
//       this._createdBy = createdBy;
//     }
//     if (updatedBy != null) {
//       this._updatedBy = updatedBy;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   ClientDetails? get clientDetails => _clientDetails;
//   set clientDetails(ClientDetails? clientDetails) =>
//       _clientDetails = clientDetails;
//   MainCategoryDetails? get mainCategoryDetails => _mainCategoryDetails;
//   set mainCategoryDetails(MainCategoryDetails? mainCategoryDetails) =>
//       _mainCategoryDetails = mainCategoryDetails;
//   CategoryDetails? get categoryDetails => _categoryDetails;
//   set categoryDetails(CategoryDetails? categoryDetails) =>
//       _categoryDetails = categoryDetails;
//   SubCategoryDetails? get subCategoryDetails => _subCategoryDetails;
//   set subCategoryDetails(SubCategoryDetails? subCategoryDetails) =>
//       _subCategoryDetails = subCategoryDetails;
//   String? get productName => _productName;
//   set productName(String? productName) => _productName = productName;
//   String? get productDescription => _productDescription;
//   set productDescription(String? productDescription) =>
//       _productDescription = productDescription;
//   String? get productShortDescription => _productShortDescription;
//   set productShortDescription(String? productShortDescription) =>
//       _productShortDescription = productShortDescription;
//   String? get saleStartsAt => _saleStartsAt;
//   set saleStartsAt(String? saleStartsAt) => _saleStartsAt = saleStartsAt;
//   String? get minSalePrice => _minSalePrice;
//   set minSalePrice(String? minSalePrice) => _minSalePrice = minSalePrice;
//   String? get stockStatus => _stockStatus;
//   set stockStatus(String? stockStatus) => _stockStatus = stockStatus;
//   String? get isQualityRuleApply => _isQualityRuleApply;
//   set isQualityRuleApply(String? isQualityRuleApply) =>
//       _isQualityRuleApply = isQualityRuleApply;
//   String? get minQuantity => _minQuantity;
//   set minQuantity(String? minQuantity) => _minQuantity = minQuantity;
//   String? get maxQuantity => _maxQuantity;
//   set maxQuantity(String? maxQuantity) => _maxQuantity = maxQuantity;
//   String? get outofstockSelling => _outofstockSelling;
//   set outofstockSelling(String? outofstockSelling) =>
//       _outofstockSelling = outofstockSelling;
//   Null? get productStock => _productStock;
//   set productStock(Null? productStock) => _productStock = productStock;
//   String? get sku => _sku;
//   set sku(String? sku) => _sku = sku;
//   String? get gst => _gst;
//   set gst(String? gst) => _gst = gst;
//   bool? get isProductHasDiscount => _isProductHasDiscount;
//   set isProductHasDiscount(bool? isProductHasDiscount) =>
//       _isProductHasDiscount = isProductHasDiscount;
//   String? get isFeaturedProduct => _isFeaturedProduct;
//   set isFeaturedProduct(String? isFeaturedProduct) =>
//       _isFeaturedProduct = isFeaturedProduct;
//   String? get isTopSellingProduct => _isTopSellingProduct;
//   set isTopSellingProduct(String? isTopSellingProduct) =>
//       _isTopSellingProduct = isTopSellingProduct;
//   String? get productGallery => _productGallery;
//   set productGallery(String? productGallery) =>
//       _productGallery = productGallery;
//   String? get productStatus => _productStatus;
//   set productStatus(String? productStatus) => _productStatus = productStatus;
//   String? get publishStatus => _publishStatus;
//   set publishStatus(String? publishStatus) => _publishStatus = publishStatus;
//   String? get activationDate => _activationDate;
//   set activationDate(String? activationDate) =>
//       _activationDate = activationDate;
//   String? get publishTime => _publishTime;
//   set publishTime(String? publishTime) => _publishTime = publishTime;
//   String? get isDiscountApplicable => _isDiscountApplicable;
//   set isDiscountApplicable(String? isDiscountApplicable) =>
//       _isDiscountApplicable = isDiscountApplicable;
//   String? get discountedPercentage => _discountedPercentage;
//   set discountedPercentage(String? discountedPercentage) =>
//       _discountedPercentage = discountedPercentage;
//   List<RelatedProducts>? get relatedProducts => _relatedProducts;
//   set relatedProducts(List<RelatedProducts>? relatedProducts) =>
//       _relatedProducts = relatedProducts;
//   List<Attributes>? get attributes => _attributes;
//   set attributes(List<Attributes>? attributes) => _attributes = attributes;
//   List<Variants>? get variants => _variants;
//   set variants(List<Variants>? variants) => _variants = variants;
//   List<Null>? get technicalDetails => _technicalDetails;
//   set technicalDetails(List<Null>? technicalDetails) =>
//       _technicalDetails = technicalDetails;
//   List<AdditionalInformation>? get additionalInformation =>
//       _additionalInformation;
//   set additionalInformation(
//           List<AdditionalInformation>? additionalInformation) =>
//       _additionalInformation = additionalInformation;
//   List<UserRatingsDetails>? get userRatingsDetails => _userRatingsDetails;
//   set userRatingsDetails(List<UserRatingsDetails>? userRatingsDetails) =>
//       _userRatingsDetails = userRatingsDetails;
//   List<AverageRatingsDetails>? get averageRatingsDetails =>
//       _averageRatingsDetails;
//   set averageRatingsDetails(
//           List<AverageRatingsDetails>? averageRatingsDetails) =>
//       _averageRatingsDetails = averageRatingsDetails;
//   String? get createdAt => _createdAt;
//   set createdAt(String? createdAt) => _createdAt = createdAt;
//   String? get updatedAt => _updatedAt;
//   set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
//   String? get createdBy => _createdBy;
//   set createdBy(String? createdBy) => _createdBy = createdBy;
//   String? get updatedBy => _updatedBy;
//   set updatedBy(String? updatedBy) => _updatedBy = updatedBy;

//   TopRatedProductList.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _clientDetails = json['clientDetails'] != null
//         ? new ClientDetails.fromJson(json['clientDetails'])
//         : null;
//     _mainCategoryDetails = json['mainCategoryDetails'] != null
//         ? new MainCategoryDetails.fromJson(json['mainCategoryDetails'])
//         : null;
//     _categoryDetails = json['categoryDetails'] != null
//         ? new CategoryDetails.fromJson(json['categoryDetails'])
//         : null;
//     _subCategoryDetails = json['subCategoryDetails'] != null
//         ? new SubCategoryDetails.fromJson(json['subCategoryDetails'])
//         : null;
//     _productName = json['productName'];
//     _productDescription = json['productDescription'];
//     _productShortDescription = json['productShortDescription'];
//     _saleStartsAt = json['saleStartsAt'];
//     _minSalePrice = json['minSalePrice'];
//     _stockStatus = json['stockStatus'];
//     _isQualityRuleApply = json['isQualityRuleApply'];
//     _minQuantity = json['minQuantity'];
//     _maxQuantity = json['maxQuantity'];
//     _outofstockSelling = json['outofstockSelling'];
//     _productStock = json['productStock'];
//     _sku = json['sku'];
//     _gst = json['gst'];
//     _isProductHasDiscount = json['isProductHasDiscount'];
//     _isFeaturedProduct = json['isFeaturedProduct'];
//     _isTopSellingProduct = json['isTopSellingProduct'];
//     _productGallery = json['productGallery'];
//     _productStatus = json['productStatus'];
//     _publishStatus = json['publishStatus'];
//     _activationDate = json['activationDate'];
//     _publishTime = json['publishTime'];
//     _isDiscountApplicable = json['isDiscountApplicable'];
//     _discountedPercentage = json['discountedPercentage'];
//     if (json['related_products'] != null) {
//       _relatedProducts = <RelatedProducts>[];
//       json['related_products'].forEach((v) {
//         _relatedProducts!.add(new RelatedProducts.fromJson(v));
//       });
//     }
//     if (json['attributes'] != null) {
//       _attributes = <Attributes>[];
//       json['attributes'].forEach((v) {
//         _attributes!.add(new Attributes.fromJson(v));
//       });
//     }
//     if (json['variants'] != null) {
//       _variants = <Variants>[];
//       json['variants'].forEach((v) {
//         _variants!.add(new Variants.fromJson(v));
//       });
//     }
//     if (json['technicalDetails'] != null) {
//       _technicalDetails = <Null>[];
//       json['technicalDetails'].forEach((v) {
//         _technicalDetails!.add(new Null.fromJson(v));
//       });
//     }
//     if (json['additionalInformation'] != null) {
//       _additionalInformation = <AdditionalInformation>[];
//       json['additionalInformation'].forEach((v) {
//         _additionalInformation!.add(new AdditionalInformation.fromJson(v));
//       });
//     }
//     if (json['userRatingsDetails'] != null) {
//       _userRatingsDetails = <UserRatingsDetails>[];
//       json['userRatingsDetails'].forEach((v) {
//         _userRatingsDetails!.add(new UserRatingsDetails.fromJson(v));
//       });
//     }
//     if (json['averageRatingsDetails'] != null) {
//       _averageRatingsDetails = <AverageRatingsDetails>[];
//       json['averageRatingsDetails'].forEach((v) {
//         _averageRatingsDetails!.add(new AverageRatingsDetails.fromJson(v));
//       });
//     }
//     _createdAt = json['created_at'];
//     _updatedAt = json['updated_at'];
//     _createdBy = json['created_by'];
//     _updatedBy = json['updated_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     if (this._clientDetails != null) {
//       data['clientDetails'] = this._clientDetails!.toJson();
//     }
//     if (this._mainCategoryDetails != null) {
//       data['mainCategoryDetails'] = this._mainCategoryDetails!.toJson();
//     }
//     if (this._categoryDetails != null) {
//       data['categoryDetails'] = this._categoryDetails!.toJson();
//     }
//     if (this._subCategoryDetails != null) {
//       data['subCategoryDetails'] = this._subCategoryDetails!.toJson();
//     }
//     data['productName'] = this._productName;
//     data['productDescription'] = this._productDescription;
//     data['productShortDescription'] = this._productShortDescription;
//     data['saleStartsAt'] = this._saleStartsAt;
//     data['minSalePrice'] = this._minSalePrice;
//     data['stockStatus'] = this._stockStatus;
//     data['isQualityRuleApply'] = this._isQualityRuleApply;
//     data['minQuantity'] = this._minQuantity;
//     data['maxQuantity'] = this._maxQuantity;
//     data['outofstockSelling'] = this._outofstockSelling;
//     data['productStock'] = this._productStock;
//     data['sku'] = this._sku;
//     data['gst'] = this._gst;
//     data['isProductHasDiscount'] = this._isProductHasDiscount;
//     data['isFeaturedProduct'] = this._isFeaturedProduct;
//     data['isTopSellingProduct'] = this._isTopSellingProduct;
//     data['productGallery'] = this._productGallery;
//     data['productStatus'] = this._productStatus;
//     data['publishStatus'] = this._publishStatus;
//     data['activationDate'] = this._activationDate;
//     data['publishTime'] = this._publishTime;
//     data['isDiscountApplicable'] = this._isDiscountApplicable;
//     data['discountedPercentage'] = this._discountedPercentage;
//     if (this._relatedProducts != null) {
//       data['related_products'] =
//           this._relatedProducts!.map((v) => v.toJson()).toList();
//     }
//     if (this._attributes != null) {
//       data['attributes'] = this._attributes!.map((v) => v.toJson()).toList();
//     }
//     if (this._variants != null) {
//       data['variants'] = this._variants!.map((v) => v.toJson()).toList();
//     }
//     if (this._technicalDetails != null) {
//       data['technicalDetails'] =
//           this._technicalDetails!.map((v) => v.toJson()).toList();
//     }
//     if (this._additionalInformation != null) {
//       data['additionalInformation'] =
//           this._additionalInformation!.map((v) => v.toJson()).toList();
//     }
//     if (this._userRatingsDetails != null) {
//       data['userRatingsDetails'] =
//           this._userRatingsDetails!.map((v) => v.toJson()).toList();
//     }
//     if (this._averageRatingsDetails != null) {
//       data['averageRatingsDetails'] =
//           this._averageRatingsDetails!.map((v) => v.toJson()).toList();
//     }
//     data['created_at'] = this._createdAt;
//     data['updated_at'] = this._updatedAt;
//     data['created_by'] = this._createdBy;
//     data['updated_by'] = this._updatedBy;
//     return data;
//   }
// }

// class ClientDetails {
//   int? _id;
//   String? _clientName;
//   String? _companyName;
//   String? _gstNo;
//   String? _address;

//   ClientDetails(
//       {int? id,
//       String? clientName,
//       String? companyName,
//       String? gstNo,
//       String? address}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (clientName != null) {
//       this._clientName = clientName;
//     }
//     if (companyName != null) {
//       this._companyName = companyName;
//     }
//     if (gstNo != null) {
//       this._gstNo = gstNo;
//     }
//     if (address != null) {
//       this._address = address;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get clientName => _clientName;
//   set clientName(String? clientName) => _clientName = clientName;
//   String? get companyName => _companyName;
//   set companyName(String? companyName) => _companyName = companyName;
//   String? get gstNo => _gstNo;
//   set gstNo(String? gstNo) => _gstNo = gstNo;
//   String? get address => _address;
//   set address(String? address) => _address = address;

//   ClientDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _clientName = json['clientName'];
//     _companyName = json['companyName'];
//     _gstNo = json['gstNo'];
//     _address = json['address'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['clientName'] = this._clientName;
//     data['companyName'] = this._companyName;
//     data['gstNo'] = this._gstNo;
//     data['address'] = this._address;
//     return data;
//   }
// }

// class MainCategoryDetails {
//   int? _id;
//   String? _mainCategoryName;

//   MainCategoryDetails({int? id, String? mainCategoryName}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (mainCategoryName != null) {
//       this._mainCategoryName = mainCategoryName;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get mainCategoryName => _mainCategoryName;
//   set mainCategoryName(String? mainCategoryName) =>
//       _mainCategoryName = mainCategoryName;

//   MainCategoryDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _mainCategoryName = json['mainCategoryName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['mainCategoryName'] = this._mainCategoryName;
//     return data;
//   }
// }

// class CategoryDetails {
//   int? _id;
//   String? _categoryName;

//   CategoryDetails({int? id, String? categoryName}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (categoryName != null) {
//       this._categoryName = categoryName;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get categoryName => _categoryName;
//   set categoryName(String? categoryName) => _categoryName = categoryName;

//   CategoryDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _categoryName = json['categoryName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['categoryName'] = this._categoryName;
//     return data;
//   }
// }

// class SubCategoryDetails {
//   int? _id;
//   String? _subCategoryName;

//   SubCategoryDetails({int? id, String? subCategoryName}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (subCategoryName != null) {
//       this._subCategoryName = subCategoryName;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get subCategoryName => _subCategoryName;
//   set subCategoryName(String? subCategoryName) =>
//       _subCategoryName = subCategoryName;

//   SubCategoryDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _subCategoryName = json['subCategoryName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['subCategoryName'] = this._subCategoryName;
//     return data;
//   }
// }

// class RelatedProducts {
//   int? _id;
//   String? _productName;
//   String? _productDescription;
//   String? _productShortDescription;
//   String? _productPrice;
//   Null? _productStock;
//   String? _minSalePrice;
//   String? _stockStatus;
//   String? _isQualityRuleApply;
//   String? _minQuantity;
//   String? _maxQuantity;
//   String? _outofstockSelling;
//   String? _sku;
//   String? _gst;

//   RelatedProducts(
//       {int? id,
//       String? productName,
//       String? productDescription,
//       String? productShortDescription,
//       String? productPrice,
//       Null? productStock,
//       String? minSalePrice,
//       String? stockStatus,
//       String? isQualityRuleApply,
//       String? minQuantity,
//       String? maxQuantity,
//       String? outofstockSelling,
//       String? sku,
//       String? gst}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (productName != null) {
//       this._productName = productName;
//     }
//     if (productDescription != null) {
//       this._productDescription = productDescription;
//     }
//     if (productShortDescription != null) {
//       this._productShortDescription = productShortDescription;
//     }
//     if (productPrice != null) {
//       this._productPrice = productPrice;
//     }
//     if (productStock != null) {
//       this._productStock = productStock;
//     }
//     if (minSalePrice != null) {
//       this._minSalePrice = minSalePrice;
//     }
//     if (stockStatus != null) {
//       this._stockStatus = stockStatus;
//     }
//     if (isQualityRuleApply != null) {
//       this._isQualityRuleApply = isQualityRuleApply;
//     }
//     if (minQuantity != null) {
//       this._minQuantity = minQuantity;
//     }
//     if (maxQuantity != null) {
//       this._maxQuantity = maxQuantity;
//     }
//     if (outofstockSelling != null) {
//       this._outofstockSelling = outofstockSelling;
//     }
//     if (sku != null) {
//       this._sku = sku;
//     }
//     if (gst != null) {
//       this._gst = gst;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get productName => _productName;
//   set productName(String? productName) => _productName = productName;
//   String? get productDescription => _productDescription;
//   set productDescription(String? productDescription) =>
//       _productDescription = productDescription;
//   String? get productShortDescription => _productShortDescription;
//   set productShortDescription(String? productShortDescription) =>
//       _productShortDescription = productShortDescription;
//   String? get productPrice => _productPrice;
//   set productPrice(String? productPrice) => _productPrice = productPrice;
//   Null? get productStock => _productStock;
//   set productStock(Null? productStock) => _productStock = productStock;
//   String? get minSalePrice => _minSalePrice;
//   set minSalePrice(String? minSalePrice) => _minSalePrice = minSalePrice;
//   String? get stockStatus => _stockStatus;
//   set stockStatus(String? stockStatus) => _stockStatus = stockStatus;
//   String? get isQualityRuleApply => _isQualityRuleApply;
//   set isQualityRuleApply(String? isQualityRuleApply) =>
//       _isQualityRuleApply = isQualityRuleApply;
//   String? get minQuantity => _minQuantity;
//   set minQuantity(String? minQuantity) => _minQuantity = minQuantity;
//   String? get maxQuantity => _maxQuantity;
//   set maxQuantity(String? maxQuantity) => _maxQuantity = maxQuantity;
//   String? get outofstockSelling => _outofstockSelling;
//   set outofstockSelling(String? outofstockSelling) =>
//       _outofstockSelling = outofstockSelling;
//   String? get sku => _sku;
//   set sku(String? sku) => _sku = sku;
//   String? get gst => _gst;
//   set gst(String? gst) => _gst = gst;

//   RelatedProducts.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _productName = json['productName'];
//     _productDescription = json['productDescription'];
//     _productShortDescription = json['productShortDescription'];
//     _productPrice = json['productPrice'];
//     _productStock = json['productStock'];
//     _minSalePrice = json['minSalePrice'];
//     _stockStatus = json['stockStatus'];
//     _isQualityRuleApply = json['isQualityRuleApply'];
//     _minQuantity = json['minQuantity'];
//     _maxQuantity = json['maxQuantity'];
//     _outofstockSelling = json['outofstockSelling'];
//     _sku = json['sku'];
//     _gst = json['gst'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['productName'] = this._productName;
//     data['productDescription'] = this._productDescription;
//     data['productShortDescription'] = this._productShortDescription;
//     data['productPrice'] = this._productPrice;
//     data['productStock'] = this._productStock;
//     data['minSalePrice'] = this._minSalePrice;
//     data['stockStatus'] = this._stockStatus;
//     data['isQualityRuleApply'] = this._isQualityRuleApply;
//     data['minQuantity'] = this._minQuantity;
//     data['maxQuantity'] = this._maxQuantity;
//     data['outofstockSelling'] = this._outofstockSelling;
//     data['sku'] = this._sku;
//     data['gst'] = this._gst;
//     return data;
//   }
// }

// class Attributes {
//   int? _id;
//   String? _name;
//   String? _value;

//   Attributes({int? id, String? name, String? value}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (name != null) {
//       this._name = name;
//     }
//     if (value != null) {
//       this._value = value;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get name => _name;
//   set name(String? name) => _name = name;
//   String? get value => _value;
//   set value(String? value) => _value = value;

//   Attributes.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _name = json['name'];
//     _value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['name'] = this._name;
//     data['value'] = this._value;
//     return data;
//   }
// }

// class Variants {
//   int? _id;
//   Attributes? _attributeDetails;
//   String? _variantkey;
//   String? _price;
//   String? _stock;
//   String? _variantImage;
//   String? _variantImageGallery;

//   Variants(
//       {int? id,
//       Attributes? attributeDetails,
//       String? variantkey,
//       String? price,
//       String? stock,
//       String? variantImage,
//       String? variantImageGallery}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (attributeDetails != null) {
//       this._attributeDetails = attributeDetails;
//     }
//     if (variantkey != null) {
//       this._variantkey = variantkey;
//     }
//     if (price != null) {
//       this._price = price;
//     }
//     if (stock != null) {
//       this._stock = stock;
//     }
//     if (variantImage != null) {
//       this._variantImage = variantImage;
//     }
//     if (variantImageGallery != null) {
//       this._variantImageGallery = variantImageGallery;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   Attributes? get attributeDetails => _attributeDetails;
//   set attributeDetails(Attributes? attributeDetails) =>
//       _attributeDetails = attributeDetails;
//   String? get variantkey => _variantkey;
//   set variantkey(String? variantkey) => _variantkey = variantkey;
//   String? get price => _price;
//   set price(String? price) => _price = price;
//   String? get stock => _stock;
//   set stock(String? stock) => _stock = stock;
//   String? get variantImage => _variantImage;
//   set variantImage(String? variantImage) => _variantImage = variantImage;
//   String? get variantImageGallery => _variantImageGallery;
//   set variantImageGallery(String? variantImageGallery) =>
//       _variantImageGallery = variantImageGallery;

//   Variants.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _attributeDetails = json['attributeDetails'] != null
//         ? new Attributes.fromJson(json['attributeDetails'])
//         : null;
//     _variantkey = json['variantkey'];
//     _price = json['price'];
//     _stock = json['stock'];
//     _variantImage = json['variantImage'];
//     _variantImageGallery = json['variantImageGallery'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     if (this._attributeDetails != null) {
//       data['attributeDetails'] = this._attributeDetails!.toJson();
//     }
//     data['variantkey'] = this._variantkey;
//     data['price'] = this._price;
//     data['stock'] = this._stock;
//     data['variantImage'] = this._variantImage;
//     data['variantImageGallery'] = this._variantImageGallery;
//     return data;
//   }
// }

// class AdditionalInformation {
//   int? _id;
//   ProductDetails? _productDetails;
//   String? _title;
//   String? _value;

//   AdditionalInformation(
//       {int? id, ProductDetails? productDetails, String? title, String? value}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (productDetails != null) {
//       this._productDetails = productDetails;
//     }
//     if (title != null) {
//       this._title = title;
//     }
//     if (value != null) {
//       this._value = value;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   ProductDetails? get productDetails => _productDetails;
//   set productDetails(ProductDetails? productDetails) =>
//       _productDetails = productDetails;
//   String? get title => _title;
//   set title(String? title) => _title = title;
//   String? get value => _value;
//   set value(String? value) => _value = value;

//   AdditionalInformation.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _productDetails = json['productDetails'] != null
//         ? new ProductDetails.fromJson(json['productDetails'])
//         : null;
//     _title = json['title'];
//     _value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     if (this._productDetails != null) {
//       data['productDetails'] = this._productDetails!.toJson();
//     }
//     data['title'] = this._title;
//     data['value'] = this._value;
//     return data;
//   }
// }

// class ProductDetails {
//   int? _id;
//   String? _productName;
//   String? _productDescription;
//   String? _productShortDescription;
//   String? _productPrice;
//   Null? _productStock;
//   String? _sku;
//   String? _gst;

//   ProductDetails(
//       {int? id,
//       String? productName,
//       String? productDescription,
//       String? productShortDescription,
//       String? productPrice,
//       Null? productStock,
//       String? sku,
//       String? gst}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (productName != null) {
//       this._productName = productName;
//     }
//     if (productDescription != null) {
//       this._productDescription = productDescription;
//     }
//     if (productShortDescription != null) {
//       this._productShortDescription = productShortDescription;
//     }
//     if (productPrice != null) {
//       this._productPrice = productPrice;
//     }
//     if (productStock != null) {
//       this._productStock = productStock;
//     }
//     if (sku != null) {
//       this._sku = sku;
//     }
//     if (gst != null) {
//       this._gst = gst;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get productName => _productName;
//   set productName(String? productName) => _productName = productName;
//   String? get productDescription => _productDescription;
//   set productDescription(String? productDescription) =>
//       _productDescription = productDescription;
//   String? get productShortDescription => _productShortDescription;
//   set productShortDescription(String? productShortDescription) =>
//       _productShortDescription = productShortDescription;
//   String? get productPrice => _productPrice;
//   set productPrice(String? productPrice) => _productPrice = productPrice;
//   Null? get productStock => _productStock;
//   set productStock(Null? productStock) => _productStock = productStock;
//   String? get sku => _sku;
//   set sku(String? sku) => _sku = sku;
//   String? get gst => _gst;
//   set gst(String? gst) => _gst = gst;

//   ProductDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _productName = json['productName'];
//     _productDescription = json['productDescription'];
//     _productShortDescription = json['productShortDescription'];
//     _productPrice = json['productPrice'];
//     _productStock = json['productStock'];
//     _sku = json['sku'];
//     _gst = json['gst'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['productName'] = this._productName;
//     data['productDescription'] = this._productDescription;
//     data['productShortDescription'] = this._productShortDescription;
//     data['productPrice'] = this._productPrice;
//     data['productStock'] = this._productStock;
//     data['sku'] = this._sku;
//     data['gst'] = this._gst;
//     return data;
//   }
// }

// class UserRatingsDetails {
//   int? _id;
//   CustomerDetails? _customerDetails;
//   String? _starRating;
//   String? _reviewComment;
//   String? _ratingDate;

//   UserRatingsDetails(
//       {int? id,
//       CustomerDetails? customerDetails,
//       String? starRating,
//       String? reviewComment,
//       String? ratingDate}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (customerDetails != null) {
//       this._customerDetails = customerDetails;
//     }
//     if (starRating != null) {
//       this._starRating = starRating;
//     }
//     if (reviewComment != null) {
//       this._reviewComment = reviewComment;
//     }
//     if (ratingDate != null) {
//       this._ratingDate = ratingDate;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   CustomerDetails? get customerDetails => _customerDetails;
//   set customerDetails(CustomerDetails? customerDetails) =>
//       _customerDetails = customerDetails;
//   String? get starRating => _starRating;
//   set starRating(String? starRating) => _starRating = starRating;
//   String? get reviewComment => _reviewComment;
//   set reviewComment(String? reviewComment) => _reviewComment = reviewComment;
//   String? get ratingDate => _ratingDate;
//   set ratingDate(String? ratingDate) => _ratingDate = ratingDate;

//   UserRatingsDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _customerDetails = json['customerDetails'] != null
//         ? new CustomerDetails.fromJson(json['customerDetails'])
//         : null;
//     _starRating = json['starRating'];
//     _reviewComment = json['reviewComment'];
//     _ratingDate = json['ratingDate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     if (this._customerDetails != null) {
//       data['customerDetails'] = this._customerDetails!.toJson();
//     }
//     data['starRating'] = this._starRating;
//     data['reviewComment'] = this._reviewComment;
//     data['ratingDate'] = this._ratingDate;
//     return data;
//   }
// }

// class CustomerDetails {
//   int? _id;
//   String? _customerName;
//   String? _customerEmail;
//   String? _customerMobile;
//   Null? _customerAlterMobile;
//   String? _profileImage;

//   CustomerDetails(
//       {int? id,
//       String? customerName,
//       String? customerEmail,
//       String? customerMobile,
//       Null? customerAlterMobile,
//       String? profileImage}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (customerName != null) {
//       this._customerName = customerName;
//     }
//     if (customerEmail != null) {
//       this._customerEmail = customerEmail;
//     }
//     if (customerMobile != null) {
//       this._customerMobile = customerMobile;
//     }
//     if (customerAlterMobile != null) {
//       this._customerAlterMobile = customerAlterMobile;
//     }
//     if (profileImage != null) {
//       this._profileImage = profileImage;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get customerName => _customerName;
//   set customerName(String? customerName) => _customerName = customerName;
//   String? get customerEmail => _customerEmail;
//   set customerEmail(String? customerEmail) => _customerEmail = customerEmail;
//   String? get customerMobile => _customerMobile;
//   set customerMobile(String? customerMobile) =>
//       _customerMobile = customerMobile;
//   Null? get customerAlterMobile => _customerAlterMobile;
//   set customerAlterMobile(Null? customerAlterMobile) =>
//       _customerAlterMobile = customerAlterMobile;
//   String? get profileImage => _profileImage;
//   set profileImage(String? profileImage) => _profileImage = profileImage;

//   CustomerDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _customerName = json['customerName'];
//     _customerEmail = json['customerEmail'];
//     _customerMobile = json['customerMobile'];
//     _customerAlterMobile = json['customerAlterMobile'];
//     _profileImage = json['profileImage'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['customerName'] = this._customerName;
//     data['customerEmail'] = this._customerEmail;
//     data['customerMobile'] = this._customerMobile;
//     data['customerAlterMobile'] = this._customerAlterMobile;
//     data['profileImage'] = this._profileImage;
//     return data;
//   }
// }

// class AverageRatingsDetails {
//   int? _id;
//   String? _totalRatings;
//   String? _totalRatingValue;
//   String? _averageRating;
//   String? _fiveStarRating;
//   String? _fourStarRating;
//   String? _threeStarRating;
//   String? _twoStarRating;
//   String? _oneStarRating;

//   AverageRatingsDetails(
//       {int? id,
//       String? totalRatings,
//       String? totalRatingValue,
//       String? averageRating,
//       String? fiveStarRating,
//       String? fourStarRating,
//       String? threeStarRating,
//       String? twoStarRating,
//       String? oneStarRating}) {
//     if (id != null) {
//       this._id = id;
//     }
//     if (totalRatings != null) {
//       this._totalRatings = totalRatings;
//     }
//     if (totalRatingValue != null) {
//       this._totalRatingValue = totalRatingValue;
//     }
//     if (averageRating != null) {
//       this._averageRating = averageRating;
//     }
//     if (fiveStarRating != null) {
//       this._fiveStarRating = fiveStarRating;
//     }
//     if (fourStarRating != null) {
//       this._fourStarRating = fourStarRating;
//     }
//     if (threeStarRating != null) {
//       this._threeStarRating = threeStarRating;
//     }
//     if (twoStarRating != null) {
//       this._twoStarRating = twoStarRating;
//     }
//     if (oneStarRating != null) {
//       this._oneStarRating = oneStarRating;
//     }
//   }

//   int? get id => _id;
//   set id(int? id) => _id = id;
//   String? get totalRatings => _totalRatings;
//   set totalRatings(String? totalRatings) => _totalRatings = totalRatings;
//   String? get totalRatingValue => _totalRatingValue;
//   set totalRatingValue(String? totalRatingValue) =>
//       _totalRatingValue = totalRatingValue;
//   String? get averageRating => _averageRating;
//   set averageRating(String? averageRating) => _averageRating = averageRating;
//   String? get fiveStarRating => _fiveStarRating;
//   set fiveStarRating(String? fiveStarRating) =>
//       _fiveStarRating = fiveStarRating;
//   String? get fourStarRating => _fourStarRating;
//   set fourStarRating(String? fourStarRating) =>
//       _fourStarRating = fourStarRating;
//   String? get threeStarRating => _threeStarRating;
//   set threeStarRating(String? threeStarRating) =>
//       _threeStarRating = threeStarRating;
//   String? get twoStarRating => _twoStarRating;
//   set twoStarRating(String? twoStarRating) => _twoStarRating = twoStarRating;
//   String? get oneStarRating => _oneStarRating;
//   set oneStarRating(String? oneStarRating) => _oneStarRating = oneStarRating;

//   AverageRatingsDetails.fromJson(Map<String, dynamic> json) {
//     _id = json['id'];
//     _totalRatings = json['totalRatings'];
//     _totalRatingValue = json['totalRatingValue'];
//     _averageRating = json['averageRating'];
//     _fiveStarRating = json['fiveStarRating'];
//     _fourStarRating = json['fourStarRating'];
//     _threeStarRating = json['threeStarRating'];
//     _twoStarRating = json['twoStarRating'];
//     _oneStarRating = json['oneStarRating'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this._id;
//     data['totalRatings'] = this._totalRatings;
//     data['totalRatingValue'] = this._totalRatingValue;
//     data['averageRating'] = this._averageRating;
//     data['fiveStarRating'] = this._fiveStarRating;
//     data['fourStarRating'] = this._fourStarRating;
//     data['threeStarRating'] = this._threeStarRating;
//     data['twoStarRating'] = this._twoStarRating;
//     data['oneStarRating'] = this._oneStarRating;
//     return data;
//   }
// }

