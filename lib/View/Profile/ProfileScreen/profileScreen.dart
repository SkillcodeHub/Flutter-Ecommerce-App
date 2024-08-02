import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Routes/routes_name.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View/Auth/loginScreenPage.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/CustomerCareScreen/customerCareScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/PrivacyPolicyScreen/privacyPolicyScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/ReturnPolicyScreen/returnPolicyScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/TermsAndConditionsScreen/termsAndConditionsScreen.dart';
import 'package:ecommerce/View/Profile/ProfileScreen/addressScreen/profileAddressScreen.dart';
import 'package:ecommerce/View/SharePreferences/sharePreference.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerProfile_View_Model/customerdetailsById_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'OrderScreen/orders_screen.dart';
import 'RefundPolicyScreen/refundPolicyScreen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserPreferences userPreference = UserPreferences();
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

    final customerDetailsByIdViewmodel =
        Provider.of<CustomerDetailsByIdViewmodel>(context, listen: false);
    customerDetailsByIdViewmodel.fetchCustomerDetailsByIdApi(
        clientId.toString(), ipAddress.toString(), data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return Consumer<CustomerDetailsByIdViewmodel>(
              builder: (context, value, _) {
                switch (value.customerDetailsById.status!) {
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
      // SingleChildScrollView(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         padding: EdgeInsets.all(16),
      //         child: Row(
      //           children: [
      //             CircleAvatar(
      //               radius: 30,
      //               backgroundColor: Colors.black,
      //               child: Text(
      //                 'PA',
      //                 style: TextStyle(fontSize: 17.sp, color: Colors.white),
      //               ),
      //             ),
      //             SizedBox(width: 16),
      //             Expanded(
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'parth',
      //                     style: TextStyle(
      //                         fontSize: titleFontSize,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                   Text(
      //                     'patelparth2906@gmail.com',
      //                     style: TextStyle(
      //                       fontSize: descriptionFontSize,
      //                     ),
      //                   ),
      //                   Text(
      //                     '6353335967',
      //                     style: TextStyle(
      //                       fontSize: descriptionFontSize,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             TextButton(
      //               onPressed: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => UpdateProfileScreen()),
      //                 );
      //               },
      //               child: Text('Edit', style: TextStyle(color: Colors.blue)),
      //             ),
      //           ],
      //         ),
      //       ),
      //       // Divider(height: 1),
      //       Card(
      //         child: Column(
      //           children: [
      //             _buildListTile(
      //               'Orders',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => OrdersScreen()));
      //               },
      //             ),
      //             Divider(height: 1),
      //             _buildListTile('Customer Care', onTap: () {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                       builder: (context) => CustomerCareScreen()));
      //             }),
      //             Divider(height: 1),
      //             _buildListTile('Invite Friends & Earn',
      //                 subtitle: 'You get ₹100 for every friend'),
      //             Divider(height: 1),
      //           ],
      //         ),
      //       ),
      //       Card(
      //         child: Column(
      //           children: [
      //             _buildListTile(
      //               'AJIO Wallet',
      //               subtitle: 'Add Gift Card | Manage rewards and refunds',
      //             ),
      //             Divider(height: 1),
      //             _buildListTile('Saved Cards'),
      //             Divider(height: 1),
      //             _buildListTile('Coupon Quest'),
      //             Divider(height: 1),
      //             _buildListTile('My Rewards'),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Address',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => AddressesScreen()));
      //               },
      //             ),
      //             Divider(height: 1),
      //             _buildListTile('Notifications'),
      //             Divider(height: 1),
      //           ],
      //         ),
      //       ),
      //       Card(
      //         child: Column(
      //           children: [
      //             _buildListTile('Best Price Guarantee Campaign'),
      //             Divider(height: 1),
      //             _buildListTile('Return Creation Demo'),
      //             Divider(height: 1),
      //             _buildListTile('How TO Return'),
      //             Divider(height: 1),
      //             _buildListTile('How Do | Redeem My Coupon?'),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Terms & Conditions',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) =>
      //                             TermsAndConditionsScreen()));
      //               },
      //             ),
      //             _buildListTile('Promotions Terms & Conditions'),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Returns Policy',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ReturnPolicyScreen()));
      //               },
      //             ),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Refunds Policy',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => RefundPolicyScreen()));
      //               },
      //             ),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Privacy Policy',
      //               onTap: () {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => PrivacypolicyScreen()));
      //               },
      //             ),
      //             Divider(height: 1),
      //             _buildListTile('We Respect Your Privacy'),
      //             Divider(height: 1),
      //             _buildListTile('Fees & Payments'),
      //             Divider(height: 1),
      //             _buildListTile('Who We Are'),
      //             Divider(height: 1),
      //             _buildListTile('Join Our Team'),
      //             Divider(height: 1),
      //             _buildListTile(
      //               'Log Out',
      //               onTap: () {
      //                 userPreference.logoutProcess();
      //                 Navigator.pushAndRemoveUntil(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => LoginScreen(),
      //                   ),
      //                   (route) => false,
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget handleError(CustomerDetailsByIdViewmodel value) {
    String? message;
    if (value.customerDetailsById.message != "No Internet Connection") {
      String jsonString = value.customerDetailsById.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.customerDetailsById.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.customerDetailsById.message.toString(),
          )
        : Text('data');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    CustomerDetailsByIdViewmodel customerAddressesViewmodel,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black,
                  child: Text(
                    customerAddressesViewmodel
                        .customerDetailsById.data!.customerList![0].customerName
                        .toString()
                        .substring(0, 1),
                    style: TextStyle(fontSize: 17.sp, color: Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerAddressesViewmodel.customerDetailsById.data!
                            .customerList![0].customerName
                            .toString(),
                        style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        customerAddressesViewmodel.customerDetailsById.data!
                            .customerList![0].customerEmail
                            .toString(),
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                        ),
                      ),
                      Text(
                        customerAddressesViewmodel.customerDetailsById.data!
                            .customerList![0].customerMobile
                            .toString(),
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        RoutesName.editProfileDetailsScreen,
                        arguments: customerAddressesViewmodel
                            .customerDetailsById.data!.customerList![0]);
                  },
                  child: Text('Edit', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          // Divider(height: 1),
          Card(
            child: Column(
              children: [
                _buildListTile(
                  'Orders',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersScreen()));
                  },
                ),
                Divider(height: 1),
                _buildListTile('Customer Care', onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CustomerCareScreen()));
                }),
                Divider(height: 1),
                _buildListTile('Invite Friends & Earn',
                    subtitle: 'You get ₹100 for every friend'),
                Divider(height: 1),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                _buildListTile(
                  'AJIO Wallet',
                  subtitle: 'Add Gift Card | Manage rewards and refunds',
                ),
                Divider(height: 1),
                _buildListTile('Saved Cards'),
                Divider(height: 1),
                _buildListTile('Coupon Quest'),
                Divider(height: 1),
                _buildListTile('My Rewards'),
                Divider(height: 1),
                _buildListTile(
                  'Address',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressesScreen()));
                  },
                ),
                Divider(height: 1),
                _buildListTile('Notifications'),
                Divider(height: 1),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                _buildListTile('Best Price Guarantee Campaign'),
                Divider(height: 1),
                _buildListTile('Return Creation Demo'),
                Divider(height: 1),
                _buildListTile('How TO Return'),
                Divider(height: 1),
                _buildListTile('How Do | Redeem My Coupon?'),
                Divider(height: 1),
                _buildListTile(
                  'Terms & Conditions',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen()));
                  },
                ),
                _buildListTile('Promotions Terms & Conditions'),
                Divider(height: 1),
                _buildListTile(
                  'Returns Policy',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReturnPolicyScreen()));
                  },
                ),
                Divider(height: 1),
                _buildListTile(
                  'Refunds Policy',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RefundPolicyScreen()));
                  },
                ),
                Divider(height: 1),
                _buildListTile(
                  'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacypolicyScreen()));
                  },
                ),
                Divider(height: 1),
                _buildListTile('We Respect Your Privacy'),
                Divider(height: 1),
                _buildListTile('Fees & Payments'),
                Divider(height: 1),
                _buildListTile('Who We Are'),
                Divider(height: 1),
                _buildListTile('Join Our Team'),
                Divider(height: 1),
                _buildListTile(
                  'Log Out',
                  onTap: () {
                    userPreference.logoutProcess();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, {String? subtitle, VoidCallback? onTap}) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey))
          : null,
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey.shade700,
      ),
      onTap: onTap,
    );
  }
}
