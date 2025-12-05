import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        return Scaffold(
          body: Center(
            child: Text(
              "Welcome Boss ${authenticationprovider.userData!.email}",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }
}
