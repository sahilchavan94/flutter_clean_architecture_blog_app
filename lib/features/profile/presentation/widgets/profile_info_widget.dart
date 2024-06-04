import 'dart:io';

import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/core/utils/show_bottom_sheet_to_pick_image.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:blog_app/features/profile/presentation/pages/profile_image_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInfoWidget extends StatefulWidget {
  const ProfileInfoWidget({super.key});

  @override
  State<ProfileInfoWidget> createState() => _ProfileInfoWidgetState();
}

class _ProfileInfoWidgetState extends State<ProfileInfoWidget> {
  File? imageFile;

  void selectImage(ImageSource imageSource, String imagePath) async {
    final pickedImage = await PickImage.pickImage(imageSource);
    if (pickedImage != null) {
      imageFile = pickedImage;
    }
    if (imageFile != null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes will be made'),
        ),
      );
      context.read<ProfileBloc>().add(
            ProfilePictureUpload(
              imageFile: imageFile!,
              imagePath: imagePath,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserData =
        context.read<CurrentUserCubit>().state as CurrentUserDataFetched;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture not updated'),
            ),
          );
        }
        if (state is ProfileSuccess) {
          context.read<AuthBloc>().add(AuthIsUserLoggedIn());
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile picture updated'),
            ),
          );
        }
      },
      builder: (BuildContext context, ProfileState state) {
        return Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                state.runtimeType == ProfileLoading
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppPallete.bottomSheetColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 90,
                        height: 90,
                        child: Center(
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(50),
                            minHeight: double.maxFinite,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.black12
                                    : Colors.grey.shade200,
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey.shade900
                                    : Colors.grey.shade100,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          if (currentUserData
                              .userEntity.profileImageUrl.isEmpty) {
                            return;
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileImageView(
                                imageUrl:
                                    currentUserData.userEntity.profileImageUrl,
                                callback: () {
                                  showBottomSheetToPickImage(
                                    context,
                                    () {
                                      selectImage(
                                        ImageSource.gallery,
                                        currentUserData.userEntity.uid,
                                      );
                                    },
                                    () {
                                      selectImage(
                                        ImageSource.camera,
                                        currentUserData.userEntity.uid,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                        child: CustomImageView(
                          width: 100,
                          height: 100,
                          radius: BorderRadius.circular(50),
                          fit: BoxFit.cover,
                          imagePath: currentUserData.userEntity.profileImageUrl,
                        ),
                      ),
                Positioned(
                  bottom: -18,
                  right: -3,
                  child: IconButton(
                    onPressed: () {
                      showBottomSheetToPickImage(
                        context,
                        () {
                          selectImage(
                            ImageSource.gallery,
                            currentUserData.userEntity.uid,
                          );
                        },
                        () {
                          selectImage(
                            ImageSource.camera,
                            currentUserData.userEntity.uid,
                          );
                        },
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.camera_fill,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppPallete.grayLabel
                          : AppPallete.grayDark,
                    ),
                    iconSize: 20,
                  ),
                )
              ],
            ),

            //username and the email
            const SizedBox(
              height: 5,
            ),
            Text(
              '${currentUserData.userEntity.firstname.capitalize()} ${currentUserData.userEntity.lastname.capitalize()}',
              style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppPallete.grayLabel
                    : AppPallete.grayDark,
              ),
            ),
            Text(
              currentUserData.userEntity.email,
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppPallete.tabLabelUnselectedColor
                    : AppPallete.grayLight,
                height: 1,
              ),
            ),

            //show the uploaded blogs and other data
            // const SizedBox(
            //   height: 35,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Blogs 27",
            //       style:
            //           AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
            //         fontWeight: FontWeight.w400,
            //         color: AppPallete.tabLabelUnselectedColor,
            //         height: 1,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 30,
            //     ),
            //     Container(
            //       height: 20,
            //       width: 1,
            //       color: AppPallete.tabLabelUnselectedColor,
            //     ),
            //     const SizedBox(
            //       width: 30,
            //     ),
            //     Text(
            //       "Likes 102",
            //       style:
            //           AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
            //         fontWeight: FontWeight.w400,
            //         color: AppPallete.tabLabelUnselectedColor,
            //         height: 1,
            //       ),
            //     ),
            //   ],
            // )
          ],
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
