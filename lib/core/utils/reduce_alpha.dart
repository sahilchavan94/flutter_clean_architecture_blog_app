// Function to reduce alpha value dynamically
import 'dart:ui';

class ColorManipulation {
  static Color reduceAlpha(Color color) {
    int alpha = color.alpha - 230;
    if (alpha < 0) {
      alpha = 0;
    }
    return Color.fromARGB(alpha, color.red, color.green, color.blue);
  }
}
