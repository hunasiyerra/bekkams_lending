import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:bekkams_lending/features/auth/data/firebaserepositoryimpl.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/home/provider/homeprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/provider/imageprovider.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void serviceLocators() {
  sl.registerLazySingleton<Firebaserepository>(() => Firebaserepositoryimpl());
  sl.registerFactory<Authenticationprovider>(
    () => Authenticationprovider(firebaserepository: sl()),
  );
  sl.registerLazySingleton<CustomImageProvider>(
    () => CustomImageProvider(firebaserepository: sl()),
  );
  sl.registerLazySingleton<HomeProfileprovider>(
    () => HomeProfileprovider(firebaserepository: sl()),
  );
}
