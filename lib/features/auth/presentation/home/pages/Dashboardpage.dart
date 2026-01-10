import 'package:bekkams_lending/features/auth/presentation/auth/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/home/widgets/customcolumn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDashboardPage extends StatelessWidget {
  const MyDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        // if (authenticationprovider.userProfile == null) {
        //   return Scaffold(
        //     body: Center(
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 25),
        //         child: Text(
        //           "Unable to fetch the user data please contact app manager",
        //         ),
        //       ),
        //     ),
        //   );
        // }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Dashboard"),
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(Icons.notifications_none),
              ),
            ],
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// WELCOME TEXT
                const Text(
                  "Welcome 👋",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                /// STATS GRID
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  children: const [
                    MyDashboardCard(
                      title: "Total Customers",
                      value: "320",
                      icon: Icons.people,
                      color: Colors.blue,
                    ),
                    MyDashboardCard(
                      title: "Active Loans",
                      value: "85",
                      icon: Icons.account_balance,
                      color: Colors.green,
                    ),
                    MyDashboardCard(
                      title: "Amount Lent",
                      value: "₹1,250,000",
                      icon: Icons.currency_rupee,
                      color: Colors.orange,
                    ),
                    MyDashboardCard(
                      title: "Overdue Loans",
                      value: "12",
                      icon: Icons.warning,
                      color: Colors.red,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// RECENT ACTIVITY PLACEHOLDER
                const Text(
                  "Recent Activity",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "No recent activity",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
