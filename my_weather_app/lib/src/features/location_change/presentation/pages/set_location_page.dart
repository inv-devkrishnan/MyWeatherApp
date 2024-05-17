import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
@RoutePage()
class SetLocationPage extends StatelessWidget {
  const SetLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Text("Set Location Page")),
    );
  }
}