// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/01_I_colors.dart';
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/01_I_prime_avatar.dart';

class TeamMemberAvatarPile extends StatelessWidget {
  const TeamMemberAvatarPile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          const Positioned(left: 0, child: PrimeAvatar(fallbackInitials: 'JD')),
          const Positioned(
            left: 20,
            child: PrimeAvatar(fallbackInitials: 'AS'),
          ),
          Positioned(
            left: 40,
            child: CircleAvatar(
              backgroundColor: PrimeCareColors.slate400,
              child: const Text('+4'),
            ),
          ),
        ],
      ),
    );
  }
}
