// import 'dart:convert';

// import 'package:ecommerce/Data/Response/status.dart';
// import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
// import 'package:ecommerce/View_Model/ProductDetailById_View_Model/productDetailById_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../Model/ProductDetailById_Model/productDetailById_model.dart';

// class ProductDetailScreen extends StatefulWidget {
//   const ProductDetailScreen({Key? key}) : super(key: key);
//   @override
//   _ProductDetailScreenState createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   late Future<void> fetchDataFuture;

//   String clientId = '15';
//   String ipAddress = '103.228.147.152'; // Replace with actual IP address
//   ProductList? productData;
//   Map<String, String> selectedAttributes = {};
//   List<Variants> variants = [];
//   List<Attributes> attributes = [];
//   List<String> attributeOrder = [];
//   int quantity = 10;
//   bool isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData();
//   }

//   void initializeData() {
//     if (productData == null || isInitialized) return;
//     variants = productData!.variants ?? [];
//     attributes = productData!.attributes ?? [];
//     initializeAttributes();
//     selectDefaultAttributes();
//     isInitialized = true;
//   }

//   void initializeAttributes() {
//     Set<String> uniqueAttributes = {};
//     for (var attribute in attributes) {
//       uniqueAttributes.add(attribute.name.toString());
//     }
//     attributeOrder = uniqueAttributes.toList();
//     for (var attr in attributeOrder) {
//       selectedAttributes[attr] = '';
//     }
//   }

//   void selectDefaultAttributes() {
//     for (String attr in attributeOrder) {
//       List<String> options = getAvailableOptions(attr);
//       for (String option in options) {
//         if (isOptionAvailable(attr, option)) {
//           selectedAttributes[attr] = option;
//           break;
//         }
//       }
//     }
//   }

//   List<String> getAvailableOptions(String attributeName) {
//     return attributes
//         .where((attr) => attr.name == attributeName)
//         .map((attr) => attr.value as String)
//         .toSet()
//         .toList();
//   }

//   bool isOptionAvailable(String attributeName, String option) {
//     int attrIndex = attributeOrder.indexOf(attributeName);

//     if (attrIndex == 0) return true;

//     for (int i = 0; i < attrIndex; i++) {
//       if (selectedAttributes[attributeOrder[i]]!.isEmpty) {
//         return false;
//       }
//     }

//     return variants.any((variant) {
//       if (variant.attributeDetails!.value !=
//           selectedAttributes[attributeOrder[0]]) {
//         return false;
//       }
//       List<String> variantKeyParts = variant.variantkey!.split('-');
//       for (int i = 1; i < attrIndex; i++) {
//         if (variantKeyParts[i - 1] != selectedAttributes[attributeOrder[i]]) {
//           return false;
//         }
//       }
//       return variantKeyParts[attrIndex - 1] == option;
//     });
//   }

//   void selectAttribute(String attributeName, String value) {
//     selectedAttributes[attributeName] = value;
//     int index = attributeOrder.indexOf(attributeName);
//     for (int i = index + 1; i < attributeOrder.length; i++) {
//       selectedAttributes[attributeOrder[i]] = '';
//     }
//     for (int i = index + 1; i < attributeOrder.length; i++) {
//       String attr = attributeOrder[i];
//       List<String> options = getAvailableOptions(attr);
//       for (String option in options) {
//         if (isOptionAvailable(attr, option)) {
//           selectedAttributes[attr] = option;
//           break;
//         }
//       }
//     }
//     setState(() {}); // Trigger a rebuild after updating the state
//   }

//   Variants? findSelectedVariant() {
//     if (selectedAttributes.values.any((value) => value.isEmpty)) {
//       return null;
//     }

