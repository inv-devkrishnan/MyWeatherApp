import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';

class BottomCardSheet extends ConsumerStatefulWidget {
  final Size size;
  const BottomCardSheet(this.size, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomCardSheetState();
}

class _BottomCardSheetState extends ConsumerState<BottomCardSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height,
      width: widget.size.width,
      color: Colors.transparent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: widget.size.width,
              child: const AutoSizeText(
                "Favorites",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                context.maybePop();
                AutoRouter.of(context).push(const SetLocationRoute());
              },
              child: const Text("Choose other locations"))
        ],
      ),
    );
  }
}
