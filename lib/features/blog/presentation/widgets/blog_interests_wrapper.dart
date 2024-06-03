import 'package:blog_app/core/lists/category_list.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/reduce_alpha.dart';
import 'package:flutter/material.dart';

class BlogInterestWrapper extends StatelessWidget {
  final List list;
  const BlogInterestWrapper({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 7,
      runSpacing: -6,
      runAlignment: WrapAlignment.start,
      children: List.generate(
        list.length,
        (index) => Chip(
          padding: const EdgeInsets.all(1),
          labelPadding: const EdgeInsets.symmetric(horizontal: 8),
          label: Text(
            list[index],
            style: AppTheme.darkThemeData.textTheme.displaySmall!.copyWith(
              color: CategoryList
                  .categoryColors[CategoryList.blogCategories[index]],
              fontSize: 13,
            ),
          ),
          side: BorderSide.none,
          surfaceTintColor: ColorManipulation.reduceAlpha(
            CategoryList.categoryColors[CategoryList.blogCategories[index]]!,
            Theme.of(context).brightness == Brightness.dark ? 230 : 190,
          ),
          backgroundColor: ColorManipulation.reduceAlpha(
            CategoryList.categoryColors[CategoryList.blogCategories[index]]!,
            Theme.of(context).brightness == Brightness.dark ? 230 : 190,
          ),
        ),
      ),
    );
  }
}
