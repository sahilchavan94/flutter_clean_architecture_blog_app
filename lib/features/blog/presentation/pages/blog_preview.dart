import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/blog/presentation/widgets/preview_blog/carousel_image_slider.dart';
import 'package:flutter/material.dart';
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
                                fontSize: 28,
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
                  ),
                  Positioned(
                    top: 30,
                    right: 35,
                    child: Container(
                      decoration: BoxDecoration(
                        color: editBlogManager.blogImageList
                                    .elementAt(editBlogManager.currentImage) ==
                                null
                            ? Colors.white.withOpacity(.1)
                            : Colors.black.withOpacity(.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      child: Text(
                        "${(editBlogManager.currentImage + 1).toString()}  /  ${editBlogManager.blogImageList.length}",
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //show the uploader data
                    BlogInterestWrapper(
                      list: editBlogManager.blogCategories,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //now render the blog sub heading and the blog content

                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      editBlogManager.blogContent.text,
                      style: AppTheme.darkThemeData.textTheme.displayMedium!
                          .copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppPallete.grayLabel
                            : Colors.black87,
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
