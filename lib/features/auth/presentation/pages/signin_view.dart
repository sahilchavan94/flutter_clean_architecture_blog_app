import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/validators/auth_validators.dart';
import 'package:blog_app/core/common/widgets/button_widget.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signup_view.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_input_widget.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isActive = false;
  bool hidePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateActive);
    _passwordController.addListener(_updateActive);
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateActive);
    _passwordController.removeListener(_updateActive);
    super.dispose();
  }

  void _updateActive() {
    setState(() {
      if (_emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        isActive = _formKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1500),
              content: Text(state.message),
            ),
          );
        }
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(milliseconds: 1500),
              content: Text('Logged into account'),
            ),
          );
          context.read<AuthBloc>().add(AuthIsUserLoggedIn());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogHome(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: MediaQuery.of(context).size.height * .1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/blog_logo.png',
                      height: 32,
                      width: 32,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Welcome back',
                      style: AppTheme.darkThemeData.textTheme.displayLarge,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  AppStrings.signInString,
                  style:
                      AppTheme.darkThemeData.textTheme.displaySmall!.copyWith(
                    color: AppPallete.grayLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),

                //form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      AuthInputWidget(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        textEditingController: _emailController,
                        validator: emailValidator,
                        suffixIcon: const Icon(
                          CupertinoIcons.mail_solid,
                        ),
                      ),
                      AuthInputWidget(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        textEditingController: _passwordController,
                        obscureText: hidePassword,
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        suffixIcon: const Icon(
                          CupertinoIcons.lock_fill,
                        ),
                        validator: passwordValidator,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ButtonWidget(
                        isLoading: state.runtimeType == AuthLoading,
                        buttonText: 'Continue',
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                AuthSignIn(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );
                        },
                        isActive: isActive,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return const SignUpView();
                        },
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            color: AppPallete.grayLight,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: AppPallete.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
