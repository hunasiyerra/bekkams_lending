import 'package:flutter/material.dart';

class MyLoanpage extends StatelessWidget {
  const MyLoanpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1565C0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Loans'),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [_buildSearchBar(), Expanded(child: _buildLoansList())],
      ),
    );
  }

  // 🔍 Search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search loans...',
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

  // 📋 Loans list
  Widget _buildLoansList() {
    final loans = [
      Loan(
        customerName: 'John Smith',
        amount: 20000,
        emi: 500,
        status: LoanStatus.active,
      ),
      Loan(
        customerName: 'Emily Davis',
        amount: 15000,
        emi: 400,
        status: LoanStatus.overdue,
      ),
      Loan(
        customerName: 'Michael Lee',
        amount: 30000,
        emi: 600,
        status: LoanStatus.dueToday,
      ),
      Loan(
        customerName: 'Sara Khan',
        amount: 25000,
        emi: 550,
        status: LoanStatus.closed,
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: loans.length,
      itemBuilder: (context, index) {
        return _LoanCard(loan: loans[index]);
      },
    );
  }
}

class _LoanCard extends StatelessWidget {
  final Loan loan;

  const _LoanCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loan.customerName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text('Loan Amount: \$${loan.amount.toStringAsFixed(0)}'),
                  const SizedBox(height: 2),
                  Text('EMI : \$${loan.emi.toStringAsFixed(0)} / mo'),
                ],
              ),
            ),
            _LoanStatusBadge(status: loan.status),
          ],
        ),
      ),
    );
  }
}

// 🏷 Status badge
class _LoanStatusBadge extends StatelessWidget {
  final LoanStatus status;

  const _LoanStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final statusData = _statusConfig(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusData.color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        statusData.label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  _StatusConfig _statusConfig(LoanStatus status) {
    switch (status) {
      case LoanStatus.active:
        return _StatusConfig('Active', Colors.green);
      case LoanStatus.overdue:
        return _StatusConfig('Overdue', Colors.red);
      case LoanStatus.dueToday:
        return _StatusConfig('Due Today', Colors.orange);
      case LoanStatus.closed:
        return _StatusConfig('Closed', Colors.grey);
    }
  }
}

// 📦 Models (temporary UI models)
class Loan {
  final String customerName;
  final double amount;
  final double emi;
  final LoanStatus status;

  Loan({
    required this.customerName,
    required this.amount,
    required this.emi,
    required this.status,
  });
}

enum LoanStatus { active, overdue, dueToday, closed }

class _StatusConfig {
  final String label;
  final Color color;

  _StatusConfig(this.label, this.color);
}
