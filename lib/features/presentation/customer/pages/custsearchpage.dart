import 'package:flutter/material.dart';
import 'package:bekkams_lending/features/presentation/home/widgets/customercard.dart';

class CustomerSearchPage extends StatefulWidget {
  const CustomerSearchPage({super.key});

  @override
  State<CustomerSearchPage> createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  final TextEditingController _controller = TextEditingController();

  final List<CustomerModel> _allCustomers = [
    CustomerModel(
      name: 'John Smith',
      email: 'john.smith@email.com',
      phone: '320-555-1234',
    ),
    CustomerModel(
      name: 'Alice Brown',
      email: 'alice.brown@email.com',
      phone: '320-555-5678',
    ),
    CustomerModel(
      name: 'David Wilson',
      email: 'david@email.com',
      phone: '320-555-9999',
    ),
  ];

  List<CustomerModel> _results = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearch);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch() {
    final query = _controller.text.toLowerCase();

    setState(() {
      _results =
          _allCustomers.where((customer) {
            return customer.name.toLowerCase().contains(query) ||
                customer.email.toLowerCase().contains(query) ||
                customer.phone.contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search customers',
            border: InputBorder.none,
          ),
        ),
      ),
      body: _buildResults(),
    );
  }

  Widget _buildResults() {
    if (_controller.text.isEmpty) {
      return const Center(
        child: Text(
          'Start typing to search customers',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    if (_results.isEmpty) {
      return const Center(
        child: Text('No customers found', style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: _results.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final customer = _results[index];

        return CustomerCardWidget(
          customerName: customer.name,
          customerEmail: customer.email,
          customerPhNo: customer.phone,
        );
      },
    );
  }
}

class CustomerModel {
  final String name;
  final String email;
  final String phone;

  CustomerModel({required this.name, required this.email, required this.phone});
}
