import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbapipos/presentation/screens/register/bloc/register_bloc.dart';
import 'package:mbapipos/presentation/screens/register/widgets/register_content.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key, required this.registerBloc});

  final RegisterBloc registerBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => registerBloc,
      child: RegisterContent(),
    );
  }
}
