import 'package:bekkams_lending/corecomponents/mediaquery.dart';
import 'package:bekkams_lending/features/auth/presentation/pages/homepage.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        return authenticationprovider.loadingstate == true
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Mediaquery.getScreenSize(context).height,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 50),
                        MyTextField(
                          obscureText: false,
                          errortext: authenticationprovider.emaillError,
                          hintText: 'First Name',
                          textEditingController:
                              authenticationprovider.firstName,
                          ontap: () {
                            authenticationprovider.clearEmailError();
                          },
                        ),
                        SizedBox(height: 20),
                        MyTextField(
                          obscureText: false,
                          errortext: authenticationprovider.emaillError,
                          hintText: 'Last Name',
                          textEditingController:
                              authenticationprovider.lastName,
                          ontap: () {
                            authenticationprovider.clearEmailError();
                          },
                        ),
                        SizedBox(height: 20),
                        MyTextField(
                          obscureText: false,
                          errortext: authenticationprovider.emaillError,
                          hintText: 'Phone number',
                          textEditingController:
                              authenticationprovider.phoneNumber,
                          ontap: () {
                            authenticationprovider.clearEmailError();
                          },
                        ),
                        SizedBox(height: 20),
                        MyTextField(
                          obscureText: false,
                          errortext: authenticationprovider.emaillError,
                          hintText: 'Email',
                          textEditingController: authenticationprovider.email,
                          ontap: () {
                            authenticationprovider.clearEmailError();
                          },
                        ),
                        SizedBox(height: 20),
                        MyTextField(
                          obscureText: authenticationprovider.obscureText,
                          errortext: authenticationprovider.passwordError,
                          hintText: 'Password',
                          textEditingController:
                              authenticationprovider.password,
                          ontap: () {
                            authenticationprovider.clearPasswordError();
                          },
                          onChanged: (value) {
                            if (authenticationprovider
                                .confirmPasword
                                .text
                                .isNotEmpty) {
                              authenticationprovider.checkConfirmPassword(
                                value,
                              );
                            }
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
                        MyTextField(
                          perfixIcon:
                              authenticationprovider.confirmPasswordError ==
                                          null &&
                                      authenticationprovider
                                          .confirmPasword
                                          .text
                                          .isNotEmpty
                                  ? Icon(Icons.check_box_rounded)
                                  : null,
                          obscureText:
                              authenticationprovider.obscurePasswordText,
                          errortext:
                              authenticationprovider.confirmPasswordError,
                          hintText: 'Confirm Password',
                          textEditingController:
                              authenticationprovider.confirmPasword,
                          ontap: () {
                            authenticationprovider.checkPasswordError();
                          },
                          onChanged: (value) {
                            authenticationprovider.checkConfirmPassword(value);
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              authenticationprovider.showConfirmPassword();
                            },
                            icon:
                                authenticationprovider.obscurePasswordText ==
                                        true
                                    ? Icon(Icons.remove_red_eye)
                                    : Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                        SizedBox(height: 20),
                        CustomFilledButton(
                          onPressed: () async {
                            final user =
                                await authenticationprovider
                                    .signUpWithEmailAndPassword();
                            if (!mounted) return;
                            print(user);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyHomePage(),
                                ),
                              );
                            }
                            // else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     SnackBar(
                            //       content: Text(
                            //         authenticationprovider.errorstate!,
                            //         style: TextStyle(color: Colors.white),
                            //       ),
                            //       backgroundColor: Colors.grey[800],
                            //     ),
                            //   );
                            // }
                          },
                          buttonName: "Signup",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
      },
    );
  }
}
