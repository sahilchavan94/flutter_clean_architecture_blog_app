import 'package:blog_app/core/common/cubits/managers/theme_manager.dart';
import 'package:blog_app/core/common/widgets/button_widget.dart';
import 'package:blog_app/core/lists/category_list.dart';
import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectInterests extends StatefulWidget {
  const SelectInterests({super.key});

  @override
  State<SelectInterests> createState() => _SelectInterestsState();
}

class _SelectInterestsState extends State<SelectInterests> {
  List<String> selectedCategories = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUpdatedUserIn) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Updated user categories'),
            ),
          );
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
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * .09,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Interests',
                  style: AppTheme.darkThemeData.textTheme.displayLarge,
                ),
                Text(
                  AppStrings.selectInterestsString,
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    color: AppPallete.grayLight,
                    fontWeight: FontWeight.w300,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (selectedCategories.length ==
                        CategoryList.blogCategories.length) {
                      selectedCategories.clear();
                      return;
                    }
                    selectedCategories.clear();
                    selectedCategories.addAll(CategoryList.blogCategories);
                  });
                },
                icon: selectedCategories.length ==
                        CategoryList.blogCategories.length
                    ? const Icon(Icons.remove_circle)
                    : const Icon(Icons.select_all),
              )
            ],
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ButtonWidget(
                buttonText: 'Select at least 5 categories',
                onPressed: () async {
                  context.read<AuthBloc>().add(
                        AuthUpdateUserInterest(
                          selectedCategories: selectedCategories,
                        ),
                      );
                },
                isLoading: state.runtimeType == AuthLoading,
                isActive: selectedCategories.length >= 5,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //mapping the categories
                Expanded(
                  child: ListView.builder(
                    physics: const RangeMaintainingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: CategoryList.blogCategories.length,
                    itemBuilder: (context, index) {
                      String currentCategory =
                          CategoryList.blogCategories[index];
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                currentCategory,
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.2,
                                  color: context
                                              .read<ThemeManager>()
                                              .currentTheme ==
                                          'dark'
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (selectedCategories
                                        .contains(currentCategory)) {
                                      selectedCategories
                                          .remove(currentCategory);
                                      return;
                                    }
                                    selectedCategories.add(currentCategory);
                                  });
                                },
                                icon: !selectedCategories
                                        .contains(currentCategory)
                                    ? const Icon(
                                        Icons.radio_button_unchecked,
                                        size: 18,
                                      )
                                    : Icon(
                                        Icons.check_circle,
                                        size: 18,
                                        color: context
                                                    .read<ThemeManager>()
                                                    .currentTheme ==
                                                'dark'
                                            ? AppPallete.primaryColor
                                            : AppPallete.primaryLightColor,
                                      ),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: .125,
                            color: AppPallete.grayDark,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
