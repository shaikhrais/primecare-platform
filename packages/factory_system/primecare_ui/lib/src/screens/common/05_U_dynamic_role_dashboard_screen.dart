// Layer: 05_UI_APPLICATION
import 'package:primecare_ui/primecare_ui.dart';

/// A thin bridge that delegates rendering to the [UniversalScreenEngine] 
/// via the [ScreenRegistry].
///
/// This screen no longer contains business logic, telemetry, or resilience.
/// All high-fidelity rendering logic has been consolidated into the 
/// UniversalScreenEngine for unified platform governance.
class DynamicRoleDashboardScreen extends ConsumerWidget {
  final String role;

  const DynamicRoleDashboardScreen({
    super.key,
    required this.role,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Register the institutional context for Aura Intelligence.
    // This allows the assistant to surface role-specific suggestions.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(auraContextProvider.notifier).update(role);
    });

    return ScreenRegistry.buildScreen(context, role);
  }
}
