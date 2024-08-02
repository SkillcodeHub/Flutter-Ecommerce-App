import 'package:ecommerce/Utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _currentRangeValues = RangeValues(0, 100);
  Color _selectedColor = Colors.black;
  String _selectedSize = 'S';
  String _selectedCategory = 'All';

  final List<Color> _colors = [
    Colors.black,
    Colors.green,
    Colors.grey,
    Colors.yellow,
    Colors.blue,
  ];

  final List<String> _sizes = ['XS', 'S', 'M', 'L', 'XL'];

  final List<String> _categories = ['All', 'Women', 'Men', 'Boys', 'Girls'];

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
          'Filters',
          style: TextStyle(
              color: Colors.black,
              fontSize: headerFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price range',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("    100"),
                        Text("1000     "),
                      ],
                    ),
                    RangeSlider(
                      activeColor: Colors.red,
                      inactiveColor: Colors.grey,
                      values: _currentRangeValues,
                      min: 0,
                      max: 100,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                          print(_currentRangeValues);
                        });
                      },
                    ),
                  ],
                )),
            SizedBox(height: 16.0),
            Text(
              'Colors',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              color: Colors.white,
              height: 10.h,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _colors.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = _colors[index];
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: ColorOption(
                          color: _colors[index],
                          isSelected: _selectedColor == _colors[index],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Sizes',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              color: Colors.white,
              height: 10.h,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizes.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSize = _sizes[index];
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          height: 2.h,
                          width: 12.w,
                          decoration: BoxDecoration(
                            color: _selectedSize == _sizes[index]
                                ? Colors.red
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          // padding: EdgeInsets.symmetric(
                          //   horizontal: 16.0,
                          //   vertical: 6.0,
                          // ),
                          child: Center(
                            child: Text(
                              _sizes[index],
                              style: TextStyle(
                                color: _selectedSize == _sizes[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Category',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              color: Colors.white,
              height: 10.h,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _categories.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = _categories[index];
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _selectedCategory == _categories[index]
                                ? Colors.red
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 8.0,
                          ),
                          child: Center(
                            child: Text(
                              _categories[index],
                              style: TextStyle(
                                color: _selectedCategory == _categories[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Discard filter changes
                    },
                    child: Text(
                      'Discard',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    onPressed: () {
                      // Apply filter changes
                    },
                    child: Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption extends StatelessWidget {
  final Color color;
  final bool isSelected;

  ColorOption({
    Key? key,
    required this.color,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                color: Colors.red,
                width: 3.0,
              )
            : null,
      ),
      // child: isSelected
      //     ? Center(
      //         child: Icon(
      //           Icons.check,
      //           color: Colors.white,
      //           size: 18.0,
      //         ),
      //       )
      //     : null,
    );
  }
}
