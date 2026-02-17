import 'package:flutter/material.dart';

class CmContainer extends StatelessWidget {
  const CmContainer({super.key, required this.text, required this.bgColor});
  final String text;
  final Color bgColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: Color(0xFFC70000).withOpacity(0.4)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    );
  }
}
