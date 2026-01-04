import 'package:bekkams_lending/features/auth/presentation/pages/homepage.dart';
import 'package:bekkams_lending/features/auth/presentation/pages/loginpage.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Appstatepage extends StatelessWidget {
  const Appstatepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        return authenticationprovider.userData == null
            ? AuthLoginPage()
            : MyHomePage();
      },
    );
  }
}
