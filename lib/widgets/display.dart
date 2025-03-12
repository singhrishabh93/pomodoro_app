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
      duration: const Duration(milliseconds: 300),
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 100,
        fontWeight: isRunning ? FontWeight.bold : FontWeight.normal,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(formattedMinutes),
          const Text(':'),
          Text(formattedSeconds),
        ],
      ),
    );
  }
}