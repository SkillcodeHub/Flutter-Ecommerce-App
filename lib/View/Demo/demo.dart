import 'dart:convert';

import 'package:flutter/material.dart';

// class ProductDetailScreen extends StatefulWidget {
//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   ProductList? productData;
//   Map<String, String> selectedAttributes = {};
//   List<Variants> variants = [];
//   List<Attributes> attributes = [];
//   List<String> attributeOrder = [];
//   int quantity = 10;
//   late Future<void> fetchDataFuture;

//   String clientId = '15';
//   String ipAddress = IpAddress;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData();

//     initializeAttributes();
//   }

//   void initializeAttributes() {}

//   List<String> getAvailableOptions(String attributeName) {
//     return attributes
//         .where((attr) => attr.name == attributeName)
//         .map((attr) => attr.value as String)
//         .toSet()
//         .toList();
//   }

//   bool isOptionAvailable(String attributeName, String option) {
//     // If it's the first attribute in the order, all options are available
//     if (attributeName == attributeOrder.first) {
//       return true;
//     }

//     // Get the index of the current attribute
//     int currentIndex = attributeOrder.indexOf(attributeName);

//     // Filter variants based on selected attributes
//     List<Variants> filteredVariants = variants.where((variant) {
//       for (int i = 0; i < currentIndex; i++) {
//         String attrName = attributeOrder[i];
//         String selectedValue = selectedAttributes[attrName]!;
//         if (selectedValue.isNotEmpty &&
//             variant.attributeDetails!.name == attrName &&
//             variant.attributeDetails!.value != selectedValue) {
//           return false;
//         }
//       }
//       return true;
//     }).toList();

