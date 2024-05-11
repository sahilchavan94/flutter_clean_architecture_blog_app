import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class SeeOthersBlogsView extends StatelessWidget {
  final List<BlogEntity> blogList;
  final String posterId;
  const SeeOthersBlogsView({
    super.key,
    required this.blogList,
    required this.posterId,
  });

  @override
  Widget build(BuildContext context) {
    final blogs = blogList.filter((t) => t.posterId == posterId).toList();

    //get the poster data here itself
    final posterName =
        "${blogList.first.userEntity!.firstname} ${blogList.first.userEntity!.lastname}";
    final posterEmail = blogList.first.userEntity!.email;
    final posterImage = blogList.first.userEntity!.profileImageUrl;
    final posterInterests = blogList.first.userEntity!.interestedCategories;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More by ${blogList.first.userEntity!.firstname.capitalize()}',
        ),
      ),
      body: ScrollConfiguration(
        behavior: const CupertinoScrollBehavior(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 35,
                ),
                CustomImageView(
                  imagePath: posterImage,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  radius: BorderRadius.circular(100),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${posterName.split(" ")[0].capitalize()} ${posterName.split(" ")[1].capitalize()}",
                  style:
                      AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppPallete.grayLabel,
                  ),
                ),
                Text(
                  posterEmail,
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppPallete.tabLabelUnselectedColor,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Personal Interests',
                  style:
                      AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppPallete.primaryColor,
                  ),
                ),
                Text(
                  "${posterName.split(" ")[0].capitalize()}'s personal interests are here",
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppPallete.tabLabelUnselectedColor,
                    height: 1,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlogInterestWrapper(list: posterInterests),
                Center(
                  child: Visibility(
                    visible: blogs.isEmpty,
                    child: const CustomErrorWidget(
                      message: 'No more blogs',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  'Blogs by ${posterName.split(" ")[0].capitalize()}',
                  style:
                      AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppPallete.primaryColor,
                  ),
                ),
                Text(
                  "Read more blogs by ${posterName.split(" ")[0].capitalize()}, read on different topics",
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
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
                  runSpacing: 8,
                  children: List.generate(
                    blogList.length,
                    (index) => CustomBlogWidget(
                      blogEntity: blogList[index],
                      padding: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
