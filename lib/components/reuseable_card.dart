import 'package:flutter/material.dart';

import '../constants.dart';

class ReuseableCard extends StatelessWidget {
  const ReuseableCard({
    super.key,
    required this.child,
    this.selected = false,
    this.onTap,
  });

  final Widget child;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    color: selected ? AppColors.selectedCard : AppColors.card,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(22),
      side: BorderSide(
        color: selected ? AppColors.accent : const Color(0xFF2A304A),
        width: selected ? 1.5 : 1,
      ),
    ),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(10), child: child),
    ),
  );
}
