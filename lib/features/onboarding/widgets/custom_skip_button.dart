import 'package:flutter/material.dart';

class CustomSkipButton extends StatelessWidget {
  const CustomSkipButton({
    super.key,
    this.onPressed,
  });
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(128),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      child: TextButton(
        onPressed: onPressed,
        child: const Text(
          "تخطي",
          style: TextStyle(
              fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
