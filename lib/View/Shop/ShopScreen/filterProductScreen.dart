import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Shop/ShopScreen/productDetailScreen.dart';
import 'package:ecommerce/View_Model/AllProductList_View_Model/filterProductList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Model/AllProductList_Model/allProductList_model.dart';

class FilterProductScreen extends StatefulWidget {
  const FilterProductScreen({super.key});

  @override
  State<FilterProductScreen> createState() => _FilterProductScreenState();
}

class _FilterProductScreenState extends State<FilterProductScreen> {
  List<Map<String, dynamic>> filteredProducts = [];
  late Future<void> fetchDataFuture;
  String clientId = ClientId;
  String ipAddress = IpAddress;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFuture = fetchData();
  }

  Future<void> fetchData({String? keyword}) async {
    Timer(Duration(microseconds: 20), () {
      final filterProductListViewmodel =
          Provider.of<FilterProductListViewmodel>(context, listen: false);
      Map<String, String> data = {
        'productName': keyword.toString(),
      };
      filterProductListViewmodel.fetchFilterProductListApi(
          clientId.toString(), ipAddress.toString(), data);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterProductListViewmodel =
        Provider.of<FilterProductListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Light blue background
        elevation: 0, // No shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: InkWell(
          onTap: () {},
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products',
                // prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      fetchDataFuture =
                          fetchData(keyword: _searchController.text);
                    });
                  },
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
            ),
          ),
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  // Handle cart button press
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: filterProductListViewmodel
                  .filterProductList.data?.productList?.length !=
              "0"
          ? FutureBuilder<void>(
              future: fetchDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Error occurred: ${snapshot.error}'));
                } else {
                  return ChangeNotifierProvider<
                      FilterProductListViewmodel>.value(
                    value: filterProductListViewmodel,
                    child: Consumer<FilterProductListViewmodel>(
                      builder: (context, value, _) {
                        switch (value.filterProductList.status!) {
                          case Status.LOADING:
                            return Center(child: CircularProgressIndicator());
                          case Status.ERROR:
                            return handleError(value);
                          case Status.COMPLETED:
                            return buildCompletedUI(
                                filterProductListViewmodel, context);
                        }
                      },
                    ),
                  );
                }
              },
            )
          : Container(),
    );
  }

  Widget handleError(FilterProductListViewmodel value) {
    String? message;
    if (value.filterProductList.message != "No Internet Connection") {
      String jsonString = value.filterProductList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.filterProductList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.filterProductList.message.toString(),
          )
        : Text('data');
  }

  Widget buildCompletedUI(FilterProductListViewmodel allProductListViewmodel,
      BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic here
      },
      child: Column(
        children: [
          Expanded(
            // Wrap GridView.builder with Expanded
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: allProductListViewmodel
                  .filterProductList.data!.productList!.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: allProductListViewmodel
                      .filterProductList.data!.productList![index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final ProductList product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<String> imageUrls = [];

  @override
  Widget build(BuildContext context) {
    imageUrls = List<String>.from(
        json.decode(widget.product.productGallery.toString()));

    String convertLocalhost(String url) {
      return url.replaceAll('http://localhost:8000', ngrokUrl);
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                    productId: widget.product.id.toString())));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    convertLocalhost(imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite_border,
                          size: 20,
                        ),
                        onPressed: () {
                          // Handle favorite button press
                        },
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                    ),
                  ),
                  if (widget.product.discountedPercentage.toInt() > 0)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.red,
                        child: Text(
                          '${widget.product.discountedPercentage}% OFF',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.productName.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee_sharp,
                          size: 16,
                        ),
                        Text(
                          '${widget.product.saleStartsAt}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        if (widget.product.discountedPercentage.toInt() > 0)
                          Expanded(
                            child: Text(
                              ' (${widget.product.discountedPercentage}% off)',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < 3 ? Icons.star : Icons.star_border,
                          size: 16,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
