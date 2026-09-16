import 'package:flutter/material.dart';

class GlowingCircle extends StatelessWidget {
  final double diameter;
  final Color color;

  const GlowingCircle({super.key, required this.diameter, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.0)],
          stops: const [0.2, 1.0],
        ),
      ),
    );
  }
}
