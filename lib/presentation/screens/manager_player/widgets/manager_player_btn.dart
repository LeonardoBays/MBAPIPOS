import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manager_player_bloc.dart';

class ManagerPlayerBtn extends StatelessWidget {
  const ManagerPlayerBtn({super.key, required this.isEnable});

  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () => _onPressed(context),
        child: isEnable
            ? const Text('Salvar', style: TextStyle())
            : SizedBox(
                height: 16.0,
                width: 16.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    if (!isEnable) {
      return;
    }

    context.read<ManagerPlayerBloc>().add(const ManagerPlayerSave());
  }
}
