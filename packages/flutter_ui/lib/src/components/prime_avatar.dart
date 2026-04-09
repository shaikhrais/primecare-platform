import 'package:flutter/material.dart';

class PrimeAvatar extends StatelessWidget {
  final String fallbackInitials;
  final double radius;
  final bool isOnline;

  const PrimeAvatar({
    super.key,
    required this.fallbackInitials,
    this.radius = 24.0,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).primaryColorLight,
          child: Text(fallbackInitials, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: radius * 0.6,
              height: radius * 0.6,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
