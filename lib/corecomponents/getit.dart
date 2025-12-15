import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:bekkams_lending/features/auth/data/firebaserepositoryimpl.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/imageprovider.dart';
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
}