//     // Check if the current option exists in the filtered variants
//     return filteredVariants.any((variant) =>
//         variant.attributeDetails!.name == attributeName &&
//         variant.attributeDetails!.value == option);
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     Map<String, String> data = {'productId': '56'};
//     final productDetailByIdViewmodel =
//         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
//     await productDetailByIdViewmodel.fetchProductDetailByIdApi(
//         clientId.toString(), ipAddress.toString(), data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(title: Text(productData['productName'])),
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return Consumer<ProductDetailByIdViewmodel>(
//               builder: (context, value, _) {
//                 switch (value.productDetailById.status!) {
//                   case Status.LOADING:
//                     return Center(child: CircularProgressIndicator());
//                   case Status.ERROR:
//                     return handleError(value);
//                   case Status.COMPLETED:
//                     return _buildCompletedUI(context, value);
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildCompletedUI(BuildContext context,
//       ProductDetailByIdViewmodel productDetailByIdViewmodel) {
//     // productData = json.decode(staticResponse)['productList'][0];
//     // variants = List<Map<String, dynamic>>.from(productData['variants']);
//     // attributes = List<Map<String, dynamic>>.from(productData['attributes']);

//     productData =
//         productDetailByIdViewmodel.productDetailById.data!.productList![0];
//     variants = productData!.variants!;
//     attributes = productData!.attributes!;
//     print('11111111111111111111111');
//     print(
//         productDetailByIdViewmodel.productDetailById.data!.productList!.length);
//     print(variants.length);
//     print(attributes.length);
//     print('11111111111111111111111');
//     Set<String> uniqueAttributes = {};
//     for (var attribute in attributes) {
//       uniqueAttributes.add(attribute.name.toString());
//     }
//     attributeOrder = uniqueAttributes.toList();
//     for (var attr in attributeOrder) {
//       selectedAttributes[attr] = '';
//     }

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               productData!.productName.toString(),
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             ...buildAttributeSelectors(),
//             SizedBox(height: 16),
//             buildQuantitySelector(),
//             SizedBox(height: 16),
//             // ElevatedButton(
//             //   child: Text('ADD TO CART'),
//             //   onPressed: () {
//             //     // Implement add to cart functionality
//             //   },
//             // ),
//             // SizedBox(height: 16),
//             // buildSelectedVariantInfo(),
//           ],
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

//     return FilterChip(
//       label: Text(label),
//       selected: isSelected,
//       onSelected: (bool selected) {
//         if (isAvailable) {
//           setState(() {
//             if (selected) {
//               selectedAttributes[attributeName] = label;
//               // Reset subsequent selections
//               int currentIndex = attributeOrder.indexOf(attributeName);
//               for (int i = currentIndex + 1; i < attributeOrder.length; i++) {
//                 selectedAttributes[attributeOrder[i]] = '';
//               }
//             } else {
//               selectedAttributes[attributeName] = '';
//             }
//           });
//         }
//       },
//       backgroundColor: isAvailable ? null : Colors.grey[300],
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
//             if (quantity > int.parse(productData!.minQuantity.toString())) {
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
//             if (quantity < int.parse(productData!.maxQuantity.toString())) {
//               setState(() {
//                 quantity++;
//               });
//             }
//           },
//         ),
//       ],
//     );
//   }

//   Widget buildSelectedVariantInfo() {
//     Variants? selectedVariant = findSelectedVariant();
//     if (selectedVariant != null) {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Selected Variant:',
//               style: TextStyle(fontWeight: FontWeight.bold)),
//           Text('Price: \$${selectedVariant.price}'),
//           Text('Stock: ${selectedVariant.stock}'),
//           SizedBox(height: 16),
//           Text('Variant Image Gallery:',
//               style: TextStyle(fontWeight: FontWeight.bold)),
//           buildImageGallery(selectedVariant.variantImageGallery.toString()),
//         ],
//       );
//     }
//     return SizedBox.shrink();
//   }

//   Widget buildImageGallery(String imageGalleryString) {
//     List<String> images = parseImageGallery(imageGalleryString);
//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: images.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: Image.network(
//               images[index],
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }

//   List<String> parseImageGallery(String imageGalleryString) {
//     // Remove the single quotes and square brackets
//     String cleanString = imageGalleryString
//         .replaceAll("'", "")
//         .replaceAll("[", "")
//         .replaceAll("]", "");
//     // Split the string by comma
//     return cleanString.split(", ");
//   }

//   Variants? findSelectedVariant() {
//     try {
//       return variants.firstWhere((variant) {
//         return attributeOrder.every((attr) {
//           return variant.attributeDetails!.name == attr &&
//               variant.attributeDetails!.value == selectedAttributes[attr];
//         });
//       });
//     } catch (e) {
//       // If no matching variant is found, return null
//       return null;
//     }
//   }

//   Widget handleError(ProductDetailByIdViewmodel value) {
//     String? message;
//     if (value.productDetailById.message != "No Internet Connection") {
//       String jsonString = value.productDetailById.message.toString();
//       int startIndex = jsonString.indexOf('{');
//       int endIndex = jsonString.lastIndexOf('}');
//       String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
//       Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
//       message = jsonResponse['message'];
//     }
//     return value.productDetailById.message == "No Internet Connection"
//         ? ErrorScreenWidget(
//             onRefresh: () async {},
//             loadingText: value.productDetailById.message.toString(),
//           )
//         : Text('data');
//   }
// }

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
//   String? _selectedColor;
//   String? _selectedSize;
//   late Future<void> fetchDataFuture;

//   String clientId = '15';
//   String ipAddress = IpAddress;

//   @override
//   void initState() {
//     super.initState();
//     productData = json.decode(staticResponse)['productList'][0];
//     variants = List<Map<String, dynamic>>.from(productData['variants']);
//     attributes = List<Map<String, dynamic>>.from(productData['attributes']);
//     fetchDataFuture = fetchData();

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

//   // bool isOptionAvailable(String attributeName, String option) {
//   //   if (attributeName == 'Size') {
//   //     return true; // All sizes are always available
//   //   }

//   //   String selectedSize = selectedAttributes['Size'] ?? '';

//   //   if (attributeName == 'Style Name') {
//   //     List<dynamic> availableStyles = variants
//   //         .where((v) => v['attributeDetails']['value'] == selectedSize)
//   //         .map((v) => v['variantkey'].split('-')[0])
//   //         .toSet()
//   //         .toList();
//   //     return availableStyles.contains(option);
//   //   }

//   //   if (attributeName == 'Pattern Name') {
//   //     List<dynamic> availablePatterns = variants
//   //         .where((v) => v['attributeDetails']['value'] == selectedSize)
//   //         .map((v) => v['variantkey'].split('-')[1])
//   //         .toSet()
//   //         .toList();
//   //     return availablePatterns.contains(option);
//   //   }

//   //   return false;
//   // }
//   bool isOptionAvailable(String attributeName, String option) {
//     // If it's the first attribute in the order, all options are available
//     if (attributeName == attributeOrder.first) {
//       return true;
//     }

//     // Get the index of the current attribute
//     int currentIndex = attributeOrder.indexOf(attributeName);

//     // Check if all previous attributes have been selected
//     for (int i = 0; i < currentIndex; i++) {
//       if (selectedAttributes[attributeOrder[i]]!.isEmpty) {
//         return false;
//       }
//     }

//     // Filter variants based on selected attributes
//     List<Map<String, dynamic>> filteredVariants = variants.where((variant) {
//       for (int i = 0; i < currentIndex; i++) {
//         String attrName = attributeOrder[i];
//         String selectedValue = selectedAttributes[attrName]!;
//         if (variant['attributeDetails']['name'] == attrName &&
//             variant['attributeDetails']['value'] != selectedValue) {
//           return false;
//         }
//       }
//       return true;
//     }).toList();

//     // Check if the current option exists in the filtered variants
//     return filteredVariants.any((variant) =>
//         variant['attributeDetails']['name'] == attributeName &&
//         variant['attributeDetails']['value'] == option);
//   }

//   // Future<void> fetchData() async {
//   //   Timer(Duration(microseconds: 20), () {
//   //     Map<String, String> data = {
//   //       'productId': '17',
//   //     };
//   //     final productDetailByIdViewmodel =
//   //         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
//   //     productDetailByIdViewmodel.fetchProductDetailByIdApi(
//   //         clientId.toString(), ipAddress.toString(), data);
//   //   });
//   // }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     Map<String, String> data = {'productId': '56'};
//     final productDetailByIdViewmodel =
//         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
//     productDetailByIdViewmodel.fetchProductDetailByIdApi(
//         clientId.toString(), ipAddress.toString(), data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productDetailByIdViewmodel =
//         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(title: Text(productData['productName'])),
//       body: FutureBuilder<void>(
//         future: fetchData(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return Consumer<ProductDetailByIdViewmodel>(
//               builder: (context, value, _) {
//                 switch (value.productDetailById.status!) {
//                   case Status.LOADING:
//                     return Center(child: CircularProgressIndicator());
//                   case Status.ERROR:
//                     return handleError(value);
//                   case Status.COMPLETED:
//                     return _buildCompletedUI(
//                         context, value, _selectedColor, _selectedSize);
//                 }
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget handleError(ProductDetailByIdViewmodel value) {
//     String? message;
//     if (value.productDetailById.message != "No Internet Connection") {
//       String jsonString = value.productDetailById.message.toString();
//       int startIndex = jsonString.indexOf('{');
//       int endIndex = jsonString.lastIndexOf('}');
//       String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
//       Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
//       message = jsonResponse['message'];
//     }
//     return value.productDetailById.message == "No Internet Connection"
//         ? ErrorScreenWidget(
//             onRefresh: () async {},
//             loadingText: value.productDetailById.message.toString(),
//           )
//         : Text('data');
//   }

//   Widget _buildCompletedUI(
//       BuildContext context,
//       ProductDetailByIdViewmodel productDetailByIdViewmodel,
//       String? selectedColor,
//       String? selectedSize) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               productData['productName'],
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Row(
//               children: [
//                 Icon(Icons.star, color: Colors.yellow),
//                 Text(
//                     '${productData['averageRatingsDetails'][0]['averageRating']} (${productData['averageRatingsDetails'][0]['totalRatings']} Review${productData['averageRatingsDetails'][0]['totalRatings'] != '1' ? 's' : ''})'),
//               ],
//             ),
//             SizedBox(height: 8),
//             Text(
//               '\$${productData['saleStartsAt']}',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Category: ${productData['mainCategoryDetails']['mainCategoryName']} > ${productData['categoryDetails']['categoryName']} > ${productData['subCategoryDetails']['subCategoryName']}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Description:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             // Text(productData['productShortDescription']),
//             SizedBox(height: 16),
//             ...buildAttributeSelectors(),
//             SizedBox(height: 16),
//             buildQuantitySelector(),
//             SizedBox(height: 16),
//             ElevatedButton(
//               child: Text('ADD TO CART'),
//               onPressed: () {
//                 // Implement add to cart functionality
//               },
//             ),
//             SizedBox(height: 8),
//             OutlinedButton(
//               child: Text('Add to Wishlist'),
//               onPressed: () {
//                 // Implement add to wishlist functionality
//               },
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Additional Information:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ...buildAdditionalInformation(),
//           ],
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

//   List<Widget> buildAdditionalInformation() {
//     return productData['additionalInformation'].map<Widget>((info) {
//       return Padding(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('${info['title']}: ',
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             Expanded(child: Text(info['value'])),
//           ],
//         ),
//       );
//     }).toList();
//   }
// }

const String staticResponse = '''
{
  "status": true,
 "productList": [
        {
            "id": 23,
            "clientDetails": {
                "id": 1,
                "clientName": "Jayesh Bhai",
                "companyName": "Variety Shop",
                "gstNo": "22AAAAA0000A1Z5",
                "address": "The Variety Shop, Near Amit Nagar Char Rasta, Vadodara."
            },
            "mainCategoryDetails": {
                "id": 6,
                "mainCategoryName": "Sports"
            },
            "categoryDetails": {
                "id": 10,
                "categoryName": "Indoor Games"
            },
            "subCategoryDetails": {
                "id": 9,
                "subCategoryName": "Play Cards"
            },
            "productName": "Mattel Uno Playing Card Game",
            "saleStartsAt": "149",
            "minSalePrice": "143",
            "stockStatus": "InStock",
            "isQualityRuleApply": "true",
            "minQuantity": "10",
            "maxQuantity": "50",
            "outofstockSelling": "true",
            "productStock": null,
            "sku": "uno_abcd",
            "gst": null,
            "isProductHasDiscount": false,
            "isFeaturedProduct": "true",
            "isTopSellingProduct": null,
            "productStatus": "Active",
            "publishStatus": "Published",
            "activationDate": null,
            "publishTime": null,
            "isDiscountApplicable": null,
            "discountedPercentage": null,
            "related_products": [],
            "attributes": [
                {
                    "id": 123,
                    "name": "Size",
                    "value": "Small"
                },
                {
                    "id": 124,
                    "name": "Size",
                    "value": "Free Size (Pack of 2)"
                },
                {
                    "id": 125,
                    "name": "Size",
                    "value": "Pack of 2"
                },
                {
                    "id": 126,
                    "name": "Style Name",
                    "value": "Uno Flip Side"
                },
                {
                    "id": 127,
                    "name": "Style Name",
                    "value": "Phase 10"
                },
                {
                    "id": 128,
                    "name": "Pattern Name",
                    "value": "Uno Card Game"
                },
                {
                    "id": 129,
                    "name": "Pattern Name",
                    "value": "Skip_Bo+Uno+Uno+Phase 10"
                },
                {
                    "id": 130,
                    "name": "Pattern Name",
                    "value": "Skip_Bo+Uno+Uno flip side"
                },
                {
                    "id": 131,
                    "name": "Pattern Name",
                    "value": "Phase 10+Skip_Bo+Uno"
                },
                {
                    "id": 132,
                    "name": "Pattern Name",
                    "value": " Card Game"
                },
                {
                    "id": 133,
                    "name": "Pattern Name",
                    "value": "Uno"
                }
            ],
            "variants": [
                {
                    "id": 107,
                    "attributeDetails": {
                        "id": 123,
                        "name": "Size",
                        "value": "Small"
                    },
                    "variantkey": "Uno Flip Side-Uno Card Game",
                    "price": "143",
                    "stock": "559",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_71y7%2BObyWGL._SL1500__bXJPxZ6.jpg', 'http://localhost:8000/media/media/processed_7113Y3xuZrL._SL1500__bn4gFcc.jpg', 'http://localhost:8000/media/media/processed_uno_1_EEyIiNk.jpg']"
                },
                {
                    "id": 108,
                    "attributeDetails": {
                        "id": 123,
                        "name": "Size",
                        "value": "Small"
                    },
                    "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno+Phase 10",
                    "price": "799",
                    "stock": "850",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_619Wnw6AwAL._SL1001__qVn0K0w.jpg', 'http://localhost:8000/media/media/processed_71U3LyGQmlL._SL1426__eZobrBR.jpg', 'http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__Yru7EI0.jpg']"
                },
                {
                    "id": 109,
                    "attributeDetails": {
                        "id": 123,
                        "name": "Size",
                        "value": "Small"
                    },
                    "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno flip side",
                    "price": "560",
                    "stock": "300",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__kalzGiZ.jpg', 'http://localhost:8000/media/media/processed_71QTKGzApAL._SL1500__gGkCHfN.jpg', 'http://localhost:8000/media/media/processed_71y7%2BObyWGL._SL1500__LlA73bT.jpg']"
                },
                {
                    "id": 110,
                    "attributeDetails": {
                        "id": 123,
                        "name": "Size",
                        "value": "Small"
                    },
                    "variantkey": "Uno Flip Side-Phase 10+Skip_Bo+Uno",
                    "price": "656",
                    "stock": "450",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_51O9msiX9vL_3xEFhOe.jpg', 'http://localhost:8000/media/media/processed_71QTKGzApAL._SL1500__FzgJPgK.jpg', 'http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__yGf02NW.jpg']"
                },
                {
                    "id": 111,
                    "attributeDetails": {
                        "id": 124,
                        "name": "Size",
                        "value": "Free Size (Pack of 2)"
                    },
                    "variantkey": "Phase 10- Card Game",
                    "price": "478",
                    "stock": "890",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_51O9msiX9vL_kDZMPU0.jpg', 'http://localhost:8000/media/media/processed_61futYne4IL._SL1000_.jpg', 'http://localhost:8000/media/media/processed_61dofBpq8sL._SL1000__YaIretg.jpg']"
                },
                {
                    "id": 112,
                    "attributeDetails": {
                        "id": 125,
                        "name": "Size",
                        "value": "Pack of 2"
                    },
                    "variantkey": "Uno Flip Side-Uno",
                    "price": "398",
                    "stock": "450",
                    "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
                    "variantImageGallery": "['http://localhost:8000/media/media/processed_619Wnw6AwAL._SL1001__wVr5rzb.jpg', 'http://localhost:8000/media/media/processed_71545BzO4%2BL._SL1500__3kCX729.jpg', 'http://localhost:8000/media/media/processed_71aF0Ujft1L._SL1500__VN3DtL7.jpg']"
                }
            ],
            "technicalDetails": [],
            "additionalInformation": [
                {
                    "id": 81,
                    "productDetails": {
                        "id": 23,
                        "productName": "Mattel Uno Playing Card Game",
                        "productPrice": "149",
                        "productStock": null,
                        "sku": "uno_abcd",
                        "gst": null
                    },
                    "title": "Product Dimensions",
                    "value": "‎2.03 x 9.14 x 14.48 cm; 45.36 g"
                },
                {
                    "id": 82,
                    "productDetails": {
                        "id": 23,
                        "productName": "Mattel Uno Playing Card Game",
                        "productPrice": "149",
                        "productStock": null,
                        "sku": "uno_abcd",
                        "gst": null
                    },
                    "title": "Manufacturer recommended age",
                    "value": "‎7 years and up"
                },
                {
                    "id": 83,
                    "productDetails": {
                        "id": 23,
                        "productName": "Mattel Uno Playing Card Game",
                        "productPrice": "149",
                        "productStock": null,
                        "sku": "uno_abcd",
                        "gst": null
                    },
                    "title": "Manufacturer",
                    "value": "Parksons Cartamundi Pvt Ltd."
                },
                {
                    "id": 84,
                    "productDetails": {
                        "id": 23,
                        "productName": "Mattel Uno Playing Card Game",
                        "productPrice": "149",
                        "productStock": null,
                        "sku": "uno_abcd",
                        "gst": null
                    },
                    "title": "Item Weight",
                    "value": "45.3 g"
                }
            ],
            "userRatingsDetails": [
                {
                    "id": 23,
                    "customerDetails": {
                        "id": 3,
                        "customerName": "Ketan Shah",
                        "customerEmail": "hauwaddareifrei-6125@yopmail.com",
                        "profileImage": "No"
                    },
                    "starRating": "1",
                    "reviewComment": "very bad",
                    "ratingDate": "2024-06-24"
                }
            ],
            "averageRatingsDetails": [
                {
                    "id": 18,
                    "totalRatings": "1",
                    "totalRatingValue": "5",
                    "averageRating": "1",
                    "fiveStarRating": null,
                    "fourStarRating": null,
                    "threeStarRating": null,
                    "twoStarRating": null,
                    "oneStarRating": "1"
                }
            ],
            "created_at": "2024-06-18T06:06:58.115Z",
            "updated_at": "2024-07-19T10:19:31.399Z",
            "created_by": "Jayesh Bhai",
            "updated_by": "Jayesh Bhai"
        }
    ]
}
''';

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
//         .toSet()
//         .toList();
//   }

//   bool isOptionAvailable(String attributeName, String option) {
//     int attrIndex = attributeOrder.indexOf(attributeName);

//     // Size is always available
//     if (attrIndex == 0) return true;

//     // Check if all previous attributes are selected
//     for (int i = 0; i < attrIndex; i++) {
//       if (selectedAttributes[attributeOrder[i]]!.isEmpty) {
//         return false;
//       }
//     }

//     // Filter variants based on selected attributes
//     return variants.any((variant) {
//       if (variant['attributeDetails']['value'] !=
//           selectedAttributes[attributeOrder[0]]) {
//         return false;
//       }
//       List<String> variantKeyParts = variant['variantkey'].split('-');
//       for (int i = 1; i < attrIndex; i++) {
//         if (variantKeyParts[i - 1] != selectedAttributes[attributeOrder[i]]) {
//           return false;
//         }
//       }
//       return variantKeyParts[attrIndex - 1] == option;
//     });
//   }

//   void selectAttribute(String attributeName, String value) {
//     setState(() {
//       selectedAttributes[attributeName] = value;
//       // Reset all attributes after the selected one
//       int index = attributeOrder.indexOf(attributeName);
//       for (int i = index + 1; i < attributeOrder.length; i++) {
//         selectedAttributes[attributeOrder[i]] = '';
//       }
//     });
//   }

//   Map<String, dynamic>? findSelectedVariant() {
//     if (selectedAttributes.values.any((value) => value.isEmpty)) {
//       return null;
//     }

//     return variants.firstWhere(
//       (variant) {
//         String variantSize = variant['attributeDetails']['value'];
//         List<String> variantKeyParts = variant['variantkey'].split('-');
//         return variantSize == selectedAttributes[attributeOrder[0]] &&
//             attributeOrder.skip(1).every((attr) =>
//                 selectedAttributes[attr] ==
//                 variantKeyParts[attributeOrder.indexOf(attr) - 1]);
//       },
//       // orElse: () => null,
//     );
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
//                 'Description:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 16),
//               ...buildAttributeSelectors(),
//               SizedBox(height: 16),
//               // Display selected variant info
//               if (findSelectedVariant() != null) ...[
//                 Text('Selected Variant:'),
//                 Text('Price: ${findSelectedVariant()!['price']}'),
//                 Text('Stock: ${findSelectedVariant()!['stock']}'),
//               ],
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
//               if (selected) {
//                 selectAttribute(attributeName, label);
//               }
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
// }

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Map<String, dynamic> productData;
  Map<String, String> selectedAttributes = {};
  List<Map<String, dynamic>> variants = [];
  List<Map<String, dynamic>> attributes = [];
  List<String> attributeOrder = [];
  int quantity = 10;

  @override
  void initState() {
    super.initState();
    productData = json.decode(staticResponse)['productList'][0];
    variants = List<Map<String, dynamic>>.from(productData['variants']);
    attributes = List<Map<String, dynamic>>.from(productData['attributes']);
    initializeAttributes();
    selectDefaultAttributes();
  }

  void initializeAttributes() {
    Set<String> uniqueAttributes = {};
    for (var attribute in attributes) {
      uniqueAttributes.add(attribute['name']);
    }
    attributeOrder = uniqueAttributes.toList();
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
        .where((attr) => attr['name'] == attributeName)
        .map((attr) => attr['value'] as String)
        .toSet()
        .toList();
  }

  bool isOptionAvailable(String attributeName, String option) {
    int attrIndex = attributeOrder.indexOf(attributeName);

    // Size is always available
    if (attrIndex == 0) return true;

    // Check if all previous attributes are selected
    for (int i = 0; i < attrIndex; i++) {
      if (selectedAttributes[attributeOrder[i]]!.isEmpty) {
        return false;
      }
    }

    // Filter variants based on selected attributes
    return variants.any((variant) {
      if (variant['attributeDetails']['value'] !=
          selectedAttributes[attributeOrder[0]]) {
        return false;
      }
      List<String> variantKeyParts = variant['variantkey'].split('-');
      for (int i = 1; i < attrIndex; i++) {
        if (variantKeyParts[i - 1] != selectedAttributes[attributeOrder[i]]) {
          return false;
        }
      }
      return variantKeyParts[attrIndex - 1] == option;
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
    });
  }

  Map<String, dynamic>? findSelectedVariant() {
    if (selectedAttributes.values.any((value) => value.isEmpty)) {
      return null;
    }

    return variants.firstWhere(
      (variant) {
        String variantSize = variant['attributeDetails']['value'];
        List<String> variantKeyParts = variant['variantkey'].split('-');
        return variantSize == selectedAttributes[attributeOrder[0]] &&
            attributeOrder.skip(1).every((attr) =>
                selectedAttributes[attr] ==
                variantKeyParts[attributeOrder.indexOf(attr) - 1]);
      },
      // orElse: () => null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productData['productName'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ...buildAttributeSelectors(),
              SizedBox(height: 16),
              // Display selected variant info
              if (findSelectedVariant() != null) ...[
                Text('Selected Variant:'),
                Text('Price: ${findSelectedVariant()!['price']}'),
                Text('Stock: ${findSelectedVariant()!['stock']}'),
              ],
            ],
          ),
        ),
      ),
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
      selectedColor:
          isAvailable ? Theme.of(context).primaryColor : Colors.grey[300],
      labelStyle: TextStyle(
        color: isAvailable
            ? (isSelected ? Colors.white : Colors.black)
            : Colors.grey[600],
      ),
    );
  }
}




