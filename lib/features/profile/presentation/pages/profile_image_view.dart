import 'package:blog_app/core/common/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';

class ProfileImageView extends StatefulWidget {
  final String imageUrl;
  final Function callback;
  const ProfileImageView(
      {super.key, required this.imageUrl, required this.callback});

  @override
  State<ProfileImageView> createState() => _ProfileImageViewState();
}

class _ProfileImageViewState extends State<ProfileImageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile Image',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                widget.callback();
              },
              child: const Icon(
                Icons.edit,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: CustomImageView(
          imagePath: widget.imageUrl,
          height: MediaQuery.of(context).size.height * .575,
          width: double.maxFinite,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
