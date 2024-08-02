import 'dart:convert';

import 'package:ecommerce/Data/Response/status.dart';
import 'package:ecommerce/Utils/Widgets/errorScreen_widget.dart';
import 'package:ecommerce/Utils/utils.dart';
import 'package:ecommerce/View_Model/Profile_View_Model/RefundPolicy_View_Model/refundPolicy_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class RefundPolicyScreen extends StatefulWidget {
  const RefundPolicyScreen({super.key});

  @override
  State<RefundPolicyScreen> createState() => _RefundPolicyScreenState();
}

class _RefundPolicyScreenState extends State<RefundPolicyScreen> {
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
    final refundPolicyViewmodel =
        Provider.of<RefundPolicyViewmodel>(context, listen: false);
    refundPolicyViewmodel.fetchRefundPolicyApi(
        clientId.toString(), ipAddress.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred: ${snapshot.error}'));
          } else {
            return Consumer<RefundPolicyViewmodel>(
              builder: (context, value, _) {
                switch (value.refundPolicy.status!) {
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
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black),
      ),
      title: Text('Refund Policy', style: TextStyle(color: Colors.black)),
      actions: [
        IconButton(
            icon: Icon(Icons.search, color: Colors.black), onPressed: () {}),
        IconButton(
            icon: Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {}),
        IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: Colors.black),
            onPressed: () {}),
      ],
    );
  }

  Widget handleError(RefundPolicyViewmodel value) {
    String? message;
    if (value.refundPolicy.message != "No Internet Connection") {
      String jsonString = value.refundPolicy.message.toString();
      int startIndex = jsonString.indexOf('{');
      int endIndex = jsonString.lastIndexOf('}');
      String jsonSubstring = jsonString.substring(startIndex, endIndex + 1);
      Map<String, dynamic> jsonResponse = json.decode(jsonSubstring);
      message = jsonResponse['message'];
    }
    return value.refundPolicy.message == "No Internet Connection"
        ? ErrorScreenWidget(
            onRefresh: () async {},
            loadingText: value.refundPolicy.message.toString(),
          )
        : Text('data');
  }

  Widget _buildCompletedUI(
    BuildContext context,
    RefundPolicyViewmodel termsAndConditionsViewmodel,
  ) {
    List<dynamic> content = json.decode(termsAndConditionsViewmodel
        .refundPolicy.data!.refundPolicyContentList![0].refundPolicyContent
        .toString());

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Html(
                    data: content[0],
                    style: {
                      'h3': Style(
                        fontWeight:
                            FontWeight.normal, // Remove bold style from h3 tag
                        fontStyle:
                            FontStyle.normal, // Remove italic style from h3 tag
                        textDecoration: TextDecoration
                            .none, // Remove underline style from h3 tag
                      ),
                      'b': Style(
                        fontWeight:
                            FontWeight.normal, // Remove bold style from b tag
                      ),
                      'u': Style(
                        textDecoration: TextDecoration
                            .none, // Remove underline style from u tag
                      ),
                      'p': Style(
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        margin: EdgeInsets.zero, // Remove margin from p tag

                        fontWeight:
                            FontWeight.normal, // Remove bold style from p tag
                        fontStyle:
                            FontStyle.normal, // Remove italic style from p tag
                        textDecoration: TextDecoration
                            .none, // Remove underline style from p tag
                      ),
                    },
                    customRender: {
                      'img': (RenderContext context, Widget child) {
                        if (context.tree.element!.attributes
                            .containsKey('src')) {
                          // Remove the substring limitation to include the entire image tag
                          return Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 15,
                              child: Image.asset('images/obj.png'));
                        }
                        return child;
                      },
                    },
                    onLinkTap: (url, _, __, ___) {
                      // Handle link tap here
                    },
                    onImageTap: (src, _, __, ___) {
                      // Handle image tap here
                    },
                    onImageError: (exception, stackTrace) {
                      // Handle image error here
                    },
                    // Add any additional properties or callbacks you require
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
