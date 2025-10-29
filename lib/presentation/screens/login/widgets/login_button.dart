import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.isLoading,
    required this.isEnable,
    required this.onPressed,
  });

  final bool isLoading;
  final bool isEnable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            : const Text(
                'Sign In',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
