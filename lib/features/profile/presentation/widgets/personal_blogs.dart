import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalBlogsWidget extends StatelessWidget {
  const PersonalBlogsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Blogs by you',
              style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppPallete.primaryColor
                    : AppPallete.primaryLightColor,
              ),
            ),
            Text(
              "All the blogs added by you will appear below",
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppPallete.tabLabelUnselectedColor
                    : AppPallete.grayDark,
              ),
              maxLines: 1,
            ),
            const SizedBox(
              height: 6,
            ),
            BlocBuilder<BlogBloc, BlogState>(
              builder: (context, state) {
                if (state is BlogGetAllBlogLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is BlogGetAllBlogFailure) {
                  return const CustomErrorWidget();
                }
                if (state is BlogGetAllBlogSuccess) {
                  if (state.personalBlogs.isEmpty) {
                    return const SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Icon(
                            Icons.block,
                            color: AppPallete.grayLight,
                            size: 60,
                          ),
                          Text(
                            "No blogs added by you",
                            style: TextStyle(
                              color: Color.fromARGB(255, 125, 125, 125),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...state.personalBlogs.map(
                        (personalBlog) => CustomBlogWidget(
                          blogEntity: personalBlog,
                          padding: 0,
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
      ),
    );
  }
}
