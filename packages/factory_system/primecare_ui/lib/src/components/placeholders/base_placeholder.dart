// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

/// Base class for all auto-generated placeholders during architectural transition.
class BasePlaceholder extends StatelessWidget {
  final String name;
  final dynamic data;

  const BasePlaceholder({super.key, required this.name, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.extension_outlined, color: Colors.grey),
          const SizedBox(height: 8),
          Text(
            'Placeholder: $name',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
