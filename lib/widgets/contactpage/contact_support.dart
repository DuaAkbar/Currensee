import 'package:flutter/material.dart';

class ContactSupportCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  ContactSupportCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(icon, size: 30, color: Color(0xFFE75480)),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFE75480),
              ),
            ),
            SizedBox(height: 5),
            Text(value, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
