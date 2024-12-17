import 'package:azkar/constants.dart';
import 'package:flutter/material.dart';

class CustomDotIndicator extends StatefulWidget {
  final bool isActive;

  const CustomDotIndicator({super.key, required this.isActive});

  @override
  State<CustomDotIndicator> createState() => _CustomDotIndicatorState();
}

class _CustomDotIndicatorState extends State<CustomDotIndicator> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      margin: const EdgeInsets.only(right: 10),
      height: 10,
      width: widget.isActive ? 30 : 10,
      decoration: BoxDecoration(
        color: widget.isActive ? primaryColor : const Color(0xFFC4C4C4),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
