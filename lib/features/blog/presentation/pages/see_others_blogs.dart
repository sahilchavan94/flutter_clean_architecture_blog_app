import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/auth/domain/entities/user_entity.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class SeeOthersBlogsView extends StatelessWidget {
  final List<BlogEntity> blogList;
  final UserEntity user;
  const SeeOthersBlogsView({
    super.key,
    required this.blogList,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final blogs = blogList.filter((t) => t.posterId == user.uid).toList();

    //get the poster data here itself
    final posterFName = user.firstname.capitalize();
    final posterLName = user.lastname.capitalize();
    final posterEmail = user.email;
    final posterImage = user.profileImageUrl;
    final posterInterests = user.interestedCategories;

    return Scaffold(
      body: CustomScrollView(
        scrollBehavior: const CupertinoScrollBehavior(),
        slivers: [
          SliverAppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            backgroundColor: Colors.black.withOpacity(.7),
            title: Text(
              "Read more by $posterFName",
              style: TextStyle().copyWith(
                color: Colors.white,
              ),
            ),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * .4,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CustomImageView(
                    imagePath: posterImage,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * .5,
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 220,
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
                              "$posterFName $posterLName",
                              style: AppTheme
                                  .darkThemeData.textTheme.displayLarge!
                                  .copyWith(
                                height: 1.2,
                                fontSize: 30,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              posterEmail,
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
                  )
                ],
              ),
            ),
          ),

          //adding the poster iterests
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.20, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Interests',
                    style:
                        AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppPallete.primaryColor
                          : AppPallete.primaryLightColor,
                    ),
                  ),
                  Text(
                    "$posterFName's personal blog interests here",
                    style: AppTheme.darkThemeData.textTheme.displayMedium!
                        .copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppPallete.tabLabelUnselectedColor,
                      height: 1,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.20),
              child: BlogInterestWrapper(list: posterInterests),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$posterFName\'s blogs',
                    style:
                        AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppPallete.primaryColor
                          : AppPallete.primaryLightColor,
                    ),
                  ),
                  Text(
                    "Read more by $posterFName and enjoy reading new aspects",
                    style: AppTheme.darkThemeData.textTheme.displayMedium!
                        .copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: AppPallete.tabLabelUnselectedColor,
                      height: 1,
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 15,
                    children: List.generate(
                      blogs.length,
                      (index) => CustomBlogWidget(
                        blogEntity: blogs[index],
                        padding: 0,
                        isInHome: false,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
