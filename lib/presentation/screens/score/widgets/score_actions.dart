import 'package:flutter/material.dart';

class ScoreActions extends StatelessWidget {
  const ScoreActions({super.key, this.increase, this.decrease});

  final Function()? increase;
  final Function()? decrease;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: decrease,
            icon: const Icon(Icons.exposure_minus_1_outlined),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            onPressed: increase,
            icon: const Icon(Icons.plus_one_outlined),
          ),
        ],
      ),
    );
  }
}
