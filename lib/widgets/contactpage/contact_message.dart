import 'package:flutter/material.dart';

class ContactMsgfield extends StatelessWidget {
  final IconData icon;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;
   ContactMsgfield({
    super.key,
    required this.icon,
    required this.textEditingController,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'How can we help you?',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: Color(0xFFFADADD)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:  BorderSide(color: Color(0xFFE75480)),
        ),
    ),
);
}
}