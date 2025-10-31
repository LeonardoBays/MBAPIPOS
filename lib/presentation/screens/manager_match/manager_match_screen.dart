import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/manager_match_bloc.dart';
import 'widgets/manager_match_content.dart';

class ManagerMatchScreen extends StatelessWidget {
  const ManagerMatchScreen({
    super.key,
    required this.managerMatchBloc,
    this.id,
  });

  final ManagerMatchBloc managerMatchBloc;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => managerMatchBloc..add(ManagerMatchLoad(id)),
      child: const ManagerMatchContent(),
    );
  }
}
