import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/animation/loading_anim.json",
          height: 200,
          width: 200,
        ),
        const Text(
          "Fetching weather",
          style: TextStyle(
            fontSize: 24,
          ),
        )
      ],
    );
  }
}