//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

//   Set<String> uniqueAttributes = {};
//   void initializeAttributes() {
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
//     print("attributeOrder");
//     print(attributeOrder);
//     print(attributeName);
//     print("attributeOrder");
//     // Assuming the first attribute is always available
//     if (attributeName == attributeOrder.first) {
//       return true;
//     }

//     // Get the index of the current attribute
//     int currentAttrIndex = attributeOrder.indexOf(attributeName);

//     // Check if all previous attributes are selected
//     for (int i = 0; i < currentAttrIndex; i++) {
//       if (selectedAttributes[attributeOrder[i]]!.isEmpty) {
//         return false;
//       }
//     }

//     // Filter variants based on selected attributes
//     List<Map<String, dynamic>> filteredVariants = variants;
//     for (int i = 0; i < currentAttrIndex; i++) {
//       String attrName = attributeOrder[i];
//       String selectedValue = selectedAttributes[attrName]!;
//       filteredVariants = filteredVariants.where((v) {
//         return v['attributeDetails'][attrName] == selectedValue;
//       }).toList();
//     }

//     // Check if the option is available in the filtered variants
//     return filteredVariants
//         .any((v) => v['attributeDetails'][attributeName] == option);
//   }

//   void selectAttribute(String attributeName, String value) {
//     selectedAttributes[attributeName] = value;

