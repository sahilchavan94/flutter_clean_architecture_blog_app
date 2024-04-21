import 'dart:io';

import 'package:blog_app/core/common/cubits/cubit/current_user_cubit.dart';
import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/profile/presentation/bloc/profile_bloc.dart';
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
              children: [
                state.runtimeType == ProfileLoading
                    ? Container(
                        decoration: BoxDecoration(
                          color: AppPallete.bottomSheetColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: 100,
                        height: 100,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppPallete.deactivatedBackgroundColor,
                          ),
                        ),
                      )
                    : CustomImageView(
                        width: 100,
                        height: 100,
                        radius: BorderRadius.circular(50),
                        fit: BoxFit.cover,
                        imagePath: currentUserData.userEntity.profileImageUrl,
                      ),
                Positioned(
                  bottom: -10,
                  right: 2,
                  child: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        showDragHandle: true,
                        backgroundColor: AppPallete.bottomSheetColor,
                        constraints: BoxConstraints.expand(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Text(
                                  'Upload profile photo',
                                  style: AppTheme
                                      .darkThemeData.textTheme.displayLarge!
                                      .copyWith(
                                    color: AppPallete.grayLabel,
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
                                    selectImage(
                                      ImageSource.gallery,
                                      currentUserData.userEntity.uid,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        CupertinoIcons.photo_fill,
                                        color: AppPallete.grayLabel,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Gallery',
                                        style: AppTheme.darkThemeData.textTheme
                                            .displayLarge!
                                            .copyWith(
                                          color: AppPallete.grayLabel,
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
                                    selectImage(
                                      ImageSource.camera,
                                      currentUserData.userEntity.uid,
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.camera_alt,
                                        color: AppPallete.grayLabel,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Camera',
                                        style: AppTheme.darkThemeData.textTheme
                                            .displayLarge!
                                            .copyWith(
                                          color: AppPallete.grayLabel,
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
                    },
                    icon: const Icon(Icons.camera_alt),
                    iconSize: 25,
                  ),
                )
              ],
            ),

            //username and the email
            const SizedBox(
              height: 5,
            ),
            Text(
              '${currentUserData.userEntity.firstname} ${currentUserData.userEntity.lastname}',
              style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: AppPallete.grayLabel,
              ),
            ),
            Text(
              currentUserData.userEntity.email,
              style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppPallete.tabLabelUnselectedColor,
                height: 1,
              ),
            )
          ],
        );
      },
    );
  }
}
