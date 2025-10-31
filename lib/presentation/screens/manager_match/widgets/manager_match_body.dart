import 'package:flutter/material.dart';

import '../../../components/input.dart';
import '../../manager_player/widgets/manager_player_btn.dart';
import '../bloc/manager_match_bloc.dart';
import 'manager_inputs.dart';

class ManagerMatchBody extends StatelessWidget {
  const ManagerMatchBody({super.key, required this.state});

  final ManagerMatchState state;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: state is! ManagerMatchSaving,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ManagerInputs(
                isEnable: state is! ManagerMatchSaving,
                homeTeamName: state.homeName,
                homeTeamNameError: state.homeNameError,
                awayTeamName: state.awayName,
                awayTeamNameError: state.awayNameError,
              ),
              ManagerPlayerBtn(isEnable: state is! ManagerMatchSaving),
            ],
          ),
        ),
      ),
    );
  }
}
