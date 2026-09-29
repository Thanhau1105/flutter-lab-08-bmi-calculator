import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: onPressed,
    icon: Icon(icon),
    color: Colors.white,
    style: IconButton.styleFrom(
      backgroundColor: const Color(0xFF353C59),
      minimumSize: const Size(48, 48),
      shape: const CircleBorder(),
    ),
  );
}