//     // Reset all attributes after the selected one
//     int index = attributeOrder.indexOf(attributeName);
//     for (int i = index + 1; i < attributeOrder.length; i++) {
//       selectedAttributes[attributeOrder[i]] = '';
//     }
//   }

//   Map<String, dynamic>? findSelectedVariant() {
//     if (selectedAttributes.values.any((value) => value.isEmpty)) {
//       return null;
//     }

//     return variants.firstWhere(
//       (variant) => attributeOrder.every((attr) =>
//           selectedAttributes[attr] == variant['attributeDetails'][attr]),
//       // orElse: () => null,
//     );
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
//               // Text(
//               //   productData['productName'],
//               //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               // ),
//               // SizedBox(height: 8),
//               // Row(
//               //   children: [
//               //     Icon(Icons.star, color: Colors.yellow),
//               //     Text(
//               //         '${productData['averageRatingsDetails'][0]['averageRating']} (${productData['averageRatingsDetails'][0]['totalRatings']} Review${productData['averageRatingsDetails'][0]['totalRatings'] != '1' ? 's' : ''})'),
//               //   ],
//               // ),
//               // SizedBox(height: 8),
//               // Text(
//               //   '\$${productData['saleStartsAt']}',
//               //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               // ),
//               // SizedBox(height: 16),
//               // Text(
//               //   'Category: ${productData['mainCategoryDetails']['mainCategoryName']} > ${productData['categoryDetails']['categoryName']} > ${productData['subCategoryDetails']['subCategoryName']}',
//               //   style: TextStyle(fontSize: 16),
//               // ),
//               // SizedBox(height: 16),
//               Text(
//                 'Description:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//               // Text(productData['productShortDescription']),
//               SizedBox(height: 16),
//               ...buildAttributeSelectors(),
//               SizedBox(height: 16),
//               // buildQuantitySelector(),
//               // SizedBox(height: 16),
//               // ElevatedButton(
//               //   child: Text('ADD TO CART'),
//               //   onPressed: () {
//               //     // Implement add to cart functionality
//               //   },
//               // ),
//               // SizedBox(height: 8),
//               // OutlinedButton(
//               //   child: Text('Add to Wishlist'),
//               //   onPressed: () {
//               //     // Implement add to wishlist functionality
//               //   },
//               // ),
//               // SizedBox(height: 16),
//               // Text(
//               //   'Additional Information:',
//               //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               // ),
//               // ...buildAdditionalInformation(),
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

