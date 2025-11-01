import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/input.dart';
import '../bloc/manager_match_bloc.dart';

class ManagerInputs extends StatefulWidget {
  const ManagerInputs({
    super.key,
    required this.isEnable,
    required this.homeTeamName,
    required this.awayTeamName,
    this.homeTeamNameError,
    this.awayTeamNameError,
  });

  final bool isEnable;

  final String homeTeamName;
  final String awayTeamName;
  final String? homeTeamNameError;
  final String? awayTeamNameError;

  @override
  State<ManagerInputs> createState() => _ManagerInputsState();
}

class _ManagerInputsState extends State<ManagerInputs> {
  late final FocusNode _homeNameFocus;
  late final FocusNode _awayNameFocus;

  late bool _isEnable;

  late final String _homeTeamName;
  late final String _awayTeamName;
  late String? _homeTeamNameError;
  late String? _awayTeamNameError;

  @override
  void initState() {
    _homeNameFocus = FocusNode();
    _awayNameFocus = FocusNode();

    _homeTeamName = widget.homeTeamName;
    _awayTeamName = widget.awayTeamName;
    _homeTeamNameError = widget.homeTeamNameError;
    _awayTeamNameError = widget.awayTeamNameError;

    _isEnable = widget.isEnable;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ManagerInputs oldWidget) {
    if (_isEnable != widget.isEnable) {
      _isEnable = widget.isEnable;
    }

    if (_homeTeamNameError != widget.homeTeamNameError) {
      _homeTeamNameError = widget.homeTeamNameError;
    }

    if (_awayTeamNameError != widget.awayTeamNameError) {
      _awayTeamNameError = widget.awayTeamNameError;
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Input(
          label: 'Nome do time local',
          hint: 'Time local',
          isEnabled: _isEnable,
          isVisible: true,
          focus: _homeNameFocus,
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (value) => _onHomeTextChange(context, value),
          onSubmitted: () => _homeNameFocus.unfocus(),
          initialValue: _homeTeamName,
          error: _homeTeamNameError,
        ),
        const SizedBox(height: 24.0),
        Input(
          label: 'Nome do time visitante',
          hint: 'Time visitante',
          isEnabled: _isEnable,
          isVisible: true,
          focus: _awayNameFocus,
          textInputType: TextInputType.name,
          textInputAction: TextInputAction.next,
          onChanged: (value) => _onAwayTextChange(context, value),
          onSubmitted: () => _awayNameFocus.unfocus(),
          initialValue: _awayTeamName,
          error: _awayTeamNameError,
        ),
      ],
    );
  }

  void _onHomeTextChange(BuildContext context, String value) {
    context.read<ManagerMatchBloc>().add(ManagerMatchHomeName(value));
  }

  void _onAwayTextChange(BuildContext context, String value) {
    context.read<ManagerMatchBloc>().add(ManagerMatchAwayName(value));
  }
}
