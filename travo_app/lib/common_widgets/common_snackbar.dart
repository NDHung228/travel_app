import 'package:flutter/material.dart';

class CommonSnackBar extends StatelessWidget {
  final String text;
  const CommonSnackBar({Key? key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      action: SnackBarAction(
        label: 'Action',
        onPressed: () {
          // Code to execute.
        },
      ),
      content: Text(text),
      duration: const Duration(milliseconds: 1500),
      width: 280.0, // Width of the SnackBar.
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
