import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/Routes/routes.dart';
import 'package:ecommerce/Utils/Routes/routes_name.dart';
import 'package:ecommerce/View_Model/AllProductList_View_Model/allProductList_view_model.dart';
import 'package:ecommerce/View_Model/AllProductList_View_Model/filterProductList_view_model.dart';
import 'package:ecommerce/View_Model/Auth_View_Model/Login_View_Model/login_view_model.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/addcart_view_model.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/cartList_view_model.dart';
import 'package:ecommerce/View_Model/CartList_View_Model/deleteCart_view_model.dart';
import 'package:ecommerce/View_Model/FeaturedProductList_View_Model/featuredProductList_view_model.dart';
import 'package:ecommerce/View_Model/ProductDetailById_View_Model/productDetailById_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerAddresses_View_Model/addcustomerAddress_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerAddresses_View_Model/editCustomerAddress_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerProfile_View_Model/customerdetailsById_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerProfile_View_Model/editCustomerDetails_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/orderList_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/orderdetailbyorderedproduct_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/OrderList_View_Model/productRatings_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/PrivacyPolicy_View_Model/privacyPolicy_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/RefundPolicy_View_Model/refundPolicy_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/ReturnPolicy_View_Model/returnPolicy_view_model.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/TermsAndConditions_View_Model/termsandconditions_view_model.dart';
import 'package:ecommerce/View_Model/WishList_View_Model/addWishList_view_model.dart';
import 'package:ecommerce/View_Model/WishList_View_Model/deleteWishList_view_model.dart';
import 'package:ecommerce/View_Model/WishList_View_Model/wishList_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'View_Model/Profile_View_Model/CustomerAddresses_View_Model/customerAddress_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => AddCustomerAddressViewModel()),
        ChangeNotifierProvider(create: (_) => EditCustomerAddressViewModel()),
        ChangeNotifierProvider(create: (_) => EditCustomerDetailsViewModel()),
        ChangeNotifierProvider(create: (_) => AddProductRatingsViewModel()),
        ChangeNotifierProvider(create: (_) => AddCartViewModel()),
        ChangeNotifierProvider(create: (_) => DeleteWishListViewModel()),
        ChangeNotifierProvider(create: (_) => AddWishListViewModel()),
                ChangeNotifierProvider(create: (_) => DeleteCartViewModel
()),

        // ChangeNotifierProvider(create: (_) => ProductAttributeProvider()),
        ChangeNotifierProvider<FeaturedProductListViewmodel>.value(
            value: FeaturedProductListViewmodel()),
        ChangeNotifierProvider<ProductDetailByIdViewmodel>.value(
            value: ProductDetailByIdViewmodel()),
        ChangeNotifierProvider<TermsAndConditionsViewmodel>.value(
            value: TermsAndConditionsViewmodel()),
        ChangeNotifierProvider<ReturnPolicyViewmodel>.value(
            value: ReturnPolicyViewmodel()),
        ChangeNotifierProvider<RefundPolicyViewmodel>.value(
            value: RefundPolicyViewmodel()),
        ChangeNotifierProvider<PrivacyPolicyViewmodel>.value(
            value: PrivacyPolicyViewmodel()),
        ChangeNotifierProvider<CustomerAddressesViewmodel>.value(
            value: CustomerAddressesViewmodel()),
        ChangeNotifierProvider<CustomerDetailsByIdViewmodel>.value(
            value: CustomerDetailsByIdViewmodel()),
        ChangeNotifierProvider<CartListViewmodel>.value(
            value: CartListViewmodel()),
        ChangeNotifierProvider<OrderListViewmodel>.value(
            value: OrderListViewmodel()),
        ChangeNotifierProvider<OrderdetailbyorderedproductViewmodel>.value(
            value: OrderdetailbyorderedproductViewmodel()),
        ChangeNotifierProvider<WishListViewmodel>.value(
            value: WishListViewmodel()),
        ChangeNotifierProvider<AllProductListViewmodel>.value(
            value: AllProductListViewmodel()),
        ChangeNotifierProvider<FilterProductListViewmodel>.value(
            value: FilterProductListViewmodel()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Commerce',
            theme: ThemeData(
              textTheme: GoogleFonts
                  .robotoCondensedTextTheme(), // Apply Roboto Condensed font to all text
              scaffoldBackgroundColor: appBackgroundColor,

              primarySwatch: Colors.blue,
            ),
            initialRoute: RoutesName.splash,
            onGenerateRoute: Routes.generateRoute,
          );
        },
      ),
    );
  }
}
