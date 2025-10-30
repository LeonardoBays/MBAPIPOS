import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/manager_player_bloc.dart';

class ManagerPlayerInput extends StatefulWidget {
  const ManagerPlayerInput({
    super.key,
    required this.name,
    required this.nameError,
    required this.isEnable,
  });

  final String name;
  final String? nameError;
  final bool isEnable;

  @override
  State<ManagerPlayerInput> createState() => _ManagerPlayerInputState();
}

class _ManagerPlayerInputState extends State<ManagerPlayerInput> {
  late final TextEditingController _controller;

  late bool _isEnable;
  late String? _nameError;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.name);
    _isEnable = widget.isEnable;
    _nameError = widget.nameError;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ManagerPlayerInput oldWidget) {
    if (_isEnable != widget.isEnable) {
      _isEnable = widget.isEnable;
    }
    if (_nameError != widget.nameError) {
      _nameError = widget.nameError;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.name,
      minLines: 1,
      maxLines: 3,
      controller: _controller,
      autofocus: true,
      onChanged: (value) => _onTextChange(value),
      onSubmitted: (_) => _onSubmitted(context),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        enabled: _isEnable,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        errorText: _nameError,
        hintText: 'Nome do jogador',
        errorMaxLines: 3,
        hintStyle: const TextStyle(fontSize: 32.0, color: Colors.grey),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  void _onTextChange(String value) {
    context.read<ManagerPlayerBloc>().add(ManagerPlayerSetName(value));
  }

  void _onSubmitted(BuildContext context) {
    if (!_isEnable) {
      return;
    }

    context.read<ManagerPlayerBloc>().add(const ManagerPlayerSave());
  }
}
