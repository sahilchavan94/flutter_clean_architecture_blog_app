import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showBottomSheetToPickImage(
    BuildContext context, Function onClick1, Function onClick2) {
  {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? AppPallete.bottomSheetColor
          : Colors.white,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * .285,
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(
                'Upload profile photo',
                style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppPallete.grayLabel
                      : Colors.black87,
                  fontSize: 19,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onClick1();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.photo_fill,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppPallete.grayLabel
                          : Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Gallery',
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppPallete.grayLabel
                            : Colors.black87,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  onClick2();
                },
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppPallete.grayLabel
                          : Colors.black87,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Camera',
                      style: AppTheme.darkThemeData.textTheme.displayLarge!
                          .copyWith(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppPallete.grayLabel
                            : Colors.black87,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
