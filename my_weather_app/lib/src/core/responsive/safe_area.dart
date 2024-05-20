/// widget to  create a safeArea whoose height and width can be accessed
library;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// widget that helps us to get the size (width, height) of the safe area to make app more responsive
typedef ResponsiveBuilder = Widget Function(BuildContext context, Size size);

class ResponsiveSafeArea extends StatelessWidget {
  final ResponsiveBuilder builder;
  const ResponsiveSafeArea({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) =>
            builder(context, constraints.biggest),
      ),
    );
  }
}
