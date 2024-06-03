//global object for getit
import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/cubits/managers/theme_manager.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/get_user_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/update_user_interests_usecase.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:blog_app/features/blog/domain/usecases/add_blog_to_favs.dart';
import 'package:blog_app/features/blog/domain/usecases/check_blog_in_favs.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_all_favs.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog_images.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/blocs/fav_blogs/fav_blogs_bloc.dart';
import 'package:blog_app/features/blog/presentation/blocs/favs/bloc/favs_bloc.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:blog_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:blog_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:blog_app/features/profile/domain/usecases/profile_general_upload_usecase.dart';
import 'package:blog_app/features/profile/domain/usecases/update_profile_pic_usecase.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  //register the firebase auth
  final firebaseAuthInstance = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton(() => firebaseAuthInstance);

  //register the firebase database
  final firebaseDatabase = FirebaseDatabase.instance;
  firebaseDatabase.setPersistenceEnabled(true);
  serviceLocator.registerLazySingleton(() => firebaseDatabase);

  //register the firebase storage
  final firebaseStorage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => firebaseStorage);

  await Hive.initFlutter();
  await Hive.openBox(
    'blogs',
    path: (await getApplicationDocumentsDirectory()).path,
  );

  //register hive box and shared prefs
  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));
  serviceLocator.registerLazySingleton(
    () async => await SharedPreferences.getInstance(),
  );

  //core
  _initCubitsAndProviders();
  _initAuth();
  _initProfile();
  _initBlog();
}

void _initCubitsAndProviders() {
  serviceLocator.registerLazySingleton<CurrentUserCubit>(
    () => CurrentUserCubit(),
  );
  serviceLocator.registerLazySingleton<EditBlogManager>(
    () => EditBlogManager(),
  );
  serviceLocator.registerLazySingleton<ThemeManager>(
    () => ThemeManager(),
  );
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
      () => SignUpUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignInUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetUserUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateCurrentUserInterestsUseCase(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => SignOutUseCase(
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

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
        firebaseStorage: serviceLocator(),
        firebaseDatabase: serviceLocator(),
      ),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        profileRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => ProfileGeneralUploadUseCase(
        profileRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UpdateProfilePictureUseCase(
        profileRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => ProfileBloc(
        serviceLocator(),
        serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory(
      () => BlogRemoteDataSourceImpl(
        firebaseDatabase: serviceLocator(),
        firebaseStorage: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => BlogLocalDataSourceImpl(box: serviceLocator()),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: serviceLocator(),
        blogLocalDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlogImagesUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlogUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => AddBlogToFavsUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CheckBlogInFavsUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllFavsUseCase(
        blogRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavsBloc(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => FavBlogsBloc(
        serviceLocator(),
      ),
    );
}
