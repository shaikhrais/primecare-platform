import 'package:flutter/material.dart';
import 'prime_avatar.dart';

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
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
