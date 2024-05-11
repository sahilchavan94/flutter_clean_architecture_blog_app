import 'dart:developer';

import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/features/blog/presentation/blocs/fav_blogs/fav_blogs_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBlogs extends StatefulWidget {
  const FavouriteBlogs({super.key});

  @override
  State<FavouriteBlogs> createState() => _FavouriteBlogsState();
}

class _FavouriteBlogsState extends State<FavouriteBlogs> {
  @override
  void initState() {
    context.read<FavBlogsBloc>().add(FavBlogsGetAllFavsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavBlogsBloc, FavBlogsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FavBlogsGetFavsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FavBlogsGetFavsFailure) {
          return const CustomErrorWidget(
            message: "No favourites found",
          );
        }

        if (state is FavBlogsGetFavsSuccess) {
          final blogList = state.blogList;
          return ScrollConfiguration(
            behavior: const CupertinoScrollBehavior(),
            child: ListView.builder(
              itemCount: blogList.length,
              itemBuilder: (context, index) {
                log("message is ${blogList[index].userEntity}");
                return CustomBlogWidget(
                  blogEntity: blogList[index],
                  isInHome: false,
                );
              },
            ),
          );
        }

        return const CustomErrorWidget(
          message: "Something went wrong",
        );
      },
    );
  }
}
