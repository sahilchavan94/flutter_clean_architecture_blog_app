import 'dart:io';

import 'package:blog_app/features/blog/presentation/widgets/edit_blog_widgets/add_blog_images_widget.dart';
import 'package:blog_app/features/blog/presentation/widgets/edit_blog_widgets/add_blog_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditBlog extends StatefulWidget {
  const EditBlog({super.key});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  late List<File?> blogImageList;

  @override
  void initState() {
    blogImageList = List.filled(3, null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddBlogImagesWidget(),
            AddBlogInfoWidget(),
          ],
        ),
      ),
    );
  }
}
