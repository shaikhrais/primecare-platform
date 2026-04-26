// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';

/// A wrapper that dynamically adjusts scaling
/// to implement "Scaling Up" strategy for high-res and mega displays.
class AdaptiveScalingWrapper extends ConsumerWidget {
  final Widget child;

  const AdaptiveScalingWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Consume the centrally calculated layout configuration.
    final layout = ref.watch(layoutProvider);

    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(layout.scaleFactor)),
      child: child,
    );
  }
}
