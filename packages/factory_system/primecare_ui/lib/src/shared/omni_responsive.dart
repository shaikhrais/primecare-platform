import 'package:flutter/material.dart';

class OmniBreakpoints {
  static const double mobile = 600;
  static const double tablet = 1024;
  static const double laptop = 1440;
  static const double desktop2k = 2560;
  static const double desktop4k = 3840;

  /// The maximum width UI content should ever expand to before centering.
  /// Prevents the "half screen ridiculous" card stretching on 4k/100inch monitors.
  static const double maxContentWidth = 1600;

  /// The absolute minimum width required to render the platform safely.
  static const double minSafeWidth = tablet;
}

/// A wrapper that enforces a maximum width and centers the content.
/// Essential for ultra-large monitors to prevent infinite stretching of layout components.
/// Also enforces a minimum width, blocking small screens (mobile) from rendering the dashboard.
class OmniConstraintWrapper extends StatelessWidget {
  final Widget child;

  const OmniConstraintWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Block rendering on screens that are too small (mobile / narrow tablet)
    if (screenWidth < OmniBreakpoints.minSafeWidth) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.monitor_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 32),
                Text(
                  'Display Size Not Supported',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'The PrimeCare Governance Platform requires a larger display to render complex telemetry and data grids safely.\n\nPlease access this platform on a desktop or landscape tablet (minimum width: ${OmniBreakpoints.minSafeWidth.toInt()}px).',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Current width: ${screenWidth.toInt()}px',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: OmniBreakpoints.maxContentWidth,
        ),
        child: child,
      ),
    );
  }
}
