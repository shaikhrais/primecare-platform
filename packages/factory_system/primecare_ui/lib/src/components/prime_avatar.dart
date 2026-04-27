// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/primecare_avatar.dart';

/// Legacy [PrimeAvatar] wrapper.
/// Delegates to [PrimeCareAvatar] for centralized compliance.
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
    return PrimeCareAvatar(
      fallbackInitials: fallbackInitials,
      radius: radius,
      isOnline: isOnline,
    );
  }
}
