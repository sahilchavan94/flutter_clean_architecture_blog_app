import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogHome extends StatefulWidget {
  const BlogHome({super.key});

  @override
  State<BlogHome> createState() => _BlogHomeState();
}

class _BlogHomeState extends State<BlogHome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this line
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          // context.read<AuthBloc>().add(AuthIsUserLoggedIn());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('Logged out from current account'),
            ),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInView(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          key: _scaffoldKey,
          body: Center(
            child: GestureDetector(
              onTap: () {
                context.read<AuthBloc>().add(AuthSignOut());
              },
              child: const Text("Log out"),
            ),
          ),
        );
      },
    );
  }
}
