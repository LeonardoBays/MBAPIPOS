import 'package:flutter/material.dart';

class LoginInputType extends StatelessWidget {
  const LoginInputType({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
