import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_view.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_home.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => serviceLocator<ProfileBloc>(),
        ),
        BlocProvider(
          lazy: false,
          create: (_) => serviceLocator<CurrentUserCubit>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeData,
      themeMode: ThemeMode.dark,
      home: BlocSelector<CurrentUserCubit, CurrentUserState, bool>(
        selector: (state) => state is CurrentUserDataFetched,
        builder: (context, isFetched) {
          if (isFetched) {
            return const BlogHome();
          }
          return const SignUpView();
        },
      ),
    );
  }
}
