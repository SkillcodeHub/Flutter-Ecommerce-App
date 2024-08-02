import 'package:ecommerce/Res/colors.dart';
import 'package:ecommerce/View/Auth/forgotPasswordPage.dart';
import 'package:ecommerce/View_Model/Auth_View_Model/Login_View_Model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'signUpPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Container(
                height: 85.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // InkWell(
                        //     onTap: () {
                        //       Navigator.pop(context);
                        //     },
                        //     child: Icon(Icons.arrow_back_ios_new)),
                        SizedBox(height: 16.0),
                        Text(
                          "Login",
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
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 20.0),
                            labelText: 'email',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              // fontSize: 3.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                            // floatingLabelBehavior:
                            //     FloatingLabelBehavior.always, // Added this line
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 20.0),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              // fontSize: 3.sp,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(1.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Forgot your password? '),
                              Icon(Icons.arrow_right_alt, color: buttonColor),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // Perform sign-up logic with _nameController.text, _emailController.text, and _passwordController.text
                                print('Email: ${_emailController.text}');
                                print('Password: ${_passwordController.text}');
                                final authViewModel =
                                    Provider.of<AuthViewModel>(context,
                                        listen: false);

                                // Map<String, String> data = {
                                //   'clientId': '1',
                                //   'customerName': 'Parth',
                                //   'customerEmail': 'patelparth1234@gmail.com',
                                //   'password': '1234567',
                                //   'created_by': '1',
                                // };
                                Map<String, String> data = {
                                  'username': _emailController.text,
                                  'password': _passwordController.text,
                                };

                                authViewModel.loginApi(data, context);
                              } else {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => MyNavigationBar(
                                //               indexNumber: 1,
                                //             )));
                              }
                            },
                            child: Text('LOGIN'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Container(
                          width: 100.w,
                          child: Text(
                            'Or sign up with social account',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 8.0),
                            // Replace with your Google and Facebook logo assets
                            Image.asset('images/Google.png', height: 9.h),
                            SizedBox(width: 16.0),
                            Image.asset('images/Facebook.png', height: 9.h),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text("Don't have an account? Register Now"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
