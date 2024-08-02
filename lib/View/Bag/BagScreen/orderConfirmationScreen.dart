import 'package:ecommerce/View/Bag/BagScreen/addressScreen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            Text('Order Confirmation', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.grey[100],
              padding: EdgeInsets.all(16),
              child: Text(
                'Secure Payment | Genuine Products | Easy Returns',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            _buildDeliveryCard(context),
            _buildExpectedDelivery(),
            _buildAmountPayable(),

            Center(
              child: Container(
                width: 50.w,
                child: ElevatedButton(
                  child: Text(
                    'Pay',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    primary: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 45.0,
                      vertical: 12.0,
                    ),
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => OrderDetailsScreen()),
                    // );
                  },
                ),
              ),
            ),

            // _buildOffersAndPromotions(),
            // _buildRedemptionOptions(),
            // _buildPaymentMethods(),
          ],
        ),
      ),
    );
  }

  Widget _buildOffersAndPromotions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Offers & Promotions',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text('+13 more offers', style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        Card(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: ListTile(
            title: Text('Get 10% Instant Discount of up to Rs. 1000 on a...'),
            trailing:
                Image.asset('images/sale_photo_2.png', width: 40, height: 40),
          ),
        ),
      ],
    );
  }

  Widget _buildRedemptionOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Redemption Options',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          color: Colors.grey[200],
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('To use Redemption Options'),
              Text('Verify that it\'s you',
                  style: TextStyle(color: Colors.blue)),
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.radio_button_unchecked),
          title: Text('Loyalty Points'),
          subtitle: Text('You have no Loyalty Points at the moment'),
          trailing: Text('Details', style: TextStyle(color: Colors.blue)),
        ),
        ListTile(
          leading: Icon(Icons.card_giftcard),
          title: Text('Have a Gift Card?'),
          subtitle: Text('Add it to AJIO Wallet to pay for your orders'),
          trailing: Text('Add', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Column(
      children: [
        _buildPaymentMethod('UPI'),
        _buildPaymentMethod('Credit/Debit Card', isAddCard: true),
        _buildPaymentMethod('Net Banking'),
        _buildPaymentMethod('Wallet'),
        _buildPaymentMethod('Cash on Delivery'),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'For safe, contactless and hassle free delivery, pay using card/wallet/netbank...',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod(String title, {bool isAddCard = false}) {
    return ListTile(
      title: Text(title),
      trailing: isAddCard
          ? OutlinedButton(
              onPressed: () {},
              child: Text('+ Add Card'),
            )
          : Icon(Icons.add),
    );
  }
}

Widget _buildDeliveryCard(context) {
  return Card(
    margin: EdgeInsets.all(16),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Home Delivery',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressScreen()));
                  },
                  child: Text('Change address',
                      style: TextStyle(color: Colors.blue))),
            ],
          ),
          SizedBox(height: 8),
          Text('Parth Patel', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Gorwa Faliyu,Tarsali Gam, Tarsali Gam'),
          Text('Near Ranchhod Ji Mandir'),
          Text('Vadodara'),
          Text('Gujarat, India - 390009'),
          Text('Phone : 6353335967'),
        ],
      ),
    ),
  );
}

Widget _buildExpectedDelivery() {
  return Card(
    child: ExpansionTile(
      title: Text('Expected Delivery', style: TextStyle(color: Colors.black)),
      trailing: Container(
        width: 19.w,
        child: Row(
          children: [
            Text('02nd Jul', style: TextStyle(color: Colors.black)),
            Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
          ],
        ),
      ),
      children: [
        ListTile(
          leading: Image.asset('images/sale_photo_2.png'),
          title: Text('02 Jul', style: TextStyle(color: Colors.green)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Kvetoo', style: TextStyle(color: Colors.black)),
              Text('Ribbed High-Neck Pullover'),
              Text('Size L'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAmountPayable() {
  return Card(
    child: ExpansionTile(
      title: Text('Amount Payable', style: TextStyle(color: Colors.black)),
      trailing: Container(
          width: 19.w,
          child: Row(
            children: [
              Text('₹ 849.00', style: TextStyle(color: Colors.black)),
              Icon(Icons.arrow_drop_down_outlined, color: Colors.black),
            ],
          )),
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              _buildAmountRow('Bag Total', '₹ 2,499.00'),
              _buildAmountRow('Bag Discount', '- ₹ 1,749.00',
                  color: Colors.green),
              _buildAmountRow('Convenience Fee What\'s this?', ''),
              _buildAmountRow('Delivery Fee', '₹ 99.00'),
              SizedBox(height: 8),
              _buildAmountRow('You Pay', '₹ 849.00', isBold: true),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAmountRow(String label, String amount,
    {Color? color, bool isBold = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600])),
        Text(
          amount,
          style: TextStyle(
            color: color ?? Colors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    ),
  );
}
