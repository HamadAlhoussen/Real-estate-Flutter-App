import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final String label;
  final List options;
  final Function(String) onSelected;

  const FilterButton({
    super.key,
    required this.label,
    required this.options,
    required this.onSelected,
  });

  @override
  State createState() => FilterButtonState();
}

class FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: Colors.black87,
          value: widget.options.contains(widget.label) ? widget.label : null,
          hint: Text(widget.label, style: const TextStyle(color: Colors.white)),
          items: widget.options
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(color: Colors.white)),
                ),
              )
              .toList(),
          onChanged: (val) {
            widget.onSelected(val!.toString());
          },
        ),
      ),
    );
  }
}
