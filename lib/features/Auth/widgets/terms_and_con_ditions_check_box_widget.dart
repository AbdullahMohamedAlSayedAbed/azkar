import 'package:flutter/material.dart';

class TermsAndConDitionsCheckBoxWidget extends StatefulWidget {
  const TermsAndConDitionsCheckBoxWidget({super.key});

  @override
  State<TermsAndConDitionsCheckBoxWidget> createState() =>
      _TermsAndConDitionsCheckBoxWidgetState();
}

class _TermsAndConDitionsCheckBoxWidgetState
    extends State<TermsAndConDitionsCheckBoxWidget> {
  bool termsAndConditions = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: termsAndConditions,
      title: const Text('Accept Terms and Conditions'),
      onChanged: (value) {
        setState(() {
          termsAndConditions = value!;
        });
      },
    );
  }
}
