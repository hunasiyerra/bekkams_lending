import 'package:bekkams_lending/features/auth/presentation/home/provider/homeprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProfileprovider>(
      builder: (context, profileProvider, child) {
        return PopScope(
          canPop: false,
          // onPopInvokedWithResult: (didPop, result) {
          //   if (didPop) return;
          //   // Handle back press manually
          // },
          child: Scaffold(
            body: IndexedStack(
              index: profileProvider.currentIndex,
              children: profileProvider.pages,
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: profileProvider.currentIndex,
              onDestinationSelected: (index) {
                profileProvider.changeNavigationIndex(index);
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.account_balance_outlined),
                  selectedIcon: Icon(Icons.account_balance),
                  label: 'Loans',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: 'Customers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
