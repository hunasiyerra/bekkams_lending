import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/customcolumn.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        return Scaffold(
          bottomNavigationBar: NavigationBar(
            destinations: [
              MyCustomColumn(text: "Profile", iconData: Icons.face_2_outlined),
              MyCustomColumn(text: "Profile", iconData: Icons.face_2_outlined),
              MyCustomColumn(text: "Profile", iconData: Icons.face_2_outlined),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Welcome Boss ${authenticationprovider.userProfile?.firstName}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              CustomFilledButton(
                onPressed: () {
                  authenticationprovider.appSignOut();
                },
                buttonName: "Sign out",
              ),
            ],
          ),
        );
      },
    );
  }
}
