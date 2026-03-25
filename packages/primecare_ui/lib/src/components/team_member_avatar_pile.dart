import 'package:flutter/material.dart';
import 'prime_avatar.dart';

class TeamMemberAvatarPile extends StatelessWidget {
  const TeamMemberAvatarPile({Key? key}) : super(key: key);

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
              backgroundColor: Colors.grey.shade200,
              child: const Text('+4'),
            ),
          ),
        ],
      ),
    );
  }
}
