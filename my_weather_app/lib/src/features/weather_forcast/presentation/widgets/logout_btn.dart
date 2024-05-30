import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/src/core/auth/authentication.dart';
import 'package:my_weather_app/src/core/routing/app_router.gr.dart';
import 'package:my_weather_app/src/core/theme/app_colors.dart';

class LogoutBtn extends StatelessWidget {
  const LogoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: AppColors.primaryTransColor,
      ),
      icon: const Icon(
        Icons.logout_rounded,
        color: Colors.white,
      ),
      onPressed: () async {
        showLogoutConfirmationDialog(context);
      },
    );
  }

  Future<void> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.primaryColor,
          title: const Text('Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to log out?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                await Authentication(FirebaseAuth.instance).logOut();
                context.mounted
                    ? AutoRouter.of(context).replaceAll([const LoginRoute()])
                    : debugPrint("context wasn't mounted");
              },
            ),
          ],
        );
      },
    );
  }
}
