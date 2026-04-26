// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_ui/src/components/01_I_fallback_state_wrapper.dart';

class AssemblyLine extends StatelessWidget {
  final List<UIComponentBlueprint> blueprints;
  final bool isOfflineFallback;

  const AssemblyLine({
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
              child: ComponentFabricator.assemble(context, blueprint),
            ),
            const SizedBox(height: 40),
          ];
        }).toList(),
      ),
    );
  }
}
