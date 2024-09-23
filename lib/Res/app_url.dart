class AppUrl {
  //Base Url
  // http://localhost:6000/api/
  // static var baseUrl = "http://10.0.2.2:8000/";
  static var baseUrl =
      "https://c431-2402-a00-142-4b45-1426-43bc-ef2f-5a8d.ngrok-free.app/";

  // static var   = "https://www.axonweb.in/api/";
  // static var baseUrl = "http://18.188.250.51:7000/api/cms/";
  // static var baseUrl = "https://axon-pro-api.axonsoftwares.net/api/cms/";
  // static var baseUrl = "https://axon-pro-api.axonsoftwares.net/api/cms/";

  //Signup
  static var signupUrl = baseUrl + 'customerportal/customersignup';
  //login
  static var loginUrl = baseUrl + 'customerportal/customerlogin';
  //Featured Product List
  static var featuredProductListUrl =
      baseUrl + 'customerportal/featuredproducts';
  //product details by product
  static var productdetailsbyproductUrl =
      baseUrl + 'customerportal/productdetailsbyproduct';
  //product details by product
  static var termsAndConditionsUrl =
      baseUrl + 'customerportal/gettermsandconditions';
  //Return policy Url
  static var returnpolicyUrl = baseUrl + 'customerportal/getreturnpolicy';
  //Return policy Url
  static var refundPolicyUrl = baseUrl + 'customerportal/getrefundpolicy';
  //Privacy Policy Url
  static var privacyPolicyUrl = baseUrl + 'customerportal/getprivacypolicy';
  //addresses By Customer Url
  static var addressesByCustomerUrl =
      baseUrl + 'customerportal/addressesbycustomer';
  //add customer Address Url
  static var addcustomerAddressUrl =
      baseUrl + 'customerportal/addcustomeraddress';
  //edit customer Address Url
  static var editcustomerAddressUrl =
      baseUrl + 'customerportal/editcustomeraddress';

  //edit customer Address Url
  static var customerdetailsbycustomeridUrl =
      baseUrl + 'customerportal/customerdetailsbycustomerid';

  //edit customer Address Url
  static var editcustomerDetailsUrl =
      baseUrl + 'customerportal/editcustomerprofile';

  //cart List Url
  static var cartListUrl = baseUrl + 'customerportal/cartbycustomer';

  //Order By Customer Url
  static var orderbycustomerUrl = baseUrl + 'customerportal/orderbycustomer';

  // Order detail by ordered product Url
  static var orderdetailbyorderedproductUrl =
      baseUrl + 'customerportal/orderdetailbyorderedproduct';

  // Wishlist by customer Url
  static var wishlistbycustomerUrl =
      baseUrl + 'customerportal/wishlistbycustomer';

  // add user ratings Url
  static var adduserratingsUrl = baseUrl + 'customerportal/adduserratings';
  // add cart Url
  static var addCartUrl = baseUrl + 'customerportal/addcart';

  // delete cart Url
  static var deleteCartUrl = baseUrl + 'customerportal/deletecart';

  // delete cart Url
  static var editcartUrl = baseUrl + 'customerportal/editcart';

  // delete Wish List Url
  static var deleteWishListUrl = baseUrl + 'customerportal/deletewishlist';

  // add Wish List Url
  static var addWishListUrl = baseUrl + 'customerportal/addwishlist';

  // All Product List Url
  static var allProductListUrl = baseUrl + 'customerportal/allproductlist';
  // Filter Product List Url
  static var filterProductListUrl = baseUrl + 'customerportal/productbyname';

  // check offer coupon validity Url
  static var checkoffercouponvalidityUrl =
      baseUrl + 'customerportal/checkoffercouponvalidity';
}
