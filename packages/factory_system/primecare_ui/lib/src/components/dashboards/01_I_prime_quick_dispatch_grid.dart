// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

class PrimeQuickDispatchGrid extends StatelessWidget {
  final int crossAxisCount;
  final List<Widget> children;

  const PrimeQuickDispatchGrid({
    super.key,
    required this.crossAxisCount,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Dispatch',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: children,
        ),
      ],
    );
  }
}
