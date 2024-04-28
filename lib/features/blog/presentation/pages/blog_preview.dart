import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/blog/presentation/widgets/preview_blog/carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BlogPreview extends StatefulWidget {
  const BlogPreview({super.key});

  @override
  State<BlogPreview> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<BlogPreview> {
  @override
  Widget build(BuildContext context) {
    final currentUserData =
        context.read<CurrentUserCubit>().state as CurrentUserDataFetched;

    return Consumer<EditBlogManager>(
      builder: (context, editBlogManager, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //this stack will contain all the images
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselImageSlider(
                    imageList: editBlogManager.blogImageList,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 180,
                      width: double.maxFinite,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 1),
                            Color.fromRGBO(0, 0, 0, 0),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              editBlogManager.blogTitle.text,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayLarge!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              editBlogManager.blogSubTitle.text,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 20,
                                color: AppPallete.grayLabel,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show the uploader data
                    Row(
                      children: [
                        CustomImageView(
                          width: 45,
                          height: 45,
                          imagePath: currentUserData.userEntity.profileImageUrl,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(40),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentUserData.userEntity.firstname.capitalize()} ${currentUserData.userEntity.lastname.capitalize()}",
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 16,
                                color: AppPallete.grayLabel,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              DateFormat().format(DateTime.now()),
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 12,
                                color: AppPallete.grayLabel,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    BlogInterestWrapper(
                      list: editBlogManager.blogCategories,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //now render the blog sub heading and the blog content
                    Text(
                      editBlogManager.blogSubHeading.text,
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        fontSize: 18,
                        color: AppPallete.grayLabel,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      editBlogManager.blogContent.text,
                      style: AppTheme.darkThemeData.textTheme.displayMedium!
                          .copyWith(
                        color: AppPallete.grayLabel,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
