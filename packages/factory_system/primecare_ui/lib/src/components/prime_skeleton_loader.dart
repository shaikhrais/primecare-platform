// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';
import 'package:primecare_ui/src/components/primecare_skeleton.dart';

/// Legacy [PrimeSkeletonLoader] wrapper.
/// Delegates to [PrimeCareSkeleton] for centralized compliance.
class PrimeSkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const PrimeSkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareSkeleton(
      width: width,
      height: height,
      borderRadius: borderRadius,
    );
  }
}
