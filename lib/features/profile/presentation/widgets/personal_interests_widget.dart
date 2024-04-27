import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/lists/category_list.dart';
import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/reduce_alpha.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInterestsWidget extends StatefulWidget {
  const PersonalInterestsWidget({super.key});

  @override
  State<PersonalInterestsWidget> createState() =>
      _PersonalInterestsWidgetState();
}

class _PersonalInterestsWidgetState extends State<PersonalInterestsWidget> {
  @override
  Widget build(BuildContext context) {
    final list =
        (context.read<CurrentUserCubit>().state as CurrentUserDataFetched)
            .userEntity
            .interestedCategories;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Interests',
          style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w400,
            color: AppPallete.primaryColor,
          ),
        ),
        Text(
          AppStrings.personalInterestString,
          style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: AppPallete.tabLabelUnselectedColor,
            height: 1,
          ),
          maxLines: 1,
        ),
        const SizedBox(
          height: 15,
        ),
        Wrap(
          spacing: 7,
          runSpacing: -6,
          runAlignment: WrapAlignment.center,
          children: List.generate(
            list.length,
            (index) => Chip(
              padding: const EdgeInsets.all(1),
              labelPadding: const EdgeInsets.symmetric(horizontal: 8),
              label: Text(
                list[index],
                style: TextStyle(
                  color: CategoryList
                      .categoryColors[CategoryList.blogCategories[index]],
                ),
              ),
              side: BorderSide.none,
              surfaceTintColor: ColorManipulation.reduceAlpha(
                CategoryList
                    .categoryColors[CategoryList.blogCategories[index]]!,
              ),
              backgroundColor: ColorManipulation.reduceAlpha(
                CategoryList
                    .categoryColors[CategoryList.blogCategories[index]]!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
