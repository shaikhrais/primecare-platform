import 'package:flutter/material.dart';

class PrimeCareSectionHeader extends StatelessWidget {
  final String title;
  final bool isWhite;

  const PrimeCareSectionHeader({
    super.key,
    required this.title,
    this.isWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: isWhite
          ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)
          : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: isWhite ? Colors.white : const Color(0xFF1E5BB2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: isWhite
            ? const Border(bottom: BorderSide(color: Color(0xFFE2E8F0)))
            : null,
      ),
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: isWhite ? const Color(0xFF1E3A8A) : Colors.white,
        ),
      ),
    );
  }
}
