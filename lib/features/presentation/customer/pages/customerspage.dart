import 'package:bekkams_lending/features/presentation/customer/pages/custsearchpage.dart';
import 'package:flutter/material.dart';

class MyCustomersPage extends StatelessWidget {
  const MyCustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        centerTitle: true,
        title: const Text('Customers', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomerSearchPage()),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Customer list goes here',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
