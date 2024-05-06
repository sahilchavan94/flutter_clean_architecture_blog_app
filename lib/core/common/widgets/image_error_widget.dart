import 'package:flutter/material.dart';

class CustomImageError extends StatelessWidget {
  const CustomImageError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.image,
      ),
    );
  }
}
