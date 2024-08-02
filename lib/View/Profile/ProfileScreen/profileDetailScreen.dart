import 'package:ecommerce/Model/Profile_Repository/CustomerProfile_Model/customerDetailsById_model.dart';
import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/CustomerProfile_View_Model/editCustomerDetails_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  final CustomerList customerList;
  const UpdateProfileScreen({super.key, required this.customerList});

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String _selectedGender = 'Male';
  String clientId = ClientId;
  String ipAddress = IpAddress;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _altMobileController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.customerList.customerName.toString();
    _emailAddressController.text = widget.customerList.customerEmail.toString();
    _mobileController.text = widget.customerList.customerMobile.toString();
    _altMobileController.text =
        widget.customerList.customerAlterMobile.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailAddressController.dispose();
    _mobileController.dispose();
    _altMobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editCustomerAddressViewModel =
        Provider.of<EditCustomerDetailsViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Update Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Name*', _nameController),
            // SizedBox(height: 16),
            // _buildTextField('Last Name*', ''),
            // SizedBox(height: 16),
            // _buildTextField('Screen Name', 'parth'),
            SizedBox(height: 16),
            _buildTextField(
              'Email Address*', _emailAddressController,
              // trailing: Container(
              //     width: 15.w,
              //     child: Center(
              //         child: Text('Change',
              //             style: TextStyle(color: Colors.blue))))
            ),
            // SizedBox(height: 16),
            // _buildDateField('Date Of Birth', 'Select date of birth'),
            // SizedBox(height: 16),
            // Text('Gender',
            //     style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            // Row(
            //   children: [
            //     Radio(
            //       value: 'Male',
            //       groupValue: _selectedGender,
            //       onChanged: (value) {
            //         setState(() {
            //           _selectedGender = value.toString();
            //         });
            //       },
            //     ),
            //     Text('Male'),
            //     SizedBox(width: 16),
            //     Radio(
            //       value: 'Female',
            //       groupValue: _selectedGender,
            //       onChanged: (value) {
            //         setState(() {
            //           _selectedGender = value.toString();
            //         });
            //       },
            //     ),
            //     Text('Female'),
            //   ],
            // ),
            SizedBox(height: 16),
            _buildTextField(
              'Mobile (+91)*', _mobileController,
              // trailing: Container(
              //   width: 14.w,
              //   child: Center(
              //     child: Text(
              //       'Change',
              //       style: TextStyle(color: Colors.blue),
              //     ),
              //   ),
              // )
            ),
            SizedBox(height: 16),
            _buildTextField(
              'Telephone (+91)', _altMobileController,
              // trailing: Container(
              //   width: 14.w,
              //   child: Center(
              //     child: Text(
              //       'Change',
              //       style: TextStyle(color: Colors.blue),
              //     ),
              //   ),
              // )
            ),
            SizedBox(height: 32),
            Row(
              children: [
                // Expanded(
                //   child: ElevatedButton(
                //     child: Text('Reset'),
                //     onPressed: () {
                //       // Handle reset
                //     },
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.white,
                //       onPrimary: Colors.black,
                //       side: BorderSide(color: Colors.grey),
                //     ),
                //   ),
                // ),
                // SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text('Update'),
                    onPressed: () {
                      Map<String, String> data = {
                        'customerName': _nameController.text,
                        'customerMobile': _mobileController.text,
                        'customerAlterMobile': _altMobileController.text,
                        'id': widget.customerList.id.toString(),
                        'updated_by':
                            widget.customerList.customerName.toString(),
                      };

                      editCustomerAddressViewModel.editCustomerDetailsApi(
                          clientId, ipAddress, data, context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: appSecondaryColor,
                      onPrimary: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, color: Colors.grey[600])),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: Icon(Icons.arrow_drop_down),
            ),
            onTap: () {
              // Show date picker
            },
          ),
        ),
      ],
    );
  }
}
