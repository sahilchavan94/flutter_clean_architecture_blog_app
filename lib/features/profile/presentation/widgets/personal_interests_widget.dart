import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/strings/strings.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
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
        BlogInterestWrapper(list: list),
      ],
    );
  }
}