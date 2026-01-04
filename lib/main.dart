import 'package:bekkams_lending/corecomponents/getit.dart';
import 'package:bekkams_lending/features/auth/presentation/pages/appstatepage.dart';
//import 'package:bekkams_lending/features/auth/presentation/pages/imagespage.dart';
import 'package:bekkams_lending/features/auth/presentation/pages/loginpage.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/imageprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  serviceLocators();
  // we have to do in production.
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.debug, //FOR DEV
  //   // androidProvider: AndroidProvider.playIntegrity, // PROD
  // );
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
          ChangeNotifierProvider<CustomImageProvider>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lending application',
          home: Appstatepage(),
        ),
      ),
    );
  }
}
