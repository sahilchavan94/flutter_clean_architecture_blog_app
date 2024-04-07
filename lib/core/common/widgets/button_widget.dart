import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final bool isLoading;
  final bool isActive;

  const ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
    required this.isActive,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (isActive) {
          await onPressed();
          return;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.5),
          width: double.infinity,
          decoration: BoxDecoration(
            color: isLoading == true
                ? AppPallete.deactivatedBackgroundColor
                : isActive
                    ? Colors.white
                    : AppPallete.deactivatedBackgroundColor,
          ),
          child: isLoading
              ? const Center(
                  heightFactor: .65,
                  child: CircularProgressIndicator(
                    color: AppPallete.primaryColor,
                  ),
                )
              : Text(
                  textAlign: TextAlign.center,
                  buttonText,
                  style:
                      AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                    color: isActive
                        ? AppPallete.scaffoldBackGroundColor
                        : AppPallete.deactivatedTextColor,
                    fontWeight: !isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}
