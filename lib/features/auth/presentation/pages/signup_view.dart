import 'package:blog_app/core/common/widgets/button_widget.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/validators/auth_validators.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_view.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_input_widget.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with AuthValidators {
  bool isActive = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_updateActive);
    _lastNameController.addListener(_updateActive);
    _emailController.addListener(_updateActive);
    _emailController.addListener(_updateActive);
    _confirmPasswordController.addListener(_updateActive);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateActive);
    _lastNameController.removeListener(_updateActive);
    _emailController.removeListener(_updateActive);
    _emailController.removeListener(_updateActive);
    _confirmPasswordController.removeListener(_updateActive);
    super.dispose();
  }

  void _updateActive() {
    setState(() {
      isActive = _formKey.currentState!.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Created new account'),
            ),
          );
          context.read<AuthBloc>().add(AuthIsUserLoggedIn());
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogHome(),
            ),
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Scrollbar(
            interactive: true,
            child: SingleChildScrollView(
              reverse: false,
              physics: const RangeMaintainingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          'Get Started',
                          style: AppTheme.darkThemeData.textTheme.displayLarge,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      'Unleash your creativity, sign up now to start sharing your stories and exploring new perspectives.',
                      style: AppTheme.darkThemeData.textTheme.displaySmall!
                          .copyWith(
                        color: AppPallete.grayLight,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    //form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AuthInputWidget(
                            hintText: 'Enter your first name',
                            labelText: 'First name',
                            textEditingController: _firstNameController,
                            validator: validator,
                          ),
                          AuthInputWidget(
                            hintText: 'Enter your last name',
                            labelText: 'Last name',
                            textEditingController: _lastNameController,
                            validator: validator,
                          ),
                          AuthInputWidget(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            textEditingController: _emailController,
                            validator: emailValidator,
                          ),
                          AuthInputWidget(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            textEditingController: _passwordController,
                            obscureText: true,
                            suffixIcon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            validator: passwordValidator,
                          ),
                          AuthInputWidget(
                            hintText: 'Confirm your password',
                            labelText: 'Confirm password',
                            textEditingController: _confirmPasswordController,
                            obscureText: true,
                            suffixIcon: const Icon(
                              Icons.remove_red_eye,
                            ),
                            validator: passwordValidator,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ButtonWidget(
                            buttonText: 'Next',
                            isLoading: state.runtimeType == AuthLoading,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                    AuthSignup(
                                      firstname: _firstNameController.text,
                                      lastname: _lastNameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text,
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
                              return const SignInView();
                            },
                          ),
                        );
                      },
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                color: AppPallete.grayLight,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
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
            ),
          ),
        );
      },
    );
  }
}
