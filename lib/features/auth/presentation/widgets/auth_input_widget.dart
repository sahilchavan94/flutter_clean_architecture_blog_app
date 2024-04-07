import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthInputWidget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final Icon? suffixIcon;
  final bool? obscureText;
  final Function validator;
  final TextEditingController textEditingController;

  const AuthInputWidget({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.textEditingController,
    this.suffixIcon,
    this.obscureText = false,
    required this.validator,
  });

  @override
  State<AuthInputWidget> createState() => _AuthInputWidgetState();
}

class _AuthInputWidgetState extends State<AuthInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
              color: AppPallete.grayLabel,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (val) {
              final validationResult = widget.validator(val);
              return validationResult;
            },
            controller: widget.textEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: widget.obscureText!,
            obscuringCharacter: '•',
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              prefix: const Padding(
                padding: EdgeInsets.only(
                  left: 20,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppPallete.grayDark,
                ),
              ),
              suffixIcon: widget.suffixIcon != null
                  ? IconButton(
                      onPressed: () {},
                      icon: widget.suffixIcon!,
                      iconSize: 18,
                    )
                  : null,
              suffixIconColor: AppPallete.grayLight,
              hintText: widget.hintText,
              hintStyle:
                  AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
                color: AppPallete.grayLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
