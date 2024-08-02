// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Model/ProductDetailById_Model/productDetailById_model.dart';
import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/addcart_view_model.dart';
import 'package:ecommerce/View_Model/ProductDetailById_View_Model/productDetailById_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Data/Response/status.dart';
import '../../../Utils/utils.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;
  const ProductDetailScreen({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedColor;
  String? _selectedSize;
  late Future<void> fetchDataFuture;

  String clientId = ClientId;
  String ipAddress = IpAddress;

  @override
  void initState() {
    super.initState();
    // userPreference.getToken().then((value) {
    //   setState(() {
    //     token = value!;
    //     print('Token : $token');
    //   });
    // });
    fetchDataFuture = fetchData();
  }

  // Future<void> fetchData() async {
  //   Timer(Duration(microseconds: 20), () {
  //     Map<String, String> data = {
  //       'productId': '17',
  //     };
  //     final productDetailByIdViewmodel =
  //         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
  //     productDetailByIdViewmodel.fetchProductDetailByIdApi(
  //         clientId.toString(), ipAddress.toString(), data);
  //   });
  // }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    print('productId${widget.productId.toString()}');
    Map<String, String> data = {'productId': widget.productId.toString()};
    final productDetailByIdViewmodel =
        Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
    productDetailByIdViewmodel.fetchProductDetailByIdApi(
        clientId.toString(), ipAddress.toString(), data);
  }

  @override
  Widget build(BuildContext context) {
    final productDetailByIdViewmodel =
        Provider.of<ProductDetailByIdViewmodel>(context, listen: false);

    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return Consumer<ProductDetailByIdViewmodel>(
              builder: (context, value, _) {
                switch (value.productDetailById.status!) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return handleError(value);
                  case Status.COMPLETED:
                    return _buildCompletedUI(
                        context, value, _selectedColor, _selectedSize);
                }
              },
            );
          }
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
      ),
      title: Text('Short dress', style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
            icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildCompletedUI(
      BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel,
      String? selectedColor,
      String? selectedSize) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // _buildProductImages(context, productDetailByIdViewmodel),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _buildProductInfo(context, productDetailByIdViewmodel),
                // SizedBox(height: 2.h),
                // _buildOfferPrice(),
                // SizedBox(height: 2.h),
                // _buildColorSelection(selectedColor),
                // SizedBox(height: 2.h),
                // _buildSizeSelection(selectedSize),
                _buildSizeSelection(context, productDetailByIdViewmodel),

                // SizedBox(height: 2.h),
                // _buildAddToBagButton(),
                // SizedBox(height: 2.h),
                // _buildDeliveryDetails(),
                // _buildBankOffers(),
                SizedBox(height: 2.h),
                _buildProductDetails(context, productDetailByIdViewmodel),
                SizedBox(height: 2.h),
                _buildCustomerInfo(),
                SizedBox(height: 2.h),
                _buildRatings(),
                _buildReturnsInfo(),
                _buildRelatedProducts(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImages(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    List<dynamic> decodedList = jsonDecode(productDetailByIdViewmodel
        .productDetailById.data!.productList![0].productGallery
        .toString());

    final List<String> _productImages = decodedList.cast<String>();
    String convertLocalhost(String url) {
      return url.replaceAll('http://localhost', 'http://10.0.2.2');
    }

    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              convertLocalhost(_productImages[index]),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productDetailByIdViewmodel
              .productDetailById.data!.productList![0].productName
              .toString(),
          style: TextStyle(
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        SizedBox(height: 12.0),
        _buildRatingContainer(context, productDetailByIdViewmodel),
        SizedBox(height: 8.0),
        _buildPriceInfo(context, productDetailByIdViewmodel),
      ],
    );
  }

  Widget _buildRatingContainer(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return IntrinsicWidth(
      child: Container(
        padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
        decoration: BoxDecoration(
          color: Colors.green.shade800,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                productDetailByIdViewmodel.productDetailById.data!
                    .productList![0].averageRatingsDetails![0].averageRating
                    .toString(),
                style: TextStyle(
                    color: Colors.white, fontSize: descriptionFontSize)),
            SizedBox(width: 2), // Add a small space between text and icon
            Icon(Icons.star, size: 2.h, color: Colors.white),
            Text(
                ' | ${productDetailByIdViewmodel.productDetailById.data!.productList![0].averageRatingsDetails![0].totalRatings.toString()}',
                style: TextStyle(
                    color: Colors.white, fontSize: descriptionFontSize)),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceInfo(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
                '\u20B9 ${productDetailByIdViewmodel.productDetailById.data!.productList![0].minSalePrice.toString()}',
                style: TextStyle(
                    fontSize: titleFontSize, fontWeight: FontWeight.bold)),
            Text('  MRP ',
                style: TextStyle(
                    fontSize: titleFontSize, color: Colors.grey.shade800)),
            Icon(Icons.currency_rupee_sharp, size: 2.h),
            Text(
                productDetailByIdViewmodel
                    .productDetailById.data!.productList![0].saleStartsAt
                    .toString(),
                style: TextStyle(
                    fontSize: titleFontSize,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.shade800)),
            Text(
                ' ${productDetailByIdViewmodel.productDetailById.data!.productList![0].discountedPercentage.toString()}% off',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text('Price inclusive of all taxes.',
            style:
                TextStyle(color: Colors.grey, fontSize: descriptionFontSize)),
      ],
    );
  }

  Widget _buildOfferPrice() {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              height: 13.h,
              width: 50.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Offer Price \$399',
                      style: TextStyle(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  SizedBox(height: 2.h),
                  Text('Free Shipping on 799 and above.just',
                      style: TextStyle(fontSize: subDescriptionFontSize)),
                  SizedBox(height: 0.5.h),
                  Text('for you.View All Products',
                      style: TextStyle(fontSize: subDescriptionFontSize)),
                ],
              ),
            ),
            Container(
              height: 10.h,
              width: 30.w,
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Use Code',
                      style: TextStyle(fontSize: descriptionFontSize)),
                  Text(' FREEDEL ',
                      style: TextStyle(fontSize: descriptionFontSize)),
                  SizedBox(height: 1.h),
                  Text('T & C ',
                      style: TextStyle(
                          fontSize: descriptionFontSize, color: Colors.blue)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelection(String? selectedColor) {
    final List<Color> _colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.pink,
      Colors.black,
      Colors.brown,
      Colors.blueGrey,
      Colors.deepOrangeAccent
    ];
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Color',
                style: TextStyle(
                    fontSize: titleFontSize, fontWeight: FontWeight.bold)),
            SizedBox(height: 1.h),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _colors.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Update selected color
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          style: BorderStyle.solid,
                          color: selectedColor ==
                                  _colors[index].value.toRadixString(16)
                              ? Colors.grey
                              : Colors.transparent,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: CircleAvatar(backgroundColor: _colors[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildSizeSelection(String? selectedSize) {
  //   final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'];
  //   return Card(
  //     child: Padding(
  //       padding: EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text('Select Size',
  //               style: TextStyle(
  //                   fontSize: titleFontSize, fontWeight: FontWeight.bold)),
  //           SizedBox(height: 2.h),
  //           SizedBox(
  //             height: 7.h,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: _sizes.length,
  //               itemBuilder: (context, index) {
  //                 return GestureDetector(
  //                   onTap: () {
  //                     // Update selected size
  //                   },
  //                   child: Card(
  //                     color: selectedSize == _sizes[index]
  //                         ? Colors.black
  //                         : Colors.white,
  //                     child: Padding(
  //                       padding: EdgeInsets.all(8.0),
  //                       child: Container(
  //                         width: 8.w,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(4.0)),
  //                         child: Center(
  //                             child: Text(_sizes[index],
  //                                 style: TextStyle(
  //                                     color: selectedSize == _sizes[index]
  //                                         ? Colors.white
  //                                         : Colors.black))),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildSizeSelection(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return SizeDetailsCard(
      productList:
          productDetailByIdViewmodel.productDetailById.data!.productList![0],
      // productDescription: productDetailByIdViewmodel
      //     .productDetailById.data!.productList![0].productDescription
      //     .toString(),
      // productShortDescription: productDetailByIdViewmodel
      //     .productDetailById.data!.productList![0].productShortDescription
      //     .toString(),
    );
  }

  Widget _buildAddToBagButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Add To Bag'),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          padding: EdgeInsets.symmetric(vertical: 16.0),
        ),
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Card(
      child: Container(
        width: 100.w,
        height: 10.h,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Details',
                  style: TextStyle(
                      fontSize: titleFontSize, fontWeight: FontWeight.bold)),
              Text('Check delivery date',
                  style: TextStyle(
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankOffers() {
    return BankOffersCard();
  }

  Widget _buildProductDetails(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return ProductDetailsCard(
      productDescription: productDetailByIdViewmodel
          .productDetailById.data!.productList![0].productDescription
          .toString(),
      productShortDescription: productDetailByIdViewmodel
          .productDetailById.data!.productList![0].productShortDescription
          .toString(),
    );
  }

  Widget _buildCustomerInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem(
                Icons.sentiment_satisfied, '18 Million+', 'Happy Customers'),
            _buildInfoItem(Icons.verified, 'Genuine', 'Product'),
            _buildInfoItem(Icons.security, 'Quality', 'Checked'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue),
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(subtitle, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildRatings() {
    // Implement ratings widget
    return Container(); // Placeholder
  }

  Widget _buildReturnsInfo() {
    // Implement returns info widget
    return Container(); // Placeholder
  }

  Widget _buildRelatedProducts() {
    // Implement related products widget
    return Container(); // Placeholder
  }

  Widget handleError(ProductDetailByIdViewmodel value) {
    String? message;
    if (value.productDetailById.message != "No Internet Connection") {
      String jsonString = value.productDetailById.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.productDetailById.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.productDetailById.message.toString(),
          )
        : Text('data');
  }

// Additional widget classes (BankOffersCard, ProductDetailsCard, SmallImageCard) would be implemented here
}

class SmallImageCard extends StatelessWidget {
  final String imageUrl;
  final String? text; // Added an optional text parameter

  SmallImageCard({required this.imageUrl, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  imageUrl,
                  height: 24.h,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'FOSSIL',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: descriptionFontSize,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '\$200',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: descriptionFontSize,
                            ),
                          ),
                          // if (product['discountPercentage'] > 0)
                          Text(
                            ' (20% off)',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: descriptionFontSize,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < 1 ? Icons.star : Icons.star_border,
                            size: 16,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // if (text != null) // Check if text is not null
                // Positioned(
                //   top: 8.0, // Adjust the position as needed
                //   left: 8.0,
                //   child: Container(
                //     padding: EdgeInsets.all(4),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Colors.black,
                //     ),
                //     child: Text(
                //       // text!,
                //       "New",
                //       style: TextStyle(
                //         color: Colors.white, // Adjust the text color as needed
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BankOffersCard extends StatefulWidget {
  @override
  _BankOffersCardState createState() => _BankOffersCardState();
}

class _BankOffersCardState extends State<BankOffersCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: 100.w,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bank Offers',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? '- Hide offers' : '+ 7 More offers',
                      style: TextStyle(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.account_balance),
                title: Text(
                  'Get 5% instant Prepaid discount upto Rs. 750 (per transaction) on 9999/- or above',
                  style: TextStyle(fontSize: descriptionFontSize),
                ),
              ),
              ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text(
                  'Get upto 15% Mobikwik Cashback on a minimum transaction of Rs 1500 on paying using Mobikwik wallet.',
                  style: TextStyle(fontSize: descriptionFontSize),
                ),
              ),
              if (_isExpanded)
                Column(
                  children: [
                    // Add additional ListTile items here
                    ListTile(
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text(
                        'Get 5% instant Prepaid discount upto Rs. 750 (per transaction) on 9999/- or above',
                        style: TextStyle(fontSize: descriptionFontSize),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_balance_wallet),
                      title: Text(
                        'Get upto 15% Mobikwik Cashback on a minimum transaction of Rs 1500 on paying using Mobikwik wallet.',
                        style: TextStyle(fontSize: descriptionFontSize),
                      ),
                    ),
                    // Add more ListTile items as needed
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SizeDetailsCard extends StatefulWidget {
  final ProductList productList;
  // final String productShortDescription;

  SizeDetailsCard({
    required this.productList,
    // required this.productShortDescription,
  });

  @override
  _SizeDetailsCardState createState() => _SizeDetailsCardState();
}

class _SizeDetailsCardState extends State<SizeDetailsCard> {
  ProductList? productData;
  Map<String, String> selectedAttributes = {};
  List<Variants> variants = [];
  List<Attributes> attributes = [];
  List<String> attributeOrder = [];
  String? isQualityRuleApply;
  int? minQuantity;
  int? maxQuantity;
  int currentQuantity = 1; // Default to 1 or minQuantity if available
  late List<String> _productImages;
  String? selectedVariantId;
  String? selectedVariantAttributeDetailsId;
  String ipAddress = IpAddress;
  @override
  void initState() {
    super.initState();
    productData = widget.productList;
    variants = widget.productList.variants!;
    attributes = widget.productList.attributes!;
    isQualityRuleApply = productData!.isQualityRuleApply;
    minQuantity = productData!.minQuantity != null
        ? int.tryParse(productData!.minQuantity!)
        : null;
    maxQuantity = productData!.maxQuantity != null
        ? int.tryParse(productData!.maxQuantity!)
        : null;
    currentQuantity = minQuantity ?? 1;

    initializeAttributes();
    selectDefaultAttributes();
    _updateProductImages();
  }

  void initializeAttributes() {
    Map<String, Set<String>> attributeValues = {};
    for (var attribute in attributes) {
      if (!attributeValues.containsKey(attribute.name)) {
        attributeValues[attribute.name.toString()] = {};
      }
      attributeValues[attribute.name]!.add(attribute.value.toString());
    }
    attributeOrder = attributeValues.keys.toList();
    for (var attr in attributeOrder) {
      selectedAttributes[attr] = '';
    }
  }

  void selectDefaultAttributes() {
    for (String attr in attributeOrder) {
      List<String> options = getAvailableOptions(attr);
      for (String option in options) {
        if (isOptionAvailable(attr, option)) {
          selectAttribute(attr, option);
          break;
        }
      }
    }
  }

  List<String> getAvailableOptions(String attributeName) {
    return attributes
        .where((attr) => attr.name == attributeName)
        .map((attr) => attr.value as String)
        .toSet()
        .toList();
  }

  bool isOptionAvailable(String attributeName, String option) {
    // If it's the first attribute (usually Color), it's always available
    if (attributeName == attributeOrder[0]) return true;

    // For other attributes, check if the option exists in any variant that matches the previously selected attributes
    return variants.any((variant) {
      // Check if all previously selected attributes match this variant
      for (int i = 0; i < attributeOrder.indexOf(attributeName); i++) {
        String prevAttr = attributeOrder[i];
        String selectedValue = selectedAttributes[prevAttr]!;

        if (i == 0) {
          // For the first attribute, check against attributeDetails
          if (variant.attributeDetails?.value != selectedValue) return false;
        } else {
          // For subsequent attributes, check against the variant key
          if (!variant.variantkey!.contains(selectedValue)) return false;
        }
      }

      // If we've made it this far, check if the current option exists in this variant
      return variant.variantkey!.contains(option);
    });
  }

  void selectAttribute(String attributeName, String value) {
    setState(() {
      selectedAttributes[attributeName] = value;

      // Reset all attributes after the selected one
      int index = attributeOrder.indexOf(attributeName);
      for (int i = index + 1; i < attributeOrder.length; i++) {
        selectedAttributes[attributeOrder[i]] = '';
      }

      // Reselect default options for reset attributes
      for (int i = index + 1; i < attributeOrder.length; i++) {
        String attr = attributeOrder[i];
        List<String> options = getAvailableOptions(attr);
        for (String option in options) {
          if (isOptionAvailable(attr, option)) {
            selectedAttributes[attr] = option;
            break;
          }
        }
      }

      _updateProductImages();
      currentQuantity = minQuantity ?? 1;
      Variants? selectedVariant = findSelectedVariant();
      if (selectedVariant != null) {
        selectedVariantId = selectedVariant.id.toString();
        selectedVariantAttributeDetailsId =
            selectedVariant.attributeDetails?.id.toString();
        print('Selected Variant ID: ${selectedVariant.id}');
        print(
            'Selected Variant Attribute Details ID: ${selectedVariant.attributeDetails?.id}');
      }
    });
  }

  Variants? findSelectedVariant() {
    if (selectedAttributes.values.any((value) => value.isEmpty)) {
      return null;
    }

    return variants.firstWhere(
      (variant) {
        if (variant.attributeDetails?.value !=
            selectedAttributes[attributeOrder[0]]) {
          return false;
        }

        // Check if all other selected attributes are in the variant key
        for (int i = 1; i < attributeOrder.length; i++) {
          if (!variant.variantkey!
              .contains(selectedAttributes[attributeOrder[i]]!)) {
            return false;
          }
        }

        return true;
      },
      // orElse: () => null,
    );
  }

  void _updateProductImages() {
    Variants? selectedVariant = findSelectedVariant();
    if (selectedVariant != null &&
        selectedVariant.variantImageGallery != null) {
      _productImages =
          _parseImageList(selectedVariant.variantImageGallery.toString());
    } else {
      _productImages = _parseImageList(productData!.productGallery.toString());
    }
    setState(() {});
  }

  List<String> _parseImageList(String imageListString) {
    // Use a regular expression to match all URLs in the string
    RegExp urlRegex = RegExp(r"'(http[^']+)'");
    Iterable<Match> matches = urlRegex.allMatches(imageListString);

    // Extract the URLs from the matches
    List<String> imageUrls = matches.map((match) => match.group(1)!).toList();

    return imageUrls;
  }

  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost', 'http://10.0.2.2');
  }

  bool isQualityRuleApplied() {
    return isQualityRuleApply?.toLowerCase() == 'true';
  }

  void increaseQuantity() {
    setState(() {
      if (isQualityRuleApplied() && maxQuantity != null) {
        if (currentQuantity < maxQuantity!) {
          currentQuantity++;
        }
      } else {
        currentQuantity++;
      }
    });
  }

  void decreaseQuantity() {
    setState(() {
      if (isQualityRuleApplied() && minQuantity != null) {
        if (currentQuantity > minQuantity!) {
          currentQuantity--;
        }
      } else if (currentQuantity > 1) {
        currentQuantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _productImages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.network(
                convertLocalhost(_productImages[index]),
                fit: BoxFit.fill,
                height: 50.h,
                width: 90.w,
              ),
            );
          },
        ),
      ),
      SizedBox(height: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productData!.productName.toString(),
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          productData!.averageRatingsDetails!.isNotEmpty
              ? SizedBox(height: 12.0)
              : Container(),
          _buildRatingContainer(context, productData!),
          SizedBox(height: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('\u20B9 ${findSelectedVariant()!.price}',
                      style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold)),
                  Text('  MRP ',
                      style: TextStyle(
                          fontSize: titleFontSize,
                          color: Colors.grey.shade800)),
                  Icon(Icons.currency_rupee_sharp, size: 2.h),
                  Text(productData!.saleStartsAt.toString(),
                      style: TextStyle(
                          fontSize: titleFontSize,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade800)),
                  Text(' ${productData!.discountedPercentage.toString()}% off',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 0.5.h),
              Text('Price inclusive of all taxes.',
                  style: TextStyle(
                      color: Colors.grey, fontSize: descriptionFontSize)),
            ],
          ),
        ],
      ),
      SizedBox(height: 1.h),
      Card(
        child: Container(
          width: 100.w,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                ...buildAttributeSelectors(),
                SizedBox(height: 16),
                // Display selected variant info
                // if (findSelectedVariant() != null) ...[
                //   Text('Selected Variant:'),
                //   Text('Price: ${findSelectedVariant()!.price}'),
                //   Text('Stock: ${findSelectedVariant()!.stock}'),
                //   Text('Image: ${findSelectedVariant()!.variantImageGallery}'),
                // ],

                SizedBox(height: 16),

                Text(
                  'Quantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                QuantitySelector(
                  quantity: currentQuantity,
                  onIncrement: increaseQuantity,
                  onDecrement: decreaseQuantity,
                  canIncrement: !isQualityRuleApplied() ||
                      maxQuantity == null ||
                      currentQuantity < maxQuantity!,
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 1.h),
      findSelectedVariant()!.stock != '0'
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Map<String, String> data = {
                    'clientId': ClientId,
                    'customerId': CustomerId,
                    'productId': productData!.id.toString(),
                    'productAttributeId':
                        selectedVariantAttributeDetailsId.toString(),
                    'productVariantId': selectedVariantId.toString(),
                    'qty': currentQuantity.toString(),
                    'created_by': productData!.createdBy.toString(),
                  };

                  final addCartViewModel =
                      Provider.of<AddCartViewModel>(context, listen: false);

                  addCartViewModel.addCartApi(
                      ipAddress.toString(), data, context);
                },
                child: Text('Add To Cart'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Notify Me'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
    ]);
  }

  Widget _buildRatingContainer(BuildContext context, ProductList productData) {
    return productData.averageRatingsDetails!.isNotEmpty
        ? IntrinsicWidth(
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      productData.averageRatingsDetails![0].averageRating
                          .toString(),
                      style: TextStyle(
                          color: Colors.white, fontSize: descriptionFontSize)),
                  SizedBox(width: 2), // Add a small space between text and icon
                  Icon(Icons.star, size: 2.h, color: Colors.white),
                  Text(
                      ' | ${productData.averageRatingsDetails![0].totalRatings.toString()}',
                      style: TextStyle(
                          color: Colors.white, fontSize: descriptionFontSize)),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildPriceInfo(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
                '\u20B9 ${productDetailByIdViewmodel.productDetailById.data!.productList![0].minSalePrice.toString()}',
                style: TextStyle(
                    fontSize: titleFontSize, fontWeight: FontWeight.bold)),
            Text('  MRP ',
                style: TextStyle(
                    fontSize: titleFontSize, color: Colors.grey.shade800)),
            Icon(Icons.currency_rupee_sharp, size: 2.h),
            Text(
                productDetailByIdViewmodel
                    .productDetailById.data!.productList![0].saleStartsAt
                    .toString(),
                style: TextStyle(
                    fontSize: titleFontSize,
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey.shade800)),
            Text(
                ' ${productDetailByIdViewmodel.productDetailById.data!.productList![0].discountedPercentage.toString()}% off',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 0.5.h),
        Text('Price inclusive of all taxes.',
            style:
                TextStyle(color: Colors.grey, fontSize: descriptionFontSize)),
      ],
    );
  }

  List<Widget> buildAttributeSelectors() {
    return attributeOrder.map((attr) => buildAttributeSection(attr)).toList();
  }

  Widget buildAttributeSection(String attributeName) {
    List<String> allOptions = getAvailableOptions(attributeName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$attributeName:', style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 8,
          children: allOptions
              .map((option) => buildSelectionChip(option, attributeName))
              .toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget buildSelectionChip(String label, String attributeName) {
    bool isSelected = selectedAttributes[attributeName] == label;
    bool isAvailable = isOptionAvailable(attributeName, label);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: isAvailable
          ? (bool selected) {
              if (selected) {
                selectAttribute(attributeName, label);
              }
            }
          : null,
      backgroundColor: isAvailable ? null : Colors.grey[300],
      disabledColor: Colors.grey[300],
      selectedColor: isAvailable ? Colors.black87 : Colors.grey[300],
      labelStyle: TextStyle(
        color: isAvailable
            ? (isSelected ? Colors.white : Colors.black)
            : Colors.grey[600],
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool canIncrement;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.canIncrement = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: onDecrement,
            color: Colors.black,
          ),
          SizedBox(width: 8),
          Text(
            quantity.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          _buildButton(
            icon: Icons.add,
            onPressed: canIncrement ? onIncrement : null,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required Color color,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        customBorder: CircleBorder(),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 24,
            color: onPressed == null ? Colors.grey : color,
          ),
        ),
      ),
    );
  }
}

