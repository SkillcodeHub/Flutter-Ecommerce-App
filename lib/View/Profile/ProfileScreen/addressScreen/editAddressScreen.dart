import 'package:ecommerce/Model/Profile_Repository/CustomerAddresses_Model/customerAddresses_model.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerAddresses_View_Model/editCustomerAddress_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditAddressScreen extends StatefulWidget {
  final AddressList addressList;
  const EditAddressScreen({super.key, required this.addressList});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String _addressType = 'Home';
  bool _isDefaultAddress = false;
  String clientId = ClientId;
  String ipAddress = IpAddress;

  String customerName = 'Ketul Patel';
  String customerId = CustomerId;

  // Controllers for each text field
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _flatNoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pincodeController.text = widget.addressList.customerPincode.toString();
    _cityController.text = widget.addressList.customerCity.toString();
    _stateController.text = widget.addressList.customerState.toString();
    _countryController.text = widget.addressList.customerCountry.toString();
    _flatNoController.text = widget.addressList.customerAddress.toString();
    ;
  }

  @override
  void dispose() {
    _pincodeController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _flatNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editCustomerAddressViewModel =
        Provider.of<EditCustomerAddressViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Address', style: TextStyle(color: Colors.black)),
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

                  print('Pincode: ${_pincodeController.text}');
                  print('City: ${_cityController.text}');
                  print('State: ${_stateController.text}');
                  print('Flat No / Building Name: ${_flatNoController.text}');
                  print('Address Type: $_addressType');
                  print('Is Default Address: $_isDefaultAddress');

                  Map<String, String> data = {
                    'clientId': clientId,
                    'customerAddress': _flatNoController.text,
                    'customerCity': _flatNoController.text,
                    'customerState': _stateController.text,
                    'customerPincode': _pincodeController.text,
                    'customerCountry': _countryController.text,
                    'updated_by': customerName,
                    'customerId': customerId,
                    'id': widget.addressList.id.toString(),
                  };

                  // bool success = await addCustomerAddressViewModel
                  //     .addCustomerAddressApi(ipAddress, data, context);

                  // if (success) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('Address added successfully')),
                  //     //                   Utils.flushBarErrorMessage(
                  //     // value['message'], Duration(seconds: 2), context);
                  //   );
                  //   Navigator.of(context).pop();
                  // }

                  editCustomerAddressViewModel.editCustomerAddressApi(
                      ipAddress, data, context);
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
    // final addCustomerAddressViewModel =
    //     Provider.of<AddCustomerAddressViewModel>(context, listen: false);

    print('Pincode: ${_pincodeController.text}');
    print('City: ${_cityController.text}');
    print('State: ${_stateController.text}');
    print('Flat No / Building Name: ${_flatNoController.text}');
    print('Address Type: $_addressType');
    print('Is Default Address: $_isDefaultAddress');

    Map<String, String> data = {
      'clientId': clientId,
      'id': clientId,
      'customerAddress': _flatNoController.text,
      'customerCity': _flatNoController.text,
      'customerState': _stateController.text,
      'customerPincode': _pincodeController.text,
      'customerCountry': _countryController.text,
      'updated_by ': customerName,
      'customerId': customerId,
    };

    // addCustomerAddressViewModel.addCustomerAddressApi(ipAddress, data, context);
  }
}
