import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/common/widgets/image_error_widget.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/data/models/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/blocs/blog/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/blocs/favs/bloc/favs_bloc.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_read_view.dart';
import 'package:blog_app/features/blog/presentation/pages/see_others_blogs.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlogWidget extends StatefulWidget {
  final BlogEntity blogEntity;
  final bool? isInHome;
  final double? padding;
  const CustomBlogWidget({
    super.key,
    required this.blogEntity,
    this.isInHome,
    this.padding,
  });

  @override
  State<CustomBlogWidget> createState() => _CustomBlogWidgetState();
}

class _CustomBlogWidgetState extends State<CustomBlogWidget> {
  @override
  void initState() {
    context
        .read<FavsBloc>()
        .add(FavsCheckInFavsEvent(uid: widget.blogEntity.uid));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.padding ?? 12,
        vertical: 7.5,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              context.read<EditBlogManager>().resetIndexes();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogReadView(
                    blogEntity: widget.blogEntity,
                  ),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 240,
                  child: widget.blogEntity.imageUrlList.isEmpty
                      ? const CustomImageError()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            useOldImageOnUrlChange: true,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black45
                                    : Colors.black12,
                            colorBlendMode: BlendMode.darken,
                            errorWidget: (context, url, error) {
                              return const CustomImageError();
                            },
                            progressIndicatorBuilder: (context, url, progress) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white12,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: progress.progress,
                                  ),
                                ),
                              );
                            },
                            imageUrl: widget.blogEntity.imageUrlList.first,
                          ),
                        ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.blogEntity.blogTitle,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayLarge!
                                  .copyWith(
                                fontSize: 20.5,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              widget.blogEntity.blogSubTitle,
                              style: AppTheme
                                  .darkThemeData.textTheme.displayMedium!
                                  .copyWith(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 15,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(.25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 8,
                          ),
                          child: Text(
                            //average reading speed of a human
                            "${(widget.blogEntity.blogContent.split(" ").length / 238).ceil()} min read",
                            style:
                                AppTheme.darkThemeData.textTheme.displaySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 11,
                  right: 11,
                  child: GestureDetector(
                    onTap: () {
                      context.read<FavsBloc>().add(
                            FavsAddToFavsEvent(
                              blogModel:
                                  BlogModel.fromBlogEntity(widget.blogEntity),
                            ),
                          );
                    },
                    child: widget.isInHome == true
                        ? Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: const Icon(
                              CupertinoIcons.heart,
                              size: 14.5,
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(
            height: 5,
          ),

          //the poster details

          Visibility(
            visible: widget.isInHome == true,
            child: ListTile(
              leading: GestureDetector(
                onTap: () {
                  if (widget.blogEntity.userEntity == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('User details not found'),
                      ),
                    );
                    return;
                  }
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppPallete.bottomSheetColor
                            : Colors.white,
                    constraints: BoxConstraints.expand(
                      height: MediaQuery.of(context).size.height * .4,
                    ),
                    builder: (context) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          CustomImageView(
                            width: 70,
                            height: 70,
                            radius: BorderRadius.circular(50),
                            fit: BoxFit.cover,
                            imagePath:
                                widget.blogEntity.userEntity?.profileImageUrl ??
                                    '',
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "${widget.blogEntity.userEntity?.firstname.capitalize()} ${widget.blogEntity.userEntity?.lastname.capitalize()}",
                            style: AppTheme
                                .darkThemeData.textTheme.displayLarge!
                                .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppPallete.primaryColor
                                  : AppPallete.primaryLightColor,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            widget.blogEntity.blogTitle,
                            style: AppTheme
                                .darkThemeData.textTheme.displayMedium!
                                .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppPallete.tabLabelUnselectedColor
                                  : AppPallete.grayDark,
                              height: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.blogEntity.date!,
                            style: AppTheme
                                .darkThemeData.textTheme.displayMedium!
                                .copyWith(
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppPallete.tabLabelUnselectedColor
                                  : AppPallete.grayDark,
                              height: 1,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              //to do
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 24,
                              ),
                              decoration: BoxDecoration(
                                color: AppPallete.deactivatedBackgroundColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SeeOthersBlogsView(
                                        blogList: (context
                                                .read<BlogBloc>()
                                                .state as BlogGetAllBlogSuccess)
                                            .blogList,
                                        user: widget.blogEntity.userEntity!,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "See more blogs by ${widget.blogEntity.userEntity!.firstname.capitalize()}",
                                  style: const TextStyle(
                                    color: AppPallete.grayLabel,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
                child: CustomImageView(
                  imagePath: widget.blogEntity.userEntity?.profileImageUrl,
                  fit: BoxFit.cover,
                  width: 44,
                  height: 43,
                  radius: BorderRadius.circular(50),
                ),
              ),
              title: Text(
                widget.blogEntity.userEntity != null
                    ? "${widget.blogEntity.userEntity!.firstname.capitalize()} ${widget.blogEntity.userEntity!.lastname.capitalize()}"
                    : 'Anonymous',
                style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                  fontSize: 17,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              subtitle: Text(
                widget.blogEntity.date!.isNotEmpty
                    ? widget.blogEntity.date.toString()
                    : 'Uploaded date not found',
                style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                  fontSize: 14,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white54
                      : Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