//   // Widget buildQuantitySelector() {
//   //   return Row(
//   //     children: [
//   //       Text('Qty:', style: TextStyle(fontWeight: FontWeight.bold)),
//   //       SizedBox(width: 8),
//   //       IconButton(
//   //         icon: Icon(Icons.remove),
//   //         onPressed: () {
//   //           if (quantity > int.parse(productData['minQuantity'])) {
//   //             setState(() {
//   //               quantity--;
//   //             });
//   //           }
//   //         },
//   //       ),
//   //       Text(quantity.toString()),
//   //       IconButton(
//   //         icon: Icon(Icons.add),
//   //         onPressed: () {
//   //           if (quantity < int.parse(productData['maxQuantity'])) {
//   //             setState(() {
//   //               quantity++;
//   //             });
//   //           }
//   //         },
//   //       ),
//   //     ],
//   //   );
//   // }

//   // List<Widget> buildAdditionalInformation() {
//   //   return productData['additionalInformation'].map<Widget>((info) {
//   //     return Padding(
//   //       padding: const EdgeInsets.only(bottom: 8.0),
//   //       child: Row(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Text('${info['title']}: ',
//   //               style: TextStyle(fontWeight: FontWeight.bold)),
//   //           Expanded(child: Text(info['value'])),
//   //         ],
//   //       ),
//   //     );
//   //   }).toList();
//   // }
// }


