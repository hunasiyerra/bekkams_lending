import 'package:bekkams_lending/corecomponents/getit.dart';
import 'package:bekkams_lending/features/presentation/home/pages/appstatepage.dart';
import 'package:bekkams_lending/features/presentation/auth/provider/authprovider.dart';
import 'package:bekkams_lending/features/presentation/home/provider/homeprovider.dart';
import 'package:bekkams_lending/features/presentation/auth/provider/imageprovider.dart';
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
          ChangeNotifierProxyProvider<
            Authenticationprovider,
            HomeProfileprovider
          >(
            create: (_) => sl<HomeProfileprovider>(),
            update: (_, auth, home) {
              if (auth.userData != null) {
                home!.fetchProfileData(auth.userData!.uid);
              } else {
                home!.clear();
              }
              return home;
            },
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
