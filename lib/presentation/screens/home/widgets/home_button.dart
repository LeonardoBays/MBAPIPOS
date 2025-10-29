import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.label,
    required this.svgPath,
    required this.onPressed,
  });

  final String label;
  final String svgPath;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      elevation: 2.0,
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                svgPath,
                width: 22,
                // colorFilter: ColorFilter.mode(
                //   Theme.of(context).colorScheme.onPrimary,
                //   BlendMode.srcIn,
                // ),
              ),
              const SizedBox(height: 18.0),
              Text(
                label,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
