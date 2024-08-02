import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerAddresses_View_Model/addcustomerAddress_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  String _addressType = 'Home';
  bool _isDefaultAddress = false;
  String clientId = ClientId;
  String ipAddress = IpAddress;

  String customerName = 'Ketul Patel';
  String customerId = CustomerId;

  // Controllers for each text field
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _localityController = TextEditingController();
  final TextEditingController _flatNoController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _nameController.text = 'parth';
    // _phoneController.text = '6353335967';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _localityController.dispose();
    _flatNoController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Address', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          // TextButton(
          //   child: Text('Reset', style: TextStyle(color: Colors.blue)),
          //   onPressed: () {
          //     // Implement reset functionality
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Text('Contact Info',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 16),
              // _buildTextField('Name', _nameController),
              // _buildTextField('Phone Number (+91)', _phoneController),
              // SizedBox(height: 24),
              Text('Address Info',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildTextField('Flat no / Building Name', _flatNoController),
              // _buildTextField('Locality / Area / Street', _localityController),
              // _buildTextField('Landmark (optional)', _landmarkController),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField('Pincode', _pincodeController)),
                  SizedBox(width: 16),
                  Expanded(child: _buildTextField('City', _cityController)),
                ],
              ),
              _buildTextField('State', _stateController),
              _buildTextField('Country', _countryController),
              // SizedBox(height: 24),
              // Text('Type of Address',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 16),
              // Row(
              //   children: <Widget>[
              //     _buildAddressTypeRadio('Home'),
              //     _buildAddressTypeRadio('Office'),
              //     _buildAddressTypeRadio('Other'),
              //   ],
              // ),
              // Row(
              //   children: <Widget>[
              //     Checkbox(
              //       value: _isDefaultAddress,
              //       onChanged: (bool? value) {
              //         setState(() {
              //           _isDefaultAddress = value!;
              //         });
              //       },
              //     ),
              //     Text('Make default address'),
              //   ],
              // ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Save Address'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  primary: Colors.black,
                ),
                onPressed: () async {
                  // final addCustomerAddressViewModel =
                  //     Provider.of<AddCustomerAddressViewModel>(context,
                  //         listen: false);

                  print('Name: ${_nameController.text}');
                  print('Phone: ${_phoneController.text}');
                  print('Pincode: ${_pincodeController.text}');
                  print('City: ${_cityController.text}');
                  print('State: ${_stateController.text}');
                  print('Locality: ${_localityController.text}');
                  print('Flat No / Building Name: ${_flatNoController.text}');
                  print('Landmark: ${_landmarkController.text}');
                  print('Address Type: $_addressType');
                  print('Is Default Address: $_isDefaultAddress');

                  Map<String, String> data = {
                    'clientId': clientId,
                    'customerAddress': _flatNoController.text,
                    'customerCity': _flatNoController.text,
                    'customerState': _stateController.text,
                    'customerPincode': _pincodeController.text,
                    'customerCountry': _countryController.text,
                    'created_by': customerName,
                    'customerId': customerId,
                  };

                  final addCustomerAddressViewModel =
                      Provider.of<AddCustomerAddressViewModel>(context,
                          listen: false);

                  bool success = await addCustomerAddressViewModel
                      .addCustomerAddressApi(ipAddress, data, context);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Address added successfully')),
                      //                   Utils.flushBarErrorMessage(
                      // value['message'], Duration(seconds: 2), context);
                    );
                    Navigator.of(context).pop();
                  }

                  // addCustomerAddressViewModel.addCustomerAddressApi(
                  //     ipAddress, data, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildAddressTypeRadio(String type) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(type),
        value: type,
        groupValue: _addressType,
        onChanged: (String? value) {
          setState(() {
            _addressType = value!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  _saveAddress() {
    print('dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    final addCustomerAddressViewModel =
        Provider.of<AddCustomerAddressViewModel>(context, listen: false);

    print('Name: ${_nameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Pincode: ${_pincodeController.text}');
    print('City: ${_cityController.text}');
    print('State: ${_stateController.text}');
    print('Locality: ${_localityController.text}');
    print('Flat No / Building Name: ${_flatNoController.text}');
    print('Landmark: ${_landmarkController.text}');
    print('Address Type: $_addressType');
    print('Is Default Address: $_isDefaultAddress');

    Map<String, String> data = {
      'clientId': clientId,
      'customerAddress': _flatNoController.text,
      'customerCity': _flatNoController.text,
      'customerState': _stateController.text,
      'customerPincode': _pincodeController.text,
      'customerCountry': _countryController.text,
      'created_by': customerName,
      'customerId': customerId,
    };

    // addCustomerAddressViewModel.addCustomerAddressApi(ipAddress, data, context);
  }
}
