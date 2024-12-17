import 'package:flutter/material.dart';

class AgeSliderWidget extends StatefulWidget {
  const AgeSliderWidget({super.key, required this.onAgeChanged});
  final ValueChanged<double> onAgeChanged;
  @override
  State<AgeSliderWidget> createState() => _AgeSliderWidgetState();
}

class _AgeSliderWidgetState extends State<AgeSliderWidget> {
  double age = 18.0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Age:  ${age.round()}'),
        Expanded(
          child: Slider(
            value: age,
            min: 18,
            divisions: 80,
            max: 100,
            label: age.round().toString(),
            onChanged: (value) {
              setState(() {
                age = value;
              });
              widget.onAgeChanged(age);
            },
          ),
        ),
      ],
    );
  }
}
