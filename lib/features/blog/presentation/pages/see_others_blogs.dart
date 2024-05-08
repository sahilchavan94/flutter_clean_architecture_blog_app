import 'package:blog_app/core/common/widgets/custom_blog_widget.dart';
import 'package:blog_app/core/common/widgets/custom_error_widget.dart';
import 'package:blog_app/features/blog/domain/entities/blog_entity.dart';
import 'package:blog_app/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class SeeOthersBlogsView extends StatelessWidget {
  final List<BlogEntity> blogList;
  final String posterId;
  const SeeOthersBlogsView(
      {super.key, required this.blogList, required this.posterId});

  @override
  Widget build(BuildContext context) {
    final blogs = blogList.filter((t) => t.posterId == posterId).toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'More by ${blogList.first.userEntity!.firstname.capitalize()}',
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: blogs.isEmpty,
            child: const CustomErrorWidget(
              message: 'No more blogs',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return CustomBlogWidget(
                  blogEntity: blog,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
