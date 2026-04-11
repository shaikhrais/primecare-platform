import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide ctoDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart'; // Ensure correct import
import 'package:primecare_ui/primecare_ui.dart';

class ClinicShiftDetailsScreen extends ConsumerWidget {
  const ClinicShiftDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Shift Details',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ctoDashboardAdapterProvider,
      );
}
