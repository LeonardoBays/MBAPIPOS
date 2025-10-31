import 'package:flutter/material.dart';

import '../../manager_player/widgets/manager_player_btn.dart';
import '../bloc/manager_match_bloc.dart';

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

              ManagerPlayerBtn(isEnable: state is! ManagerMatchSaving),
            ],
          ),
        ),
      ),
    );
  }
}
