import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;
  const CustomErrorWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_outlined,
            size: 50,
            color: AppPallete.errorColor,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            message == null ? 'Something went wrong' : message!,
            style: AppTheme.darkThemeData.textTheme.displayLarge!.copyWith(
              fontSize: 17,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
