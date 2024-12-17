import 'package:flutter/material.dart';

class DropDownStatus extends StatefulWidget {
  const DropDownStatus({
    super.key,
    required this.onAgeChanged,
  });
  final ValueChanged<String> onAgeChanged;

  @override
  State<DropDownStatus> createState() => _DropDownStatusState();
}

class _DropDownStatusState extends State<DropDownStatus> {
  final List<String> status = ['Single', 'Married', 'Divorced'];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
          labelText: 'Status',
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          )),
      items: status.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          widget.onAgeChanged(value.toString());
        });
      },
    );
  }
}
