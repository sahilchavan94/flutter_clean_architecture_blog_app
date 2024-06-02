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
    return SafeArea(
      child: Consumer<EditBlogManager>(
        builder: (context, editBlogManager, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: editBlogManager.blogContent,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  helperStyle:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppPallete.grayLabel
                        : Colors.black87,
                    fontSize: 20,
                  ),
                  hintText:
                      'Blog content ( ex: today we are going to get an introduction on animation basics )',
                  hintStyle:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppPallete.grayLabel
                        : Colors.black87,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w100,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppPallete.grayLabel
                      : Colors.black87,
                  fontFamily: GoogleFonts.nunito().fontFamily,
                ),
                maxLines: null,
              ),
            ],
          );
        },
      ),
    );
  }
}
