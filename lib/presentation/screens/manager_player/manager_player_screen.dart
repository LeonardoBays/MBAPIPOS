import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/manager_player_bloc.dart';
import 'widgets/manager_player_content.dart';

class ManagerPlayerScreen extends StatelessWidget {
  const ManagerPlayerScreen({
    super.key,
    required this.managerPlayerBloc,
    this.id,
  });

  final ManagerPlayerBloc managerPlayerBloc;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => managerPlayerBloc..add(ManagerPlayerLoad(id)),
      child: const ManagerPlayerContent(),
    );
  }
}
