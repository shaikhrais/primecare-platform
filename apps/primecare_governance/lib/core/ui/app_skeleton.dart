// Governance - Category: service | Purpose: Core implementation file for the App Skeleton platform logic.
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppSkeleton extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const AppSkeleton({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color.alphaBlend(Theme.of(context).colorScheme.onSurface.withValues(alpha: .08), Theme.of(context).colorScheme.surface),
      highlightColor: Color.alphaBlend(Theme.of(context).colorScheme.onSurface.withValues(alpha: .02), Theme.of(context).colorScheme.surface),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class AppListSkeleton extends StatelessWidget {
  const AppListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Row(
          children: [
            const AppSkeleton(width: 60, height: 60, borderRadius: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppSkeleton(width: 150, height: 16),
                  const SizedBox(height: 8),
                  const AppSkeleton(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
