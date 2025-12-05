import 'package:bekkams_lending/corecomponents/getit.dart';
import 'package:bekkams_lending/features/auth/presentation/pages/loginpage.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  serviceLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 690),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<Authenticationprovider>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fruit Market Application',
          home: AuthLoginPage(),
        ),
      ),
    );
  }
}
