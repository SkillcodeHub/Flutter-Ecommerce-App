import 'package:ecommerce/View/Bag/BagScreen/filterScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
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

  List<Map<String, dynamic>> filteredProducts = [];
  String selectedPriceFilter = 'All';

  @override
  void initState() {
    super.initState();
    filteredProducts = products;
  }

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

  @override
  Widget build(BuildContext context) {
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
      body: Column(
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
                        MaterialPageRoute(builder: (context) => FilterScreen()),
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
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  product: filteredProducts[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Image.asset(
                  product['imageUrl'],
                  height: 190,
                  width: double.infinity,
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
                        // color: appSecondaryColor,
                        size: 2.h,
                      ),
                      onPressed: () {
                        // Handle favorite button press
                      },
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ),
                if (product['discountPercentage'] > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      color: Colors.red,
                      child: Text(
                        '${product['discountPercentage']}% OFF',
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
                    product['name'],
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
                        '${product['price'].toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      if (product['discountPercentage'] > 0)
                        Text(
                          ' (${product['discountPercentage']}% off)',
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
                        index < product['rating']
                            ? Icons.star
                            : Icons.star_border,
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
