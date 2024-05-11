import 'package:blog_app/core/lists/category_list.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/reduce_alpha.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_interests_wrapper.dart';
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
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
                hintText: 'Add blog title',
                hintStyle: AppTheme.darkThemeData.textTheme.headlineLarge,
                contentPadding: EdgeInsets.zero,
              ),
              style: AppTheme.darkThemeData.textTheme.headlineLarge,
              controller: editBlogManager.blogTitle,
              maxLines: null,
            ),
            const SizedBox(
              height: 15,
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

            const SizedBox(
              height: 15,
            ),

            //dropdown for selecting categories
            GestureDetector(
              onTap: () {
                addBlogCategories(editBlogManager);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add relevant categories for your blog',
                        style: AppTheme.darkThemeData.textTheme.displayMedium!
                            .copyWith(
                          color: AppPallete.grayLight,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        color: AppPallete.grayLight,
                        onPressed: () {
                          addBlogCategories(editBlogManager);
                        },
                      ),
                    ],
                  ),
                  if (editBlogManager.blogCategories.isNotEmpty)
                    BlogInterestWrapper(
                      list: editBlogManager.blogCategories,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void addBlogCategories(EditBlogManager editBlogManager) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppPallete.bottomSheetColor,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * .75,
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setBottomState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  Text(
                    'Select relevant categories',
                    style:
                        AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                      color: AppPallete.grayLabel,
                      fontSize: 19,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: CategoryList.blogCategories.length,
                      itemBuilder: (context, index) {
                        const list = CategoryList.blogCategories;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Chip(
                                  padding: const EdgeInsets.all(1),
                                  labelPadding:
                                      const EdgeInsets.symmetric(horizontal: 9),
                                  label: Text(
                                    CategoryList.blogCategories[index],
                                    style: AppTheme
                                        .darkThemeData.textTheme.displaySmall!
                                        .copyWith(
                                      color: CategoryList
                                          .categoryColors[list[index]],
                                      fontSize: 14,
                                    ),
                                  ),
                                  side: BorderSide.none,
                                  surfaceTintColor:
                                      ColorManipulation.reduceAlpha(
                                    CategoryList.categoryColors[list[index]]!,
                                  ),
                                  backgroundColor:
                                      ColorManipulation.reduceAlpha(
                                    CategoryList.categoryColors[list[index]]!,
                                  ),
                                ),
                                IconButton(
                                  icon: editBlogManager.blogCategories
                                          .contains(list[index])
                                      ? const Icon(
                                          Icons.radio_button_checked,
                                          color: AppPallete.primaryColor,
                                        )
                                      : const Icon(
                                          Icons.radio_button_unchecked,
                                        ),
                                  iconSize: 17,
                                  color: AppPallete.grayLabel,
                                  onPressed: () {
                                    setBottomState(
                                      () {
                                        editBlogManager.handleCategory(
                                          list[index],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                            const Divider(
                              thickness: .1,
                              color: AppPallete.deactivatedTextColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
