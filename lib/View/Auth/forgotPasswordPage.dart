import 'package:ecommerce/Res/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new)),
                SizedBox(height: 16.0),
                Text(
                  "Forgot password",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: titleFontColor),

                  // GoogleFonts.getFont(
                  //   'Roboto Condensed',
                  //   fontWeight: FontWeight.w700,
                  //   fontSize: 34,
                  //   color: Color(0xFF222222),
                  // ),
                ),
                SizedBox(height: 5.h),
                Text(
                  'Please, enter your email address. You will receive a link to create a new password via email',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'email',
                    suffixIcon: _emailController.text.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _emailController.clear();
                            },
                          )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    // Add email validation logic if needed
                    return null;
                  },
                ),
                SizedBox(height: 7.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Perform forgot password logic with _emailController.text
                        print('Email: ${_emailController.text}');
                      }
                    },
                    child: Text('SEND'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
