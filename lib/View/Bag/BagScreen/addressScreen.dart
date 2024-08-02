import 'package:ecommerce/View/Profile/ProfileScreen/addressScreen/addAddressScreen.dart';
import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('My Account', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            child: Text('+ Add address', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddAddressScreen()));
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.green,
                        child: Text('DEFAULT',
                            style: TextStyle(color: Colors.white)),
                      ),
                      Radio(
                        value: true,
                        groupValue: true,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('parth patel',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(
                      'Gorwa Faliyu,Tarsali Gam , Tarsali Gam , Near Ranchhod'),
                  Text('Ji Mandir , Vadodara , Gujarat,India - 390009'),
                  SizedBox(height: 4),
                  Text('Phone : +91 6353335967'),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddAddressScreen()));
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
