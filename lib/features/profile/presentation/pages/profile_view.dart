import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_view.dart';
import 'package:blog_app/features/profile/presentation/widgets/personal_interests_widget.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignedOut) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully signed out'),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignInView()),
              (route) => false,
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
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AuthSuccess) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .06),
                      const ProfileInfoWidget(),
                      const SizedBox(
                        height: 50,
                      ),
                      const PersonalInterestsWidget(),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppPallete.bottomSheetColor
                                    : Colors.white,
                                surfaceTintColor:
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? AppPallete.bottomSheetColor
                                        : Colors.white,
                                content: Container(
                                  padding: const EdgeInsets.all(12),
                                  width:
                                      MediaQuery.of(context).size.width * .85,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Are you sure to sign out from this account ?",
                                        style: AppTheme.darkThemeData.textTheme
                                            .displayLarge!
                                            .copyWith(
                                          fontSize: 18,
                                          color: Theme.of(context).brightness !=
                                                  Brightness.dark
                                              ? AppPallete.grayDark
                                              : Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                            .brightness !=
                                                        Brightness.dark
                                                    ? AppPallete.grayDark
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: .5,
                                            color: AppPallete.grayLabel,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pop(context);
                                              context
                                                  .read<AuthBloc>()
                                                  .add(AuthSignOut());
                                            },
                                            child: const Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: AppPallete.errorColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          'Sign out',
                          style: AppTheme.darkThemeData.textTheme.displayMedium!
                              .copyWith(color: AppPallete.errorColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const CustomErrorWidget(
            message: 'Failed to fetch user profile',
          );
        },
      ),
    );
  }
}
