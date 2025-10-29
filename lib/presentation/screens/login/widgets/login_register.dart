import 'package:flutter/material.dart';

import '../../../../config/routes.dart';

class LoginRegister extends StatelessWidget {
  const LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        borderRadius: BorderRadius.circular(4.0),
        onTap: () => _onPressed(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: RichText(
            text: const TextSpan(
              text: 'Não tem uma conta?',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(text: ' '),
                TextSpan(text: 'Cadastre-se agora!'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.register.route);
  }
}
