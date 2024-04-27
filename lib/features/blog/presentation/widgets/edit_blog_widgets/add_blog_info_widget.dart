import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBlogInfoWidget extends StatefulWidget {
  const AddBlogInfoWidget({super.key});

  @override
  State<AddBlogInfoWidget> createState() => _AddBlogInfoWidgetState();
}

class _AddBlogInfoWidgetState extends State<AddBlogInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditBlogManager>(
      builder: (BuildContext context, editBlogManager, Widget? child) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Add blog title',
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppPallete.grayLabel,
              ),
              controller: editBlogManager.blogTitle,
              maxLines: null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: 'Add a suitable subtitle',
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppPallete.grayLabel,
                fontSize: 20,
              ),
              controller: editBlogManager.blogSubTitle,
              maxLines: null,
            ),
          ],
        );
      },
    );
  }
}
