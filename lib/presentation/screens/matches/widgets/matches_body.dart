import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/match.dart';
import '../bloc/matches_bloc.dart';
import 'matches_card.dart';

class MatchesBody extends StatelessWidget {
  const MatchesBody({super.key, required this.state});

  final MatchesState state;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async => _onRefreshed(context),
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 12.0),
          physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            final Match match = state.matches[index];

            return MatchesCard(match: match);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 12.0);
          },
          itemCount: state.matches.length,
        ),
      ),
    );
  }

  void _onRefreshed(BuildContext context) {
    context.read<MatchesBloc>().add(const MatchesLoad());
  }
}
