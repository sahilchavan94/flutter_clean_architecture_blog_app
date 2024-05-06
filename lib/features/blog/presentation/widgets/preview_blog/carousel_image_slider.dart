import 'package:blog_app/core/common/widgets/image_error_widget.dart';
import 'package:blog_app/features/blog/presentation/managers/edit_blog_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarouselImageSlider extends StatelessWidget {
  final List imageList;
  final bool? isComingFromNetwork;
  const CarouselImageSlider({
    super.key,
    required this.imageList,
    this.isComingFromNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: imageList.map((file) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * .5,
          width: MediaQuery.of(context).size.width,
          child: file == null
              ? const Center(
                  child: Icon(Icons.add_a_photo),
                )
              : isComingFromNetwork != null && isComingFromNetwork!
                  ? CachedNetworkImage(
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      color: Colors.black45,
                      colorBlendMode: BlendMode.darken,
                      errorWidget: (context, url, error) {
                        return const CustomImageError();
                      },
                      progressIndicatorBuilder: (context, url, progress) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white12,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        );
                      },
                      imageUrl: file,
                    )
                  : Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
        );
      }).toList(),
      options: CarouselOptions(
        scrollPhysics:
            imageList.length == 1 ? const NeverScrollableScrollPhysics() : null,
        height: MediaQuery.of(context).size.height * .6,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          if (isComingFromNetwork != null && isComingFromNetwork!) {
            context.read<EditBlogManager>().handleCurrentBlogIndex(index);
            return;
          }
          context.read<EditBlogManager>().handleCurrentIndex(index);
        },
      ),
    );
  }
}
