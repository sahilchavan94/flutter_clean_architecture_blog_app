import 'package:blog_app/core/utils/show_bottom_sheet_to_pick_image.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:blog_app/features/blog/presentation/widgets/image_container.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddBlogImagesWidget extends StatefulWidget {
  const AddBlogImagesWidget({super.key});

  @override
  State<AddBlogImagesWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddBlogImagesWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditBlogManager>(
      builder: (BuildContext context, EditBlogManager editBlogManager,
          Widget? child) {
        return Column(
          children: [
            //adding the image section
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageContainer(
                  currentImage: editBlogManager.blogImageList.first,
                  selectPhoto: () {
                    showBottomSheetToPickImage(
                      context,
                      () {
                        editBlogManager.addImageToBlogImageList(
                          ImageSource.gallery,
                          0,
                        );
                      },
                      () {
                        editBlogManager.addImageToBlogImageList(
                          ImageSource.camera,
                          0,
                        );
                      },
                    );
                  },
                  removePhoto: () {
                    editBlogManager.removeImageFromBlogImageList(0);
                  },
                  width: MediaQuery.of(context).size.width * .48,
                  height: MediaQuery.of(context).size.height * .38,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    ImageContainer(
                      currentImage: editBlogManager.blogImageList[1],
                      selectPhoto: () {
                        showBottomSheetToPickImage(
                          context,
                          () {
                            editBlogManager.addImageToBlogImageList(
                              ImageSource.gallery,
                              1,
                            );
                          },
                          () {
                            editBlogManager.addImageToBlogImageList(
                              ImageSource.camera,
                              1,
                            );
                          },
                        );
                      },
                      removePhoto: () {
                        editBlogManager.removeImageFromBlogImageList(1);
                      },
                      width: MediaQuery.of(context).size.width * .4,
                      height: MediaQuery.of(context).size.height * .18,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ImageContainer(
                      currentImage: editBlogManager.blogImageList.last,
                      selectPhoto: () {
                        showBottomSheetToPickImage(
                          context,
                          () {
                            editBlogManager.addImageToBlogImageList(
                              ImageSource.gallery,
                              2,
                            );
                          },
                          () {
                            editBlogManager.addImageToBlogImageList(
                              ImageSource.camera,
                              2,
                            );
                          },
                        );
                      },
                      removePhoto: () {
                        editBlogManager.removeImageFromBlogImageList(2);
                      },
                      width: MediaQuery.of(context).size.width * .4,
                      height: MediaQuery.of(context).size.height * .18,
                    ),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
