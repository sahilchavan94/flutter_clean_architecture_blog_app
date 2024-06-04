import 'package:blog_app/core/common/widgets/button_widget.dart';
import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/validators/auth_validators.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/select_interests.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_view.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with AuthValidators {
  bool isActive = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
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
      if (_firstNameController.text.isNotEmpty &&
          _lastNameController.text.isNotEmpty &&
          _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty) {
        isActive = _formKey.currentState!.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedIn) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectInterests(),
            ),
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 1500),
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ScrollConfiguration(
            behavior: const CupertinoScrollBehavior(),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: MediaQuery.of(context).size.height * .1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Get Started 🕊️',
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        fontSize: 28,
                        color: Theme.of(context).brightness != Brightness.dark
                            ? AppPallete.primaryLightColor
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Text(
                      AppStrings.signUpString,
                      style: AppTheme.darkThemeData.textTheme.displaySmall!
                          .copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppPallete.grayLabel
                            : AppPallete.grayDark,
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //form
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AuthInputWidget(
                                width: MediaQuery.of(context).size.width * .44,
                                hintText: 'Enter your first name',
                                labelText: 'First name',
                                textEditingController: _firstNameController,
                                validator: validator,
                                suffixIcon:
                                    const Icon(CupertinoIcons.person_fill),
                              ),
                              AuthInputWidget(
                                width: MediaQuery.of(context).size.width * .44,
                                hintText: 'Enter your last name',
                                labelText: 'Last name',
                                textEditingController: _lastNameController,
                                validator: validator,
                                suffixIcon:
                                    const Icon(CupertinoIcons.person_fill),
                              ),
                            ],
                          ),
                          AuthInputWidget(
                            hintText: 'Enter your email',
                            labelText: 'Email',
                            textEditingController: _emailController,
                            validator: emailValidator,
                            suffixIcon: const Icon(CupertinoIcons.mail_solid),
                          ),
                          AuthInputWidget(
                            hintText: 'Enter your password',
                            labelText: 'Password',
                            textEditingController: _passwordController,
                            obscureText: hidePassword,
                            suffixIcon: const Icon(
                              CupertinoIcons.lock_fill,
                            ),
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            validator: passwordValidator,
                          ),
                          AuthInputWidget(
                            hintText: 'Confirm your password',
                            labelText: 'Confirm password',
                            textEditingController: _confirmPasswordController,
                            obscureText: hideConfirmPassword,
                            onPressed: () {
                              setState(() {
                                hideConfirmPassword = !hideConfirmPassword;
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
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: AppPallete.grayLight,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? AppPallete.primaryColor
                                      : AppPallete.primaryLightColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
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
