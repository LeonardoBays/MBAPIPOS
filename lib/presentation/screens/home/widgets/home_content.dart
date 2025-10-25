import 'package:flutter/material.dart';
import 'package:mbapipos/presentation/screens/home/widgets/home_body.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: HomeBody(),
    );
  }
}
