import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/score_bloc.dart';
import 'widgets/score_content.dart';

class ScoreScreen extends StatelessWidget {
  const ScoreScreen({super.key, required this.id, required this.scoreBloc});

  final String id;
  final ScoreBloc scoreBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => scoreBloc..add(ScoreLoad(id)),
      child: const ScoreContent(),
    );
  }
}
