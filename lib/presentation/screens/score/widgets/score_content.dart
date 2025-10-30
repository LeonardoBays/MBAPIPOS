import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/extensions/context_extension.dart';
import '../../../components/blank_content.dart';
import '../bloc/score_bloc.dart';
import 'score_body.dart';

class ScoreContent extends StatelessWidget {
  const ScoreContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Placar')),
      body: BlocConsumer<ScoreBloc, ScoreState>(
        listener: _listener,
        builder: (context, state) {
          if (state is ScoreLoaded ||
              state is ScoreSaving ||
              state is ScoreWarning) {
            return ScoreBody(state: state);
          }

          if (state is ScoreLoadFail) {
            return BlankContent(
              message: state.message,
              onRefreshed: () => _onRefreshed(context, state.id),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _onRefreshed(BuildContext context, String id) {
    context.read<ScoreBloc>().add(ScoreLoad(id));
  }

  void _listener(BuildContext context, ScoreState state) {
    if (state is ScoreWarning) {
      _showSnackError(context, state.message);
    }
  }

  void _showSnackError(BuildContext context, String message) {
    context.showFailSnackBar(message);
  }
}
