import 'package:flutter/material.dart';

class CustomerCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Customer Care'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need help with recent orders?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildOrderCard('SHIPPED')),
                  SizedBox(width: 16),
                  Expanded(child: _buildOrderCard('PARTIALLY REFU')),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'FAQ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              _buildSearchBar(),
              SizedBox(height: 16),
              _buildFAQList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(String status) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Date of order: 14th July, 2024'),
            Image.asset('images/sale_photo_2.png', height: 80),
            Text('Order ID: FN4705504360'),
            Text('1 item'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for topics or questions',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  Widget _buildFAQList() {
    final faqItems = [
      'Shipping FAQs',
      'Cancellation FAQs',
      'Payment FAQs',
      'Returns FAQs',
      'AJIO Wallet',
      'Account & Shopping',
      'Loyalty Rewards',
    ];

    return Column(
      children: faqItems.map((item) => _buildFAQItem(item)).toList(),
    );
  }

  Widget _buildFAQItem(String title) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle FAQ item tap
      },
    );
  }
}
