import 'dart:async';
import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Bag/BagScreen/filterScreen.dart';
import 'package:ecommerce/View_Model/AllProductList_View_Model/allProductList_view_model.dart';
import 'package:ecommerce/View_Model/WishList_View_Model/addWishList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../Model/AllProductList_Model/allProductList_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Map<String, dynamic>> filteredProducts = [];
  late Future<void> fetchDataFuture;
  String clientId = ClientId;
  String ipAddress = IpAddress;

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

  List<String> categories = [
    'T-shirts',
    'Crop tops',
    'Blouses',
    'T-shirts',
    'Crop tops',
    'Blouses'
  ];
  List<Map<String, dynamic>> products = [
    {
      'name': 'T-Shirt SPANISH',
      'price': 9.0,
      'discountPercentage': 20,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.5,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 30,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 11.0,
      'discountPercentage': 10,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 27.0,
      'discountPercentage': 70,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 50.0,
      'discountPercentage': 60,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 70.0,
      'discountPercentage': 50,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 45.0,
      'discountPercentage': 80,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 55.0,
      'discountPercentage': 90,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 88.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
    {
      'name': 'Blouse',
      'price': 21.0,
      'discountPercentage': 0,
      'imageUrl': 'images/sale_photo_2.png',
      'rating': 4.0,
    },
  ];

  String selectedPriceFilter = 'All';

  void showPriceFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Sort by'),
                  trailing: Icon(Icons.arrow_drop_down),
                ),
                Divider(),
                ListTile(
                  title: Text('All'),
                  onTap: () {
                    setState(() {
                      selectedPriceFilter = 'All';
                      filteredProducts = products;
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Price: highest to low'),
                  onTap: () {
                    setState(() {
                      selectedPriceFilter = 'Price: highest to low';
                      filteredProducts = List.from(products)
                        ..sort((a, b) => b['price'].compareTo(a['price']));
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Price: lowest to high'),
                  onTap: () {
                    setState(() {
                      selectedPriceFilter = 'Price: lowest to high';
                      filteredProducts = List.from(products)
                        ..sort((a, b) => a['price'].compareTo(b['price']));
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> fetchData() async {
    Timer(Duration(microseconds: 20), () {
      final allProductListViewmodel =
          Provider.of<AllProductListViewmodel>(context, listen: false);
      allProductListViewmodel.fetchAllProductListApi(
          clientId.toString(), ipAddress.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final allProductListViewmodel =
        Provider.of<AllProductListViewmodel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child:
                Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black)),
        title: Text(
          'Women\'s tops',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<void>(
        future: fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return ChangeNotifierProvider<AllProductListViewmodel>.value(
              value: allProductListViewmodel,
              child: Consumer<AllProductListViewmodel>(
                builder: (context, value, _) {
                  switch (value.allProductList.status!) {
                    case Status.LOADING:
                      return Center(child: CircularProgressIndicator());
                    case Status.ERROR:
                      return handleError(value);
                    case Status.COMPLETED:
                      return buildCompletedUI(allProductListViewmodel, context);
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }

  Widget handleError(AllProductListViewmodel value) {
    String? message;
    if (value.allProductList.message != "No Internet Connection") {
      String jsonString = value.allProductList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.allProductList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.allProductList.message.toString(),
          )
        : Text('data');
  }

  Widget buildCompletedUI(
      AllProductListViewmodel allProductListViewmodel, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        // Implement refresh logic here
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Chip(
                      label: Text(categories[index]),
                    ),
                  );
                },
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilterScreen()),
                  );
                },
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FilterScreen()),
                        );
                      },
                    ),
                    Text(
                      "Filters",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 12, 0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.filter_list),
                      onPressed: () {
                        showPriceFilterBottomSheet(context);
                      },
                    ),
                    Text(
                      selectedPriceFilter,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ]),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                ),
                itemCount: allProductListViewmodel
                    .allProductList.data!.productList!.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: allProductListViewmodel
                        .allProductList.data!.productList![index],
                  );
                },
              ),
            ),
          ],
        ),
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
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => ProductDetailScreen()));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  convertLocalhost(imageUrls[0])
                  // 'http://10.0.2.2:8000/media/media/processed_71JAtYR3tLL._SY741_.jpg',
                  ,
                  // widget.imageUrl,
                  // height: 24.h,
                  fit: BoxFit.cover,
                  width: double.infinity,
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
                        // color: appSecondaryColor,
                        size: 2.h,
                      ),
                      onPressed: () {
                        setState(() {
                                           
                        });

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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 2.h,
                      ),
                      Text(
                        '${widget.product.saleStartsAt}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (widget.product.discountedPercentage.toInt() > 0)
                        Text(
                          ' (${widget.product.discountedPercentage}% off)',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
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
          ],
        ),
      ),
    );
  }
}
