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
}

/// A wrapper that enforces a maximum width and centers the content.
/// Designed natively for ultra-large (4K/100-inch) displays to prevent
/// horizontal stretching, while allowing fluid, unblocked responsive
/// reflow down to mobile and tablet sizes.
class OmniConstraintWrapper extends StatelessWidget {
  final Widget child;

  const OmniConstraintWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
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
