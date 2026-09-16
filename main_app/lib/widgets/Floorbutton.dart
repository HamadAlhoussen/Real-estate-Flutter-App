import 'package:flutter/material.dart';

class FloorButton extends StatelessWidget {
  final String label;
  final int selectedFloor;
  final TextEditingController controller;
  final ValueChanged<int> onChanged;

  const FloorButton({
    super.key,
    required this.label,
    required this.selectedFloor,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            onChanged: (val) {
              final parsed = int.tryParse(val);
              if (parsed != null && parsed >= 0 && parsed <= 163) {
                onChanged(parsed);
              }
            },
          ),
        ),
      ],
    );
  }
}
