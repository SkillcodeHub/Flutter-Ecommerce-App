import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Routes/routes_name.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/addressScreen/addAddressScreen.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerAddresses_View_Model/customerAddress_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesScreen extends StatefulWidget {
  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  // Sample data for addresses
  String clientId = ClientId;
  String ipAddress = IpAddress;

  late Future<void> fetchDataFuture;

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

  Future<void> fetchData() async {
    await Future.delayed(Duration(microseconds: 20));
    Map<String, String> data = {'customerId': CustomerId};

    final refundPolicyViewmodel =
        Provider.of<CustomerAddressesViewmodel>(context, listen: false);
    refundPolicyViewmodel.fetchCustomerAddressesListApi(
        clientId.toString(), ipAddress.toString(), data);
  }

  @override
  Widget build(BuildContext context) {
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
            return Consumer<CustomerAddressesViewmodel>(
              builder: (context, value, _) {
                switch (value.customerAddressesList.status!) {
                  case Status.LOADING:
                    return Center(child: CircularProgressIndicator());
                  case Status.ERROR:
                    return handleError(value);
                  case Status.COMPLETED:
                    return _buildCompletedUI(context, value);
                }
              },
            );
          }
        },
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Addresses',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //       SizedBox(height: 16),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: addresses.length,
      //           itemBuilder: (context, index) {
      //             return Padding(
      //               padding: const EdgeInsets.only(bottom: 16.0),
      //               child: _buildAddressCard(addresses[index]),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text('Addresses', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddAddressScreen()));
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ChangeNotifierProvider(
            //       create: (_) => AddCustomerAddressViewModel(),
            //       child: AddAddressScreen(),
            //     ),
            //   ),
            // );
          },
          child: Text('+ Add address', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget handleError(CustomerAddressesViewmodel value) {
    String? message;
    if (value.customerAddressesList.message != "No Internet Connection") {
      String jsonString = value.customerAddressesList.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.customerAddressesList.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.customerAddressesList.message.toString(),
          )
        : Text('data');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    CustomerAddressesViewmodel customerAddressesViewmodel,
  ) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   'Addresses',
          //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: customerAddressesViewmodel
                  .customerAddressesList.data!.addressList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildAddressCard(
                      context, index, customerAddressesViewmodel),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, int index,
      CustomerAddressesViewmodel customerAddressesViewmodel) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // if (address['isDefault'] == 'true')
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'DEFAULT',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              customerAddressesViewmodel.customerAddressesList.data!
                      .addressList![index].customerDetails?.customerName ??
                  '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              customerAddressesViewmodel.customerAddressesList.data!
                      .addressList![index].customerAddress ??
                  '',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 4),
            Text(
              'Phone : ${customerAddressesViewmodel.customerAddressesList.data!.addressList![index].customerDetails?.customerMobile ?? ''}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    // Delete functionality
                  },
                  child: Text('Delete', style: TextStyle(color: Colors.red)),
                ),
                TextButton(
                  onPressed: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => EditAddressScreen(
                    //             addressList: customerAddressesViewmodel
                    //                 .customerAddressesList
                    //                 .data!
                    //                 .addressList![index])));
                    Navigator.of(context).pushNamed(
                        RoutesName.editAddressScreen,
                        arguments: customerAddressesViewmodel
                            .customerAddressesList.data!.addressList![index]);
                  },
                  child: Text('Edit', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
