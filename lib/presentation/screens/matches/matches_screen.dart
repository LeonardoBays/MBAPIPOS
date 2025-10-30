import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/matches_bloc.dart';
import 'widgets/matches_content.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key, required this.matchesBloc});

  final MatchesBloc matchesBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => matchesBloc..add(const MatchesLoad()),
      child: const MatchesContent(),
    );
  }
}
