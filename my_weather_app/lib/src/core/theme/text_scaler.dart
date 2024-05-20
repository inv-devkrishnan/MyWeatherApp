import 'package:flutter/material.dart';

class UIScaler {
  Widget textScaler(context, child) {
    // Retrieve the MediaQueryData from the current context.
    final mediaQueryData = MediaQuery.of(context);

    // Calculate the scaled text factor using the clamp function to ensure it stays within a specified range.
    final scale = mediaQueryData.textScaler.clamp(
      minScaleFactor: 1.0, // Minimum scale factor allowed.
      maxScaleFactor: 1.0, // Maximum scale factor allowed.
    );

    // Create a new MediaQueryData with the updated text scaling factor.
    // This will override the existing text scaling factor in the MediaQuery.
    // This ensures that text within this subtree is scaled according to the calculated scale factor.
    return MediaQuery(
      // Copy the original MediaQueryData and replace the textScaler with the calculated scale.
      data: mediaQueryData.copyWith(
        textScaler: scale,
      ),
      // Pass the original child widget to maintain the widget hierarchy.
      child: child!,
    );
  }
}
