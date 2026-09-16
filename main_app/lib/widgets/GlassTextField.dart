import 'package:flutter/material.dart';

class GlassTextField extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool obscure;
  final bool showToggle;
  final Function(String)? onChanged;
  final String? initialValue;

  const GlassTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.showToggle = false,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<GlassTextField> createState() => _GlassTextFieldState();
}

class _GlassTextFieldState extends State<GlassTextField> {
  late bool isObscured;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscure;
    _controller = TextEditingController(text: widget.initialValue ?? "");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      obscureText: isObscured,
      onChanged: widget.onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: Colors.white70),
        suffixIcon: widget.showToggle
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white70,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
        hintText: widget.hint,
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.25),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: Color.fromRGBO(223, 235, 255, 1),
            width: 2,
          ),
        ),
      ),
    );
  }
}
