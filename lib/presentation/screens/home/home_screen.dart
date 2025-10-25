import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbapipos/presentation/screens/home/bloc/home_bloc.dart';
import 'package:mbapipos/presentation/screens/home/widgets/home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.homeBloc});

  final HomeBloc homeBloc;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = widget.homeBloc;
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.add(const HomeReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _homeBloc, child: const HomeContent());
  }
}
