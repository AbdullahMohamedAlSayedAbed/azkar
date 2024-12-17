import 'package:flutter/material.dart';

class CounterViewBody extends StatefulWidget {
  const CounterViewBody({super.key});

  @override
  State<CounterViewBody> createState() => _CounterViewBodyState();
}

class _CounterViewBodyState extends State<CounterViewBody> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Spacer(flex: 4),
          InkWell(
            onTap: () {
              setState(() {
                counter++;
              });
            },
            child: Text(
              counter.toString(),
              style: const TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
          ),
          const Spacer(flex: 4),
          IconButton(
              onPressed: () {
                setState(() {
                  counter = 0;
                });
              },
              icon: const Icon(Icons.refresh, size: 60, color: Colors.teal)),
          const Spacer(flex: 1,),
        ],
      ),
    );
  }
}
