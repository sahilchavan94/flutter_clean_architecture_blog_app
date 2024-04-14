//global object for getit
import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up.dart';
import 'package:blog_app/features/auth/domain/usecases/update_user_interests.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  //register the firebase auth
  final firebaseAuthInstance = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuthInstance);

  //register the cloud firestore
  final firebaseDatabase = FirebaseDatabase.instance;
  firebaseDatabase.setPersistenceEnabled(true);
  serviceLocator.registerLazySingleton(() => firebaseDatabase);

  //core
  serviceLocator.registerLazySingleton(
    () => CurrentUserCubit(),
  );

  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        firebaseAuth: serviceLocator(),
        firebaseDatabase: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignIn(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUser(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateCurrentUserInterests(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignOut(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    );
}
