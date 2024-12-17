import 'package:flutter/material.dart';

class CardHomeWidget extends StatelessWidget {
  const CardHomeWidget({
    super.key,
    required this.items,
  });

  final Map<String, dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            items['icon'],
            size: 48,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 8),
          Text(
            items['title'],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
