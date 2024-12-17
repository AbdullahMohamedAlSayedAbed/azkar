import 'package:flutter/material.dart';

class NotificationsSwitchWidget extends StatefulWidget {
  const NotificationsSwitchWidget({
    super.key,
  });

  @override
  State<NotificationsSwitchWidget> createState() =>
      _NotificationsSwitchWidgetState();
}

class _NotificationsSwitchWidgetState extends State<NotificationsSwitchWidget> {
  bool notifications = false;
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: notifications,
      onChanged: (value) {
        setState(() {
          notifications = value;
        });
      },
      title: const Text('Receive Notifications'),
    );
  }
}
