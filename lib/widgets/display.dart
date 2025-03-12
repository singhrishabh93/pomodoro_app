// lib/widgets/display.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      style: GoogleFonts.outfit(
        fontWeight: isRunning ? FontWeight.bold : FontWeight.normal,
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formattedMinutes,
            style: GoogleFonts.outfit(
              fontSize: 180,
              height: 0.9,
              fontWeight: isRunning ? FontWeight.bold : FontWeight.normal,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            formattedSeconds,
            style:  GoogleFonts.roboto(
              fontSize: 180,
              height: 0.9,
              fontWeight: isRunning ? FontWeight.bold : FontWeight.normal,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