class ProductDetailsCard extends StatefulWidget {
  final String productDescription;
  final String productShortDescription;

  ProductDetailsCard({
    required this.productDescription,
    required this.productShortDescription,
  });

  @override
  _ProductDetailsCardState createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    String productDescription = json.decode(widget.productDescription);
    String productShortDescription =
        json.decode(widget.productShortDescription);

    return Card(
      child: Container(
        width: 100.w,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Details',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? '- Less' : '+ More',
                      style: TextStyle(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Html(
                data: productDescription,
                style: {
                  'h3': Style(
                    fontWeight:
                        FontWeight.normal, // Remove bold style from h3 tag
                    fontStyle:
                        FontStyle.normal, // Remove italic style from h3 tag
                    textDecoration: TextDecoration
                        .none, // Remove underline style from h3 tag
                  ),
                  'b': Style(
                    fontWeight:
                        FontWeight.normal, // Remove bold style from b tag
                  ),
                  'u': Style(
                    textDecoration: TextDecoration
                        .none, // Remove underline style from u tag
                  ),
                  'p': Style(
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    margin: EdgeInsets.zero, // Remove margin from p tag

                    fontWeight:
                        FontWeight.normal, // Remove bold style from p tag
                    fontStyle:
                        FontStyle.normal, // Remove italic style from p tag
                    textDecoration: TextDecoration
                        .none, // Remove underline style from p tag
                  ),
                },
                customRender: {
                  'img': (RenderContext context, Widget child) {
                    if (context.tree.element!.attributes.containsKey('src')) {
                      // Remove the substring limitation to include the entire image tag
                      return Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 15,
                          child: Image.asset('images/obj.png'));
                    }
                    return child;
                  },
                },
                onLinkTap: (url, _, __, ___) {
                  // Handle link tap here
                },
                onImageTap: (src, _, __, ___) {
                  // Handle image tap here
                },
                onImageError: (exception, stackTrace) {
                  // Handle image error here
                },
                // Add any additional properties or callbacks you require
              ),
              if (_isExpanded) ...[
                SizedBox(height: 16),
                Html(
                  data: productShortDescription,
                  style: {
                    'h3': Style(
                      fontWeight:
                          FontWeight.normal, // Remove bold style from h3 tag
                      fontStyle:
                          FontStyle.normal, // Remove italic style from h3 tag
                      textDecoration: TextDecoration
                          .none, // Remove underline style from h3 tag
                    ),
                    'b': Style(
                      fontWeight:
                          FontWeight.normal, // Remove bold style from b tag
                    ),
                    'u': Style(
                      textDecoration: TextDecoration
                          .none, // Remove underline style from u tag
                    ),
                    'p': Style(
                      maxLines: 2,
                      textOverflow: TextOverflow.ellipsis,
                      margin: EdgeInsets.zero, // Remove margin from p tag

                      fontWeight:
                          FontWeight.normal, // Remove bold style from p tag
                      fontStyle:
                          FontStyle.normal, // Remove italic style from p tag
                      textDecoration: TextDecoration
                          .none, // Remove underline style from p tag
                    ),
                  },
                  customRender: {
                    'img': (RenderContext context, Widget child) {
                      if (context.tree.element!.attributes.containsKey('src')) {
                        // Remove the substring limitation to include the entire image tag
                        return Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 15,
                            child: Image.asset('images/obj.png'));
                      }
                      return child;
                    },
                  },
                  onLinkTap: (url, _, __, ___) {
                    // Handle link tap here
                  },
                  onImageTap: (src, _, __, ___) {
                    // Handle image tap here
                  },
                  onImageError: (exception, stackTrace) {
                    // Handle image error here
                  },
                  // Add any additional properties or callbacks you require
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

// // Static response (unchanged)
// const String staticResponse =
//     '''
// {
//   "status": true,
//   "productList": [
//     {
//       "id": 23,
//       "productName": "Mattel Uno Playing Card Game",
//       "saleStartsAt": "149",
//       "minSalePrice": "143",
//       "minQuantity": "10",
//       "maxQuantity": "50",
//       "mainCategoryDetails": {
//         "id": 6,
//         "mainCategoryName": "Sports"
//       },
//       "variants": [
//         {
//           "id": 107,
//           "attributeDetails": {
//             "id": 123,
//             "name": "Size",
//             "value": "Small"
//           },
//           "variantkey": "Uno Flip Side-Uno Card Game",
//           "price": "143",
//           "stock": "559"
//         },
//         {
//           "id": 108,
//           "attributeDetails": {
//             "id": 123,
//             "name": "Size",
//             "value": "Small"
//           },
//           "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno+Phase 10",
//           "price": "799",
//           "stock": "850"
//         },
//         {
//           "id": 109,
//           "attributeDetails": {
//             "id": 124,
//             "name": "Size",
//             "value": "Free Size (Pack of 2)"
//           },
//           "variantkey": "Phase 10-Card Game",
//           "price": "478",
//           "stock": "890"
//         },
//         {
//           "id": 110,
//           "attributeDetails": {
//             "id": 125,
//             "name": "Size",
//             "value": "Pack of 2"
//           },
//           "variantkey": "Uno Flip Side-Uno",
//           "price": "398",
//           "stock": "450"
//         }
//       ],
//       "attributes": [
//         {
//           "id": 123,
//           "name": "Size",
//           "value": "Small"
//         },
//         {
//           "id": 124,
//           "name": "Size",
//           "value": "Free Size (Pack of 2)"
//         },
//         {
//           "id": 125,
//           "name": "Size",
//           "value": "Pack of 2"
//         },
//         {
//           "id": 126,
//           "name": "Style Name",
//           "value": "Uno Flip Side"
//         },
//         {
//           "id": 127,
//           "name": "Style Name",
//           "value": "Phase 10"
//         },
//         {
//           "id": 128,
//           "name": "Pattern Name",
//           "value": "Uno Card Game"
//         },
//         {
//           "id": 129,
//           "name": "Pattern Name",
//           "value": "Skip_Bo+Uno+Uno+Phase 10"
//         },
//         {
//           "id": 130,
//           "name": "Pattern Name",
//           "value": "Skip_Bo+Uno+Uno flip side"
//         },
//         {
//           "id": 131,
//           "name": "Pattern Name",
//           "value": "Phase 10+Skip_Bo+Uno"
//         },
//         {
//           "id": 132,
//           "name": "Pattern Name",
//           "value": " Card Game"
//         },
//         {
//           "id": 133,
//           "name": "Pattern Name",
//           "value": "Uno"
//         }
//       ],
//       "averageRatingsDetails": [
//         {
//           "id": 18,
//           "totalRatings": "1",
//           "totalRatingValue": "5",
//           "averageRating": "1",
//           "fiveStarRating": null,
//           "fourStarRating": null,
//           "threeStarRating": null,
//           "twoStarRating": null,
//           "oneStarRating": "1"
//         }
//       ]
//     }
//   ]
// }
// ''';

// class ProductDetailScreen extends StatefulWidget {
//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Map<String, dynamic> productData;
//   Map<String, String> selectedAttributes = {};
//   List<Map<String, dynamic>> variants = [];
//   List<String> attributeOrder = [];
//   int quantity = 10;

//   @override
//   void initState() {
//     super.initState();
//     productData = json.decode(staticResponse)['productList'][0];
//     variants = List<Map<String, dynamic>>.from(productData['variants']);
//     initializeAttributes();
//   }

//   void initializeAttributes() {
//     Set<String> uniqueAttributes = {};
//     for (var variant in variants) {
//       uniqueAttributes.addAll(variant['attributeDetails'].keys);
//     }
//     attributeOrder = uniqueAttributes.toList();
//     for (var attr in attributeOrder) {
//       selectedAttributes[attr] = '';
//     }
//   }

//   List<String> getAvailableOptions(String attributeName) {
//     Set<String> options = {};
//     for (var variant in variants) {
//       if (variant['attributeDetails'][attributeName] != null) {
//         options.add(variant['attributeDetails'][attributeName]);
//       }
//     }
//     return options.toList();
//   }

//   bool isOptionAvailable(String attributeName, String option) {
//     for (var variant in variants) {
//       if (variant['attributeDetails'][attributeName] == option) {
//         bool matches = true;
//         for (var attr in selectedAttributes.keys) {
//           if (attr != attributeName &&
//               selectedAttributes[attr]!.isNotEmpty &&
//               variant['attributeDetails'][attr] != selectedAttributes[attr]) {
//             matches = false;
//             break;
//           }
//         }
//         if (matches) return true;
//       }
//     }
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(productData['productName'])),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 productData['productName'],
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.yellow),
//                   Text(
//                       '${productData['averageRatingsDetails'][0]['averageRating']} (${productData['averageRatingsDetails'][0]['totalRatings']} Review${productData['averageRatingsDetails'][0]['totalRatings'] != '1' ? 's' : ''})'),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '\$${productData['saleStartsAt']}',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               ...buildAttributeSelectors(),
//               SizedBox(height: 16),
//               buildQuantitySelector(),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 child: Text('ADD TO CART'),
//                 onPressed: () {
//                   // Implement add to cart functionality
//                 },
//               ),
//               SizedBox(height: 8),
//               OutlinedButton(
//                 child: Text('Add to Wishlist'),
//                 onPressed: () {
//                   // Implement add to wishlist functionality
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> buildAttributeSelectors() {
//     return attributeOrder.map((attr) => buildAttributeSection(attr)).toList();
//   }

//   Widget buildAttributeSection(String attributeName) {
//     List<String> allOptions = getAvailableOptions(attributeName);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$attributeName:', style: TextStyle(fontWeight: FontWeight.bold)),
//         Wrap(
//           spacing: 8,
//           children: allOptions
//               .map((option) => buildSelectionChip(option, attributeName))
//               .toList(),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildSelectionChip(String label, String attributeName) {
//     bool isSelected = selectedAttributes[attributeName] == label;
//     bool isAvailable = isOptionAvailable(attributeName, label);

//     return ChoiceChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: isAvailable
//           ? (bool selected) {
//               setState(() {
//                 if (selected) {
//                   selectedAttributes[attributeName] = label;
//                   // Reset subsequent selections
//                   int currentIndex = attributeOrder.indexOf(attributeName);
//                   for (int i = currentIndex + 1;
//                       i < attributeOrder.length;
//                       i++) {
//                     selectedAttributes[attributeOrder[i]] = '';
//                   }
//                 } else {
//                   selectedAttributes[attributeName] = '';
//                 }
//               });
//             }
//           : null,
//       backgroundColor: isAvailable ? null : Colors.grey[300],
//       disabledColor: Colors.grey[300],
//       selectedColor:
//           isAvailable ? Theme.of(context).primaryColor : Colors.grey[300],
//       labelStyle: TextStyle(
//         color: isAvailable
//             ? (isSelected ? Colors.white : Colors.black)
//             : Colors.grey[600],
//       ),
//     );
//   }

//   Widget buildQuantitySelector() {
//     return Row(
//       children: [
//         Text('Qty:', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(width: 8),
//         IconButton(
//           icon: Icon(Icons.remove),
//           onPressed: () {
//             if (quantity > int.parse(productData['minQuantity'])) {
//               setState(() {
//                 quantity--;
//               });
//             }
//           },
//         ),
//         Text(quantity.toString()),
//         IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {
//             if (quantity < int.parse(productData['maxQuantity'])) {
//               setState(() {
//                 quantity++;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// // Static response for testing (you would replace this with actual API call)
// const String staticResponse =
//     '''
// {
//   "status": true,
//   "productList": [
//     {
//       "id": 23,
//       "productName": "Mattel Uno Playing Card Game",
//       "saleStartsAt": "149",
//       "minSalePrice": "143",
//       "minQuantity": "10",
//       "maxQuantity": "50",
//       "mainCategoryDetails": {
//         "id": 6,
//         "mainCategoryName": "Sports"
//       },
//       "variants": [
//         {
//           "id": 107,
//           "attributeDetails": {
//             "Size": "Small",
//             "Style Name": "Uno Flip Side",
//             "Pattern Name": "Uno Card Game"
//           },
//           "price": "143",
//           "stock": "559"
//         },
//         {
//           "id": 108,
//           "attributeDetails": {
//             "Size": "Small",
//             "Style Name": "Uno Flip Side",
//             "Pattern Name": "Skip_Bo+Uno+Uno+Phase 10"
//           },
//           "price": "799",
//           "stock": "850"
//         },
//         {
//           "id": 109,
//           "attributeDetails": {
//             "Size": "Free Size (Pack of 2)",
//             "Style Name": "Phase 10",
//             "Pattern Name": "Card Game"
//           },
//           "price": "478",
//           "stock": "890"
//         },
//         {
//           "id": 110,
//           "attributeDetails": {
//             "Size": "Pack of 2",
//             "Style Name": "Uno Flip Side",
//             "Pattern Name": "Uno"
//           },
//           "price": "398",
//           "stock": "450"
//         }
//       ],
//       "averageRatingsDetails": [
//         {
//           "id": 18,
//           "totalRatings": "1",
//           "totalRatingValue": "5",
//           "averageRating": "1",
//           "fiveStarRating": null,
//           "fourStarRating": null,
//           "threeStarRating": null,
//           "twoStarRating": null,
//           "oneStarRating": "1"
//         }
//       ]
//     }
//   ]
// }
// ''';

// class ProductDetailScreen extends StatefulWidget {
//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Map<String, dynamic> productData;
//   Map<String, String> selectedAttributes = {};
//   List<Map<String, dynamic>> variants = [];
//   List<Map<String, dynamic>> attributes = [];
//   List<String> attributeOrder = [];
//   int quantity = 10;

//   @override
//   void initState() {
//     super.initState();
//     productData = json.decode(staticResponse)['productList'][0];
//     variants = List<Map<String, dynamic>>.from(productData['variants']);
//     attributes = List<Map<String, dynamic>>.from(productData['attributes']);
//     initializeAttributes();
//   }

//   void initializeAttributes() {
//     Set<String> uniqueAttributes = {};
//     for (var attribute in attributes) {
//       uniqueAttributes.add(attribute['name']);
//     }
//     attributeOrder = uniqueAttributes.toList();
//     for (var attr in attributeOrder) {
//       selectedAttributes[attr] = '';
//     }
//   }

//   List<String> getAvailableOptions(String attributeName) {
//     return attributes
//         .where((attr) => attr['name'] == attributeName)
//         .map((attr) => attr['value'] as String)
//         .toList();
//   }

//   bool isOptionAvailable(String attributeName, String option) {
//     if (attributeName == 'Size') {
//       return true; // All sizes are always available
//     }

//     String selectedSize = selectedAttributes['Size'] ?? '';

//     if (attributeName == 'Style Name') {
//       List<dynamic> availableStyles = variants
//           .where((v) => v['attributeDetails']['value'] == selectedSize)
//           .map((v) => v['variantkey'].split('-')[0])
//           .toSet()
//           .toList();
//       return availableStyles.contains(option);
//     }

//     if (attributeName == 'Pattern Name') {
//       List<dynamic> availablePatterns = variants
//           .where((v) => v['attributeDetails']['value'] == selectedSize)
//           .map((v) => v['variantkey'].split('-')[1])
//           .toSet()
//           .toList();
//       return availablePatterns.contains(option);
//     }

//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(productData['productName'])),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 productData['productName'],
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.yellow),
//                   Text(
//                       '${productData['averageRatingsDetails'][0]['averageRating']} (${productData['averageRatingsDetails'][0]['totalRatings']} Review${productData['averageRatingsDetails'][0]['totalRatings'] != '1' ? 's' : ''})'),
//                 ],
//               ),
//               SizedBox(height: 8),
//               Text(
//                 '\$${productData['saleStartsAt']}',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               ...buildAttributeSelectors(),
//               SizedBox(height: 16),
//               buildQuantitySelector(),
//               SizedBox(height: 16),
//               ElevatedButton(
//                 child: Text('ADD TO CART'),
//                 onPressed: () {
//                   // Implement add to cart functionality
//                 },
//               ),
//               SizedBox(height: 8),
//               OutlinedButton(
//                 child: Text('Add to Wishlist'),
//                 onPressed: () {
//                   // Implement add to wishlist functionality
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   List<Widget> buildAttributeSelectors() {
//     return attributeOrder.map((attr) => buildAttributeSection(attr)).toList();
//   }

//   Widget buildAttributeSection(String attributeName) {
//     List<String> allOptions = getAvailableOptions(attributeName);

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('$attributeName:', style: TextStyle(fontWeight: FontWeight.bold)),
//         Wrap(
//           spacing: 8,
//           children: allOptions
//               .map((option) => buildSelectionChip(option, attributeName))
//               .toList(),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }

//   Widget buildSelectionChip(String label, String attributeName) {
//     bool isSelected = selectedAttributes[attributeName] == label;
//     bool isAvailable = isOptionAvailable(attributeName, label);

//     return ChoiceChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: isAvailable
//           ? (bool selected) {
//               setState(() {
//                 if (selected) {
//                   selectedAttributes[attributeName] = label;
//                   // Reset subsequent selections
//                   int currentIndex = attributeOrder.indexOf(attributeName);
//                   for (int i = currentIndex + 1;
//                       i < attributeOrder.length;
//                       i++) {
//                     selectedAttributes[attributeOrder[i]] = '';
//                   }
//                 } else {
//                   selectedAttributes[attributeName] = '';
//                 }
//               });
//             }
//           : null,
//       backgroundColor: isAvailable ? null : Colors.grey[300],
//       disabledColor: Colors.grey[300],
//       selectedColor:
//           isAvailable ? Theme.of(context).primaryColor : Colors.grey[300],
//       labelStyle: TextStyle(
//         color: isAvailable
//             ? (isSelected ? Colors.white : Colors.black)
//             : Colors.grey[600],
//       ),
//     );
//   }

//   Widget buildQuantitySelector() {
//     return Row(
//       children: [
//         Text('Qty:', style: TextStyle(fontWeight: FontWeight.bold)),
//         SizedBox(width: 8),
//         IconButton(
//           icon: Icon(Icons.remove),
//           onPressed: () {
//             if (quantity > int.parse(productData['minQuantity'])) {
//               setState(() {
//                 quantity--;
//               });
//             }
//           },
//         ),
//         Text(quantity.toString()),
//         IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {
//             if (quantity < int.parse(productData['maxQuantity'])) {
//               setState(() {
//                 quantity++;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// const String staticResponse =
//     '''
// {
//   "status": true,
//   "productList": [
//     {
//       "id": 23,
//       "productName": "Mattel Uno Playing Card Game",
//       "saleStartsAt": "149",
//       "minSalePrice": "143",
//       "minQuantity": "10",
//       "maxQuantity": "50",
//       "mainCategoryDetails": {
//         "id": 6,
//         "mainCategoryName": "Sports"
//       },
//       "variants": [
//         {
//           "id": 107,
//           "attributeDetails": {
//             "id": 123,
//             "name": "Size",
//             "value": "Small"
//           },
//           "variantkey": "Uno Flip Side-Uno Card Game",
//           "price": "143",
//           "stock": "559"
//         },
//         {
//           "id": 108,
//           "attributeDetails": {
//             "id": 123,
//             "name": "Size",
//             "value": "Small"
//           },
//           "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno+Phase 10",
//           "price": "799",
//           "stock": "850"
//         },
//         {
//           "id": 109,
//           "attributeDetails": {
//             "id": 124,
//             "name": "Size",
//             "value": "Free Size (Pack of 2)"
//           },
//           "variantkey": "Phase 10-Card Game",
//           "price": "478",
//           "stock": "890"
//         },
//         {
//           "id": 110,
//           "attributeDetails": {
//             "id": 125,
//             "name": "Size",
//             "value": "Pack of 2"
//           },
//           "variantkey": "Uno Flip Side-Uno",
//           "price": "398",
//           "stock": "450"
//         }
//       ],
//       "attributes": [
//         {
//           "id": 123,
//           "name": "Size",
//           "value": "Small"
//         },
//         {
//           "id": 124,
//           "name": "Size",
//           "value": "Free Size (Pack of 2)"
//         },
//         {
//           "id": 125,
//           "name": "Size",
//           "value": "Pack of 2"
//         },
//         {
//           "id": 126,
//           "name": "Style Name",
//           "value": "Uno Flip Side"
//         },
//         {
//           "id": 127,
//           "name": "Style Name",
//           "value": "Phase 10"
//         },
//         {
//           "id": 128,
//           "name": "Pattern Name",
//           "value": "Uno Card Game"
//         },
//         {
//           "id": 129,
//           "name": "Pattern Name",
//           "value": "Skip_Bo+Uno+Uno+Phase 10"
//         },
//         {
//           "id": 130,
//           "name": "Pattern Name",
//           "value": "Skip_Bo+Uno+Uno flip side"
//         },
//         {
//           "id": 131,
//           "name": "Pattern Name",
//           "value": "Phase 10+Skip_Bo+Uno"
//         },
//         {
//           "id": 132,
//           "name": "Pattern Name",
//           "value": " Card Game"
//         },
//         {
//           "id": 133,
//           "name": "Pattern Name",
//           "value": "Uno"
//         }
//       ],
//       "averageRatingsDetails": [
//         {
//           "id": 18,
//           "totalRatings": "1",
//           "totalRatingValue": "5",
//           "averageRating": "1",
//           "fiveStarRating": null,
//           "fourStarRating": null,
//           "threeStarRating": null,
//           "twoStarRating": null,
//           "oneStarRating": "1"
//         }
//       ]
//     }
//   ]
// }
// ''';

