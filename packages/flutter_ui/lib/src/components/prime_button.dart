import 'package:flutter/material.dart';

class PrimeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isDanger;
  final bool isOutline;

  const PrimeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDanger = false,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDanger
        ? Colors.red
        : Theme.of(context).colorScheme.secondary;
    if (isOutline) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: color, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