//     return variants.firstWhere(
//       (variant) {
//         String? variantSize = variant.attributeDetails!.value;
//         List<String> variantKeyParts = variant.variantkey!.split('-');
//         return variantSize == selectedAttributes[attributeOrder[0]] &&
//             attributeOrder.skip(1).every((attr) =>
//                 selectedAttributes[attr] ==
//                 variantKeyParts[attributeOrder.indexOf(attr) - 1]);
//       },
//     );
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     Map<String, String> data = {'productId': '58'};
//     final productDetailByIdViewmodel =
//         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);
//     await productDetailByIdViewmodel.fetchProductDetailByIdApi(
//         clientId.toString(), ipAddress.toString(), data);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productDetailByIdViewmodel =
//         Provider.of<ProductDetailByIdViewmodel>(context, listen: false);

//     return Scaffold(
//       appBar: AppBar(title: Text('Product Details')),
//       body: FutureBuilder<void>(
//         future: fetchDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error occurred: ${snapshot.error}'));
//           } else {
//             return ChangeNotifierProvider<ProductDetailByIdViewmodel>.value(
//               value: productDetailByIdViewmodel,
//               child: Consumer<ProductDetailByIdViewmodel>(
//                 builder: (context, value, _) {
//                   switch (value.productDetailById.status!) {
//                     case Status.LOADING:
//                       return Center(child: CircularProgressIndicator());
//                     case Status.ERROR:
//                       return handleError(value);
//                     case Status.COMPLETED:
//                       if (!isInitialized) {
//                         productData =
//                             value.productDetailById.data!.productList![0];
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           initializeData();
//                           setState(() {});
//                         });
//                       }
//                       return _buildCompletedUI(context);
//                   }
//                 },
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildCompletedUI(BuildContext context) {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Description:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             ...buildAttributeSelectors(),
//             SizedBox(height: 16),
//             if (findSelectedVariant() != null) ...[
//               Text('Selected Variant:'),
//               Text('Price: ${findSelectedVariant()!.price}'),
//               Text('Stock: ${findSelectedVariant()!.stock}'),
//             ],
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
//         : Text('Error: $message');
//   }
// }
//-----------------------------------------------------------------------------------------------------------------------------------------------------------

// import 'dart:async';
// import 'dart:convert';

// import 'package:ecommerce/Model/ProductDetailById_Model/productDetailById_model.dart';
// import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
// import 'package:ecommerce/View_Model/ProductDetailById_View_Model/productDetailById_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// import '../../../Data/Response/status.dart';
// import '../../../Utils/utils.dart';

// class ProductDetailScreen extends StatefulWidget {
//   final String productId;
//   const ProductDetailScreen({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);

//   @override
//   State<ProductDetailScreen> createState() => _ProductDetailScreenState();
// }

// class _ProductDetailScreenState extends State<ProductDetailScreen> {
//   String? _selectedColor;
//   String? _selectedSize;
//   late Future<void> fetchDataFuture;

//   String clientId = ClientId;
//   String ipAddress = IpAddress;

//   @override
//   void initState() {
//     super.initState();
//     fetchDataFuture = fetchData();
//   }

//   Future<void> fetchData() async {
//     await Future.delayed(Duration(microseconds: 20));
//     Map<String, String> data = {'productId': widget.productId.toString()};
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
//       appBar: _buildAppBar(),
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

//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.white,
//       centerTitle: true,
//       leading: InkWell(
//         onTap: () => Navigator.pop(context),
//         child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
//       ),
//       title: Text('Short dress', style: TextStyle(color: Colors.black)),
//       actions: [
//         IconButton(
//             icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
//         IconButton(
//             icon: Icon(Icons.favorite_border, color: Colors.black),
//             onPressed: () {}),
//         IconButton(
//             icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
//             onPressed: () {}),
//       ],
//     );
//   }

//   Widget _buildCompletedUI(
//       BuildContext context,
//       ProductDetailByIdViewmodel productDetailByIdViewmodel,
//       String? selectedColor,
//       String? selectedSize) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           // _buildProductImages(context, productDetailByIdViewmodel),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildSizeSelection(context, productDetailByIdViewmodel),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductImages(BuildContext context,
//       ProductDetailByIdViewmodel productDetailByIdViewmodel) {
//     return SmallImageCard(
//       productList:
//           productDetailByIdViewmodel.productDetailById.data!.productList![0],
//     );
//   }

//   Widget _buildSizeSelection(BuildContext context,
//       ProductDetailByIdViewmodel productDetailByIdViewmodel) {
//     return SizeDetailsCard(
//       productList:
//           productDetailByIdViewmodel.productDetailById.data!.productList![0],
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
// }

// class SmallImageCard extends StatefulWidget {
//   final ProductList productList;

//   SmallImageCard({required this.productList});

//   @override
//   State<SmallImageCard> createState() => _SmallImageCardState();
// }

// class _SmallImageCardState extends State<SmallImageCard> {
//   ProductList? productData;
//   late List<String> _productImages;

//   @override
//   void initState() {
//     super.initState();
//     productData = widget.productList;
//     _initializeProductImages();
//   }

//   void _initializeProductImages() {
//     List<dynamic> decodedList =
//         jsonDecode(productData!.productGallery.toString());
//     _productImages = decodedList.cast<String>();
//   }

//   String convertLocalhost(String url) {
//     return url.replaceAll('http://localhost', 'http://10.0.2.2');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 50.h,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: _productImages.length,
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Image.network(
//               convertLocalhost(_productImages[index]),
//               fit: BoxFit.cover,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class SizeDetailsCard extends StatefulWidget {
//   final ProductList productList;
//   // final String productShortDescription;

//   SizeDetailsCard({
//     required this.productList,
//     // required this.productShortDescription,
//   });

//   @override
//   _SizeDetailsCardState createState() => _SizeDetailsCardState();
// }

// class _SizeDetailsCardState extends State<SizeDetailsCard> {
//   ProductList? productData;
//   Map<String, String> selectedAttributes = {};
//   List<Variants> variants = [];
//   List<Attributes> attributes = [];
//   List<String> attributeOrder = [];
//   int quantity = 10;
//   late List<String> _productImages;

//   @override
//   void initState() {
//     super.initState();
//     productData = widget.productList;
//     variants = widget.productList.variants!;
//     attributes = widget.productList.attributes!;
//     initializeAttributes();
//     selectDefaultAttributes();
//     _updateProductImages();
//   }

//   void initializeAttributes() {
//     Set<String> uniqueAttributes = {};
//     for (var attribute in attributes) {
//       uniqueAttributes.add(attribute.name.toString());
//     }
//     attributeOrder = uniqueAttributes.toList();
//     for (var attr in attributeOrder) {
//       selectedAttributes[attr] = '';
//     }
//   }

//   void _updateProductImages() {
//     Variants? selectedVariant = findSelectedVariant();
//     if (selectedVariant != null &&
//         selectedVariant.variantImageGallery != null) {
//       _productImages =
//           _parseImageList(selectedVariant.variantImageGallery.toString());
//     } else {
//       _productImages = _parseImageList(productData!.productGallery.toString());
//     }
//     setState(() {});
//   }

//   void _initializeProductImages() {
//     _productImages =
//         _parseImageList(findSelectedVariant()!.variantImageGallery.toString());

//     print(
//         '_productImages_productImages_productImages_productImages_productImages_productImages');
//     print(_productImages);
//   }

//   List<String> _parseImageList(String imageListString) {
//     // Use a regular expression to match all URLs in the string
//     RegExp urlRegex = RegExp(r"'(http[^']+)'");
//     Iterable<Match> matches = urlRegex.allMatches(imageListString);

//     // Extract the URLs from the matches
//     List<String> imageUrls = matches.map((match) => match.group(1)!).toList();

//     return imageUrls;
//   }

//   String convertLocalhost(String url) {
//     return url.replaceAll('http://localhost', 'http://10.0.2.2');
//   }

//   void selectDefaultAttributes() {
//     for (String attr in attributeOrder) {
//       List<String> options = getAvailableOptions(attr);
//       for (String option in options) {
//         if (isOptionAvailable(attr, option)) {
//           selectAttribute(attr, option);
//           break;
//         }
//       }
//     }
//   }

//   List<String> getAvailableOptions(String attributeName) {
//     return attributes
//         .where((attr) => attr.name == attributeName)
//         .map((attr) => attr.value as String)
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
//       if (variant.attributeDetails?.value !=
//           selectedAttributes[attributeOrder[0]]) {
//         return false;
//       }
//       List<String> variantKeyParts = variant.variantkey!.split('-');
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
//       // Reselect default options for reset attributes
//       for (int i = index + 1; i < attributeOrder.length; i++) {
//         String attr = attributeOrder[i];
//         List<String> options = getAvailableOptions(attr);
//         for (String option in options) {
//           if (isOptionAvailable(attr, option)) {
//             selectedAttributes[attr] = option;
//             break;
//           }
//         }
//       }
//       // Update product images after changing attributes
//       _updateProductImages();
//     });
//   }

//   Variants? findSelectedVariant() {
//     if (selectedAttributes.values.any((value) => value.isEmpty)) {
//       return null;
//     }

//     return variants.firstWhere(
//       (variant) {
//         String? variantSize = variant.attributeDetails!.value;
//         List<String> variantKeyParts = variant.variantkey!.split('-');
//         // _initializeProductImages();

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
//     return Card(
//       child: Container(
//         width: 100.w,
//         color: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 50.h,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _productImages.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Image.network(
//                         convertLocalhost(_productImages[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               SizedBox(height: 16),
//               ...buildAttributeSelectors(),
//               SizedBox(height: 16),
//               // Display selected variant info
//               if (findSelectedVariant() != null) ...[
//                 Text('Selected Variant:'),
//                 Text('Price: ${findSelectedVariant()!.price}'),
//                 Text('Stock: ${findSelectedVariant()!.stock}'),
//                 Text('Image: ${findSelectedVariant()!.variantImageGallery}'),
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

//----------------------------------------------------------------------------------

import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Model/ProductDetailById_Model/productDetailById_model.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/View_Model/ProductDetailById_View_Model/productDetailById_view_model.dart';
import 'package:flutter/material.dart';
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
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
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
                _buildSizeSelection(context, productDetailByIdViewmodel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImages(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return SmallImageCard(
      productList:
          productDetailByIdViewmodel.productDetailById.data!.productList![0],
    );
  }

  Widget _buildSizeSelection(BuildContext context,
      ProductDetailByIdViewmodel productDetailByIdViewmodel) {
    return SizeDetailsCard(
      productList:
          productDetailByIdViewmodel.productDetailById.data!.productList![0],
    );
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
}

class SmallImageCard extends StatefulWidget {
  final ProductList productList;

  SmallImageCard({required this.productList});

  @override
  State<SmallImageCard> createState() => _SmallImageCardState();
}

class _SmallImageCardState extends State<SmallImageCard> {
  ProductList? productData;
  late List<String> _productImages;

  @override
  void initState() {
    super.initState();
    productData = widget.productList;
    _initializeProductImages();
  }

  void _initializeProductImages() {
    List<dynamic> decodedList =
        jsonDecode(productData!.productGallery.toString());
    _productImages = decodedList.cast<String>();
  }

  String convertLocalhost(String url) {
    return url.replaceAll('http://localhost:8000', ngrokUrl);
  }

  @override
  Widget build(BuildContext context) {
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
  int quantity = 10;
  late List<String> _productImages;

  @override
  void initState() {
    super.initState();
    productData = widget.productList;
    variants = widget.productList.variants!;
    attributes = widget.productList.attributes!;
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

  void _initializeProductImages() {
    _productImages =
        _parseImageList(findSelectedVariant()!.variantImageGallery.toString());

    print(
        '_productImages_productImages_productImages_productImages_productImages_productImages');
    print(_productImages);
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
    return url.replaceAll('http://localhost:8000', ngrokUrl);
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
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 16),
              ...buildAttributeSelectors(),
              SizedBox(height: 16),
              // Display selected variant info
              if (findSelectedVariant() != null) ...[
                Text('Selected Variant:'),
                Text('Price: ${findSelectedVariant()!.price}'),
                Text('Stock: ${findSelectedVariant()!.stock}'),
                Text('Image: ${findSelectedVariant()!.variantImageGallery}'),
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
