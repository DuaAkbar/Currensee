import 'package:flutter/material.dart';

class ContactInputfield extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;

  ContactInputfield({
    super.key,
    required this.hint,
    required this.icon,
    required this.textEditingController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFFE75480)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFFADADD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFE75480)),
        ),
      ),
    );
  }
}
