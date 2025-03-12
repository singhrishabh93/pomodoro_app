// lib/widgets/display.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Display extends StatelessWidget {
  const Display({
    Key? key,
    required this.minutes,
    required this.seconds,
    required this.isRunning,
  }) : super(key: key);

  final int minutes;
  final int seconds;
  final bool isRunning;

  @override
Widget build(BuildContext context) {
  final formattedMinutes = NumberFormat('00').format(minutes);
  final formattedSeconds = NumberFormat('00').format(seconds);

  return AnimatedDefaultTextStyle(
    duration: const Duration(milliseconds: 200),
    style: TextStyle(
      fontFamily: 'Roboto',
      fontWeight: isRunning ? FontWeight.bold : FontWeight.normal,
      color: Theme.of(context).colorScheme.primary,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedMinutes, 
          style: const TextStyle(fontSize: 150, height: 0.9),
        ),
        Text(
          formattedSeconds, 
          style: const TextStyle(fontSize: 150, height: 0.9),
        ),
      ],
    ),
  );
}
}
