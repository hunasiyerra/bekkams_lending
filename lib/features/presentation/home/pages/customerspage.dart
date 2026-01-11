import 'package:bekkams_lending/features/presentation/home/widgets/customercard.dart';
import 'package:flutter/material.dart';

class MyCustomersPage extends StatelessWidget {
  const MyCustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Center(
          child: const Text('Customers', style: TextStyle(color: Colors.white)),
        ),
        // actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [_buildSearchBar(), Expanded(child: _buildCustomerList())],
      ),
    );
  }

  // 🔍 Search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search customers...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // 👥 Customers List
  Widget _buildCustomerList() {
    final customers = [
      CustomerCardWidget(
        customerName: 'John Smith',
        customerEmail: 'john.smith@email.com',
        customerPhNo: '320-555-1234',
      ),
      CustomerCardWidget(
        customerName: 'John Smith',
        customerEmail: 'john.smith@email.com',
        customerPhNo: '320-555-1234',
      ),
      CustomerCardWidget(
        customerName: 'John Smith',
        customerEmail: 'john.smith@email.com',
        customerPhNo: '320-555-1234',
      ),
      CustomerCardWidget(
        customerName: 'John Smith',
        customerEmail: 'john.smith@email.com',
        customerPhNo: '320-555-1234',
      ),
    ];

    return ListView.separated(
      itemCount: customers.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return customers[index];
      },
    );
  }
}
