import 'package:bekkams_lending/features/auth/presentation/home/pages/Dashboardpage.dart';
import 'package:bekkams_lending/features/auth/presentation/home/pages/homepages.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/pages/loginpage.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appstatepage extends StatelessWidget {
  const Appstatepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        if (!authenticationprovider.authChecked) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (authenticationprovider.userData != null) {
          return const MyHomePage();
        }
        return const AuthLoginPage();
      },
    );
  }
}
