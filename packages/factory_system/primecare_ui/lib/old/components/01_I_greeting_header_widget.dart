// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_prime_avatar.dart';

class GreetingHeaderWidget extends StatelessWidget {
  final String name;
  const GreetingHeaderWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning,',
              style: TextStyle(color: PrimeCareColors.slate400, fontSize: 14),
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: PrimeCareColors.black.withValues(alpha: 0.87),
              ),
            ),
          ],
        ),
        const PrimeAvatar(fallbackInitials: 'PSW', isOnline: true),
      ],
    );
  }
}

// Using dynamicPageProvider and ViewModel pattern for data binding.
