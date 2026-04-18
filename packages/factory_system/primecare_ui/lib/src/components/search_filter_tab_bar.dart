import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchFilterTabBar extends StatelessWidget {
  const SearchFilterTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Search patients, acuity, location...',
          filled: true,
          fillColor: PrimeCareColors.slate400,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
