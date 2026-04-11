import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/assembly/component_factory.dart';
import 'package:flutter_ui/src/components/fallback_state_wrapper.dart';

class LayoutAssemblyEngine extends StatelessWidget {
  final List<UIComponentBlueprint> blueprints;
  final bool isOfflineFallback;

  const LayoutAssemblyEngine({
    super.key,
    required this.blueprints,
    this.isOfflineFallback = false,
  });

  @override
  Widget build(BuildContext context) {
    // Top-level intersection point for Graceful Degradation Strategy
    return FallbackStateWrapper(
      isOfflineFallback: isOfflineFallback,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: blueprints.expand((blueprint) {
          // Add spacing between assembled components
          return [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ComponentFactory.assemble(context, blueprint),
            ),
            const SizedBox(height: 40),
          ];
        }).toList(),
      ),
    );
  }
}
