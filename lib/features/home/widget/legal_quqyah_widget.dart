import 'package:flutter/material.dart';

class LegalQuqyahWidget extends StatelessWidget {
  const LegalQuqyahWidget(
      {super.key,
      required this.category,
      required this.reference,
      required this.zekr});
  final String category, reference, zekr;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.shade100,
                blurRadius: 10,
                offset: const Offset(4, 4),
              ),
            ]),
        child: Column(
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 18,
                height: 1.5,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              zekr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.teal.shade700,
              ),
            ),
            if (reference.isNotEmpty)
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'المصدر: $reference',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade900,
                    ),
                  ),
                ],
              ),
          ],
        ));
  }
}
