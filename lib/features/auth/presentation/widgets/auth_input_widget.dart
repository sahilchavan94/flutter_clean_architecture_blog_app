import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthInputWidget extends StatefulWidget {
  final double? width;
  final String labelText;
  final String hintText;
  final Icon? suffixIcon;
  final bool? obscureText;
  final Function? onPressed;
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
    this.width,
    this.onPressed,
  });

  @override
  State<AuthInputWidget> createState() => _AuthInputWidgetState();
}

class _AuthInputWidgetState extends State<AuthInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      width: widget.width ?? MediaQuery.of(context).size.width * 90,
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
            style: AppTheme.darkThemeData.textTheme.displayMedium!.copyWith(
              color: AppPallete.inputTextColor,
              fontSize: 15,
            ),
            validator: (val) {
              final validationResult = widget.validator(val);
              return validationResult;
            },
            cursorColor: Colors.white,
            cursorWidth: .5,
            cursorErrorColor: Colors.white,
            controller: widget.textEditingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: widget.obscureText!,
            obscuringCharacter: '•',
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              helperText: '',
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
                      onPressed: () {
                        if (widget.onPressed != null) {
                          widget.onPressed!();
                        }
                      },
                      icon: widget.onPressed != null
                          ? widget.obscureText == true
                              ? const Icon(CupertinoIcons.lock_fill)
                              : const Icon(CupertinoIcons.lock_open_fill)
                          : widget.suffixIcon!,
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
