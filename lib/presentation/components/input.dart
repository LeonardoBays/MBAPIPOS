import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    super.key,
    this.error,
    required this.label,
    required this.hint,
    required this.isEnabled,
    required this.isVisible,
    required this.focus,
    required this.textInputType,
    required this.textInputAction,
    required this.onChanged,
    required this.onSubmitted,
    this.suffixIcon,
  });

  final String label;
  final String hint;
  final String? error;
  final bool isEnabled;
  final bool isVisible;
  final FocusNode focus;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final Function(String value) onChanged;
  final Function() onSubmitted;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      enabled: isEnabled,
      keyboardType: textInputType,
      focusNode: focus,
      onFieldSubmitted: isEnabled ? (_) => onSubmitted() : null,
      textInputAction: textInputAction,
      obscureText: !isVisible,
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14.0, color: Colors.grey),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.5),
        ),
        errorText: error,
        errorStyle: const TextStyle(height: 1, fontSize: 12),
      ),
    );
  }
}
