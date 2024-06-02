import 'dart:io';

import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ImageContainer extends StatefulWidget {
  final double width;
  final double height;
  final Function? selectPhoto;
  final Function? removePhoto;
  final File? currentImage;
  const ImageContainer({
    super.key,
    required this.width,
    required this.height,
    this.selectPhoto,
    this.removePhoto,
    this.currentImage,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.selectPhoto != null) {
          widget.selectPhoto!();
        }
      },
      child: widget.currentImage != null
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    widget.currentImage!,
                    width: widget.width,
                    height: widget.height,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: -18,
                  top: -20,
                  child: IconButton(
                    onPressed: () {
                      if (widget.removePhoto != null) {
                        widget.removePhoto!();
                      }
                    },
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : DottedBorder(
              color: AppPallete.grayDark,
              borderType: BorderType.RRect,
              radius: const Radius.circular(12),
              dashPattern: const [6, 6],
              strokeWidth: 1.4,
              child: SizedBox(
                height: widget.height,
                width: widget.width,
                child: const Icon(Icons.photo),
              ),
            ),
    );
  }
}
