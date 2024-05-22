import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorMessage extends StatelessWidget {
  final String errorString;
  final VoidCallback callback;
  const ErrorMessage(
      {super.key, required this.errorString, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LottieBuilder.asset(
          "assets/animation/Animation - 1716378154737.json",
          height: 100,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            errorString,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:
                FilledButton(onPressed: callback, child: const Text("Retry")))
      ],
    );
  }
}
