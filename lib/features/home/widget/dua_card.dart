import 'package:flutter/material.dart';

class DuaCard extends StatefulWidget {
  final String text;
  final String? note;
  final int? initialRepeat;

  const DuaCard({
    super.key,
    required this.text,
    this.note,
    this.initialRepeat,
  });

  @override
  State<DuaCard> createState() => _DuaCardState();
}

class _DuaCardState extends State<DuaCard> {
  int? currentRepeat;

  @override
  void initState() {
    super.initState();
    currentRepeat = widget.initialRepeat;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (currentRepeat != null) {
          if (currentRepeat! > 0) {
            setState(() {
              currentRepeat = currentRepeat! - 1;
            });
          }
        }
      },
      splashColor: Colors.teal.shade100,
      splashFactory: InkRipple.splashFactory,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.shade300,
              blurRadius: 10,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.5,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              if (widget.note != null)
                Text(
                  widget.note!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.teal.shade700,
                  ),
                ),
              currentRepeat == null
                  ? const SizedBox()
                  : currentRepeat == 0
                      ? Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              "تم بحمد الله",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              currentRepeat.toString(),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade900,
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
