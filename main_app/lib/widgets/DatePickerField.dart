import 'package:flutter/material.dart';

class DatePickerField extends StatefulWidget {
  final Function(DateTime)? onDateSelected;
  final String hintt;
  final DateTime? initialDate;

  const DatePickerField({
    super.key,
    this.onDateSelected,
    required this.hintt,
    this.initialDate,
  });

  @override
  State<DatePickerField> createState() => DatePickerFieldState();
}

class DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.initialDate != null) {
      _controller.text =
          "${widget.initialDate!.day.toString().padLeft(2, '0')}/"
          "${widget.initialDate!.month.toString().padLeft(2, '0')}/"
          "${widget.initialDate!.year}";
    }
  }

  Future<void> _selectDate() async {
    DateTime initial = widget.initialDate ?? DateTime(2000);

    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1900),
      lastDate: DateTime(
        DateTime.now().year + 100,
        DateTime.now().month,
        DateTime.now().day,
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6A4CFF),
              onPrimary: Colors.white,
              surface: Color(0xFF141A2F),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _controller.text =
            "${pickedDate.day.toString().padLeft(2, '0')}/"
            "${pickedDate.month.toString().padLeft(2, '0')}/"
            "${pickedDate.year}";
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 1).withOpacity(0.10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withOpacity(0.25)),
        ),
        child: AbsorbPointer(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today, color: Colors.white70),
              hintText: widget.hintt,
              hintStyle: const TextStyle(color: Colors.white54),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ),
    );
  }
}
