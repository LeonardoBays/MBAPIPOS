import 'package:flutter/material.dart';

import '../bloc/manager_player_bloc.dart';
import 'manager_player_btn.dart';
import 'manager_player_input.dart';

class ManagerPlayerBody extends StatelessWidget {
  const ManagerPlayerBody({super.key, required this.state});

  final ManagerPlayerState state;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: state is! ManagerPlayerSaving,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ManagerPlayerInput(
                name: state.name,
                nameError: state.nameError,
                isEnable: state is! ManagerPlayerSaving,
              ),
              ManagerPlayerBtn(isEnable: state is! ManagerPlayerSaving),
            ],
          ),
        ),
      ),
    );
  }
}
