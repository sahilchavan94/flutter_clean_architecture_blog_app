import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/blog/presentation/widgets/preview_blog/carousel_image_slider.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlogReadView extends StatefulWidget {
  final BlogEntity blogEntity;
  const BlogReadView({
    super.key,
    required this.blogEntity,
  });

  @override
  State<BlogReadView> createState() => _BlogReadViewState();
}

class _BlogReadViewState extends State<BlogReadView> {
  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
    // initialScrollOffset: 4500,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        controller: scrollController,
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.black.withOpacity(.65),
            centerTitle: true,
            title: Text(
              widget.blogEntity.userEntity != null
                  ? "${widget.blogEntity.userEntity!.firstname.capitalize()} ${widget.blogEntity.userEntity!.lastname.capitalize()}"
                  : 'Anonymous',
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            pinned: true,
            floating: false,
            actions: [
              Consumer<EditBlogManager>(
                builder: (context, editBlogManager, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${(editBlogManager.currentBlogImage + 1).toString()}  /  ${widget.blogEntity.imageUrlList.length}",
                      style: AppTheme.darkThemeData.textTheme.displaySmall!
                          .copyWith(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
            expandedHeight: MediaQuery.of(context).size.height * .5,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CarouselImageSlider(
                    imageList: widget.blogEntity.imageUrlList,
                    isComingFromNetwork: true,
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
                              widget.blogEntity.blogTitle,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayLarge!
                                  .copyWith(
                                height: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.blogEntity.blogSubTitle.capitalize(),
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 17.5,
                                color: Colors.white54,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //poster details
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * .8,
              child: ListTile(
                leading: CustomImageView(
                  imagePath:
                      widget.blogEntity.userEntity?.profileImageUrl ?? '',
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  radius: BorderRadius.circular(50),
                ),
                title: Text(
                  widget.blogEntity.userEntity != null
                      ? "${widget.blogEntity.userEntity!.firstname.capitalize()} ${widget.blogEntity.userEntity!.lastname.capitalize()}"
                      : 'Anonymous',
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontSize: 17,
                  ),
                ),
                subtitle: Text(
                  widget.blogEntity.date!.isNotEmpty
                      ? widget.blogEntity.date.toString()
                      : 'Uploaded date not found',
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white54
                        : Colors.black54,
                  ),
                ),
              ),
            ),
          ),

          //blog categories
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
              child: BlogInterestWrapper(
                list: widget.blogEntity.blogCategories,
              ),
            ),
          ),

          //blog content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.blogEntity.blogContent,
                style: AppTheme.darkThemeData.textTheme.titleLarge!.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
