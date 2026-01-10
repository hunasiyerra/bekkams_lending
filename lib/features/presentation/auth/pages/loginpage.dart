// ignore_for_file: use_build_context_synchronously

import 'package:bekkams_lending/features/presentation/home/pages/homepages.dart';
import 'package:bekkams_lending/features/presentation/auth/pages/signuppage.dart';
import 'package:bekkams_lending/features/presentation/auth/provider/authprovider.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/filledbutton.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/textbutton.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.clear();
    password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (BuildContext context, authenticationprovider, child) {
        return authenticationprovider.loadingstate == true
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Scaffold(
              backgroundColor: Colors.black,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Login Screen",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        obscureText: false,
                        errortext: authenticationprovider.emaillError,
                        hintText: 'Enter Email',
                        textEditingController: email,
                        ontap: () {
                          authenticationprovider.clearEmailError();
                        },
                      ),
                      SizedBox(height: 20),
                      MyTextField(
                        obscureText: authenticationprovider.obscureText,
                        errortext: authenticationprovider.passwordError,
                        hintText: 'Enter Password',
                        textEditingController: password,
                        ontap: () {
                          authenticationprovider.clearPasswordError();
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            authenticationprovider.showPassword();
                          },
                          icon:
                              authenticationprovider.obscureText == true
                                  ? Icon(Icons.remove_red_eye)
                                  : Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomFilledButton(
                        onPressed: () async {
                          final user = await authenticationprovider
                              .signInWithEmailAndPassword(
                                email.text.trim(),
                                password.text.trim(),
                              );

                          if (!mounted) return;
                          if (user == null &&
                              authenticationprovider.errorstate == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarAnimationStyle: AnimationStyle(
                                duration: Duration(seconds: 2),
                              ),
                              SnackBar(
                                content: Text(
                                  "Invalid email or password Please try Again",
                                  style: TextStyle(color: Colors.white),
                                ),
                                backgroundColor: Colors.grey[800],
                              ),
                            );
                          }
                          if (user != null) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => MyHomePage(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          }
                        },
                        buttonName: "Login",
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have a account Please",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 10),
                          MyTextButton(
                            text: Text(
                              "Click here",
                              style: TextStyle(color: Colors.blue),
                            ),
                            ontap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => AuthSignUpPage(),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
