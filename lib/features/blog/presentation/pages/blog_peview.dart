import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/blog/presentation/widgets/preview_blog/carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BlogPreview extends StatefulWidget {
  const BlogPreview({super.key});

  @override
  State<BlogPreview> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<BlogPreview> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditBlogManager>(
      builder: (context, editBlogManager, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //this stack will contain all the images
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CarouselImageSlider(
                    imageList: editBlogManager.blogImageList,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 1),
                            Color.fromRGBO(0, 0, 0, .75),
                            Color.fromRGBO(0, 0, 0, 0),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              editBlogManager.blogTitle.text,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayLarge!
                                  .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              editBlogManager.blogSubTitle.text,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 20,
                                color: AppPallete.grayLabel,
                              ),
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
                    Text(
                      'Relevant categories to this blog',
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        fontSize: 20,
                        color: AppPallete.grayLabel,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
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
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        fontSize: 20,
                        color: AppPallete.grayLabel,
                      ),
                    ),
                  ],
                ),
              )
              //this will contain the categories relevant
            ],
          ),
        );
      },
    );
  }
}
