import 'package:flutter/material.dart';
import 'package:noviindus_test/features/auth/presentation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class PhoneInputField extends StatelessWidget {
  const PhoneInputField({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();

    return Row(
      children: [
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFFFFFFF), width: .5),
          ),
          child: Row(
            children: const [
              Text(
                "+91",
                style: TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 6),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFFFFFFF), width: .5),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: TextField(
                controller: provider.phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.red,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Enter Mobile Number",
                  hintStyle: TextStyle(
                    color: Color(0xFFBDBDBD),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