// const String staticResponse = '''
// {
//   "status": true,
//  "productList": [
//         {
//             "id": 23,
//             "clientDetails": {
//                 "id": 1,
//                 "clientName": "Jayesh Bhai",
//                 "companyName": "Variety Shop",
//                 "gstNo": "22AAAAA0000A1Z5",
//                 "address": "The Variety Shop, Near Amit Nagar Char Rasta, Vadodara."
//             },
//             "mainCategoryDetails": {
//                 "id": 6,
//                 "mainCategoryName": "Sports"
//             },
//             "categoryDetails": {
//                 "id": 10,
//                 "categoryName": "Indoor Games"
//             },
//             "subCategoryDetails": {
//                 "id": 9,
//                 "subCategoryName": "Play Cards"
//             },
//             "productName": "Mattel Uno Playing Card Game",
//             "saleStartsAt": "149",
//             "minSalePrice": "143",
//             "stockStatus": "InStock",
//             "isQualityRuleApply": "true",
//             "minQuantity": "10",
//             "maxQuantity": "50",
//             "outofstockSelling": "true",
//             "productStock": null,
//             "sku": "uno_abcd",
//             "gst": null,
//             "isProductHasDiscount": false,
//             "isFeaturedProduct": "true",
//             "isTopSellingProduct": null,
//             "productStatus": "Active",
//             "publishStatus": "Published",
//             "activationDate": null,
//             "publishTime": null,
//             "isDiscountApplicable": null,
//             "discountedPercentage": null,
//             "related_products": [],
//             "attributes": [
//                 {
//                     "id": 123,
//                     "name": "Size",
//                     "value": "Small"
//                 },
//                 {
//                     "id": 124,
//                     "name": "Size",
//                     "value": "Free Size (Pack of 2)"
//                 },
//                 {
//                     "id": 125,
//                     "name": "Size",
//                     "value": "Pack of 2"
//                 },
//                 {
//                     "id": 126,
//                     "name": "Style Name",
//                     "value": "Uno Flip Side"
//                 },
//                 {
//                     "id": 127,
//                     "name": "Style Name",
//                     "value": "Phase 10"
//                 },
//                 {
//                     "id": 128,
//                     "name": "Pattern Name",
//                     "value": "Uno Card Game"
//                 },
//                 {
//                     "id": 129,
//                     "name": "Pattern Name",
//                     "value": "Skip_Bo+Uno+Uno+Phase 10"
//                 },
//                 {
//                     "id": 130,
//                     "name": "Pattern Name",
//                     "value": "Skip_Bo+Uno+Uno flip side"
//                 },
//                 {
//                     "id": 131,
//                     "name": "Pattern Name",
//                     "value": "Phase 10+Skip_Bo+Uno"
//                 },
//                 {
//                     "id": 132,
//                     "name": "Pattern Name",
//                     "value": " Card Game"
//                 },
//                 {
//                     "id": 133,
//                     "name": "Pattern Name",
//                     "value": "Uno"
//                 }
//             ],
//             "variants": [
//                 {
//                     "id": 107,
//                     "attributeDetails": {
//                         "id": 123,
//                         "name": "Size",
//                         "value": "Small"
//                     },
//                     "variantkey": "Uno Flip Side-Uno Card Game",
//                     "price": "143",
//                     "stock": "559",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_71y7%2BObyWGL._SL1500__bXJPxZ6.jpg', 'http://localhost:8000/media/media/processed_7113Y3xuZrL._SL1500__bn4gFcc.jpg', 'http://localhost:8000/media/media/processed_uno_1_EEyIiNk.jpg']"
//                 },
//                 {
//                     "id": 108,
//                     "attributeDetails": {
//                         "id": 123,
//                         "name": "Size",
//                         "value": "Small"
//                     },
//                     "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno+Phase 10",
//                     "price": "799",
//                     "stock": "850",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_619Wnw6AwAL._SL1001__qVn0K0w.jpg', 'http://localhost:8000/media/media/processed_71U3LyGQmlL._SL1426__eZobrBR.jpg', 'http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__Yru7EI0.jpg']"
//                 },
//                 {
//                     "id": 109,
//                     "attributeDetails": {
//                         "id": 123,
//                         "name": "Size",
//                         "value": "Small"
//                     },
//                     "variantkey": "Uno Flip Side-Skip_Bo+Uno+Uno flip side",
//                     "price": "560",
//                     "stock": "300",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__kalzGiZ.jpg', 'http://localhost:8000/media/media/processed_71QTKGzApAL._SL1500__gGkCHfN.jpg', 'http://localhost:8000/media/media/processed_71y7%2BObyWGL._SL1500__LlA73bT.jpg']"
//                 },
//                 {
//                     "id": 110,
//                     "attributeDetails": {
//                         "id": 123,
//                         "name": "Size",
//                         "value": "Small"
//                     },
//                     "variantkey": "Uno Flip Side-Phase 10+Skip_Bo+Uno",
//                     "price": "656",
//                     "stock": "450",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_51O9msiX9vL_3xEFhOe.jpg', 'http://localhost:8000/media/media/processed_71QTKGzApAL._SL1500__FzgJPgK.jpg', 'http://localhost:8000/media/media/processed_71uD7YfK4gL._SL1500__yGf02NW.jpg']"
//                 },
//                 {
//                     "id": 111,
//                     "attributeDetails": {
//                         "id": 124,
//                         "name": "Size",
//                         "value": "Free Size (Pack of 2)"
//                     },
//                     "variantkey": "Phase 10- Card Game",
//                     "price": "478",
//                     "stock": "890",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_51O9msiX9vL_kDZMPU0.jpg', 'http://localhost:8000/media/media/processed_61futYne4IL._SL1000_.jpg', 'http://localhost:8000/media/media/processed_61dofBpq8sL._SL1000__YaIretg.jpg']"
//                 },
//                 {
//                     "id": 112,
//                     "attributeDetails": {
//                         "id": 125,
//                         "name": "Size",
//                         "value": "Pack of 2"
//                     },
//                     "variantkey": "Uno Flip Side-Uno",
//                     "price": "398",
//                     "stock": "450",
//                     "variantImage": "http://localhost:8000/media/media/processed_uno_1_QrscVfL.jpg",
//                     "variantImageGallery": "['http://localhost:8000/media/media/processed_619Wnw6AwAL._SL1001__wVr5rzb.jpg', 'http://localhost:8000/media/media/processed_71545BzO4%2BL._SL1500__3kCX729.jpg', 'http://localhost:8000/media/media/processed_71aF0Ujft1L._SL1500__VN3DtL7.jpg']"
//                 }
//             ],
//             "technicalDetails": [],
//             "additionalInformation": [
//                 {
//                     "id": 81,
//                     "productDetails": {
//                         "id": 23,
//                         "productName": "Mattel Uno Playing Card Game",
//                         "productPrice": "149",
//                         "productStock": null,
//                         "sku": "uno_abcd",
//                         "gst": null
//                     },
//                     "title": "Product Dimensions",
//                     "value": "‎2.03 x 9.14 x 14.48 cm; 45.36 g"
//                 },
//                 {
//                     "id": 82,
//                     "productDetails": {
//                         "id": 23,
//                         "productName": "Mattel Uno Playing Card Game",
//                         "productPrice": "149",
//                         "productStock": null,
//                         "sku": "uno_abcd",
//                         "gst": null
//                     },
//                     "title": "Manufacturer recommended age",
//                     "value": "‎7 years and up"
//                 },
//                 {
//                     "id": 83,
//                     "productDetails": {
//                         "id": 23,
//                         "productName": "Mattel Uno Playing Card Game",
//                         "productPrice": "149",
//                         "productStock": null,
//                         "sku": "uno_abcd",
//                         "gst": null
//                     },
//                     "title": "Manufacturer",
//                     "value": "Parksons Cartamundi Pvt Ltd."
//                 },
//                 {
//                     "id": 84,
//                     "productDetails": {
//                         "id": 23,
//                         "productName": "Mattel Uno Playing Card Game",
//                         "productPrice": "149",
//                         "productStock": null,
//                         "sku": "uno_abcd",
//                         "gst": null
//                     },
//                     "title": "Item Weight",
//                     "value": "45.3 g"
//                 }
//             ],
//             "userRatingsDetails": [
//                 {
//                     "id": 23,
//                     "customerDetails": {
//                         "id": 3,
//                         "customerName": "Ketan Shah",
//                         "customerEmail": "hauwaddareifrei-6125@yopmail.com",
//                         "profileImage": "No"
//                     },
//                     "starRating": "1",
//                     "reviewComment": "very bad",
//                     "ratingDate": "2024-06-24"
//                 }
//             ],
//             "averageRatingsDetails": [
//                 {
//                     "id": 18,
//                     "totalRatings": "1",
//                     "totalRatingValue": "5",
//                     "averageRating": "1",
//                     "fiveStarRating": null,
//                     "fourStarRating": null,
//                     "threeStarRating": null,
//                     "twoStarRating": null,
//                     "oneStarRating": "1"
//                 }
//             ],
//             "created_at": "2024-06-18T06:06:58.115Z",
//             "updated_at": "2024-07-19T10:19:31.399Z",
//             "created_by": "Jayesh Bhai",
//             "updated_by": "Jayesh Bhai"
//         }
//     ]
// }
// ''';
