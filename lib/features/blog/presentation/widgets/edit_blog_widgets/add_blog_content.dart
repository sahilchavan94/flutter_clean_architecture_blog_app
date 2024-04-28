import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddBlogContentWidget extends StatefulWidget {
  const AddBlogContentWidget({super.key});

  @override
  State<AddBlogContentWidget> createState() => _AddBlogContentWidgetState();
}

class _AddBlogContentWidgetState extends State<AddBlogContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditBlogManager>(
      builder: (context, editBlogManager, child) {
        return Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: editBlogManager.blogSubHeading,
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
                hintText: 'Add a sub heading',
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppPallete.grayLabel,
                fontSize: 18,
              ),
              maxLines: null,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: editBlogManager.blogContent,
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
                hintText:
                    'Blog content ( ex: today we are going to get an introduction on animation basics )',
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w100,
                color: AppPallete.grayLabel,
                fontFamily: GoogleFonts.nunito().fontFamily,
              ),
              maxLines: null,
            ),
          ],
        );
      },
    );
  }
}
