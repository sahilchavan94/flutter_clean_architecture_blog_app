import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/common/widgets/image_error_widget.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/blog/presentation/blocs/poster/bloc/poster_bloc.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_read_view.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBlogWidget extends StatefulWidget {
  final BlogEntity blogEntity;
  const CustomBlogWidget({
    super.key,
    required this.blogEntity,
  });

  @override
  State<CustomBlogWidget> createState() => _CustomBlogWidgetState();
}

class _CustomBlogWidgetState extends State<CustomBlogWidget> {
  @override
  void initState() {
    context.read<PosterBloc>().add(
          PosterFetchPosterDataEvent(
            posterId: widget.blogEntity.posterId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(blogEntity.blogContent);
    return BlocBuilder<PosterBloc, PosterState>(
      builder: (context, state) {
        if (state is PosterDataLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PosterDataFailure) {
          return CustomErrorWidget(
            message: state.message,
          );
        }
        if (state is PosterDataSuccess) {
          final posterData = state.poster;
          return ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Padding(
              padding: const EdgeInsets.all(12),
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
                            posterData: posterData,
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
                                    color: Colors.black45,
                                    colorBlendMode: BlendMode.darken,
                                    errorWidget: (context, url, error) {
                                      return const CustomImageError();
                                    },
                                    progressIndicatorBuilder:
                                        (context, url, progress) {
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
                                    imageUrl:
                                        widget.blogEntity.imageUrlList.first,
                                  ),
                                ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 20,
                          ),
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
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              )
                            ],
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                            child: const Icon(
                              CupertinoIcons.heart,
                              size: 16.5,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  //the posted details

                  ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        if (posterData.firstname.isEmpty) {
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
                          backgroundColor: AppPallete.bottomSheetColor,
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
                                  imagePath: posterData.profileImageUrl,
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "${posterData.firstname.capitalize()} ${posterData.lastname.capitalize()}",
                                  style: AppTheme
                                      .darkThemeData.textTheme.displayLarge!
                                      .copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w400,
                                    color: AppPallete.grayLabel,
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
                                    color: AppPallete.tabLabelUnselectedColor,
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
                                    color: AppPallete.tabLabelUnselectedColor,
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
                                      vertical: 10,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          AppPallete.deactivatedBackgroundColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      "See more blogs by ${widget.blogEntity.posterName.split(" ")[0].capitalize()}",
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: CustomImageView(
                        imagePath: posterData.profileImageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        radius: BorderRadius.circular(50),
                      ),
                    ),
                    title: Text(
                      posterData.firstname.isNotEmpty
                          ? "${posterData.firstname.capitalize()} ${posterData.lastname.capitalize()}"
                          : 'Anonymous',
                      style: AppTheme.darkThemeData.textTheme.displayMedium!
                          .copyWith(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      widget.blogEntity.date!.isNotEmpty
                          ? widget.blogEntity.date.toString()
                          : 'Uploaded date not found',
                      style: AppTheme.darkThemeData.textTheme.displayMedium!
                          .copyWith(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
