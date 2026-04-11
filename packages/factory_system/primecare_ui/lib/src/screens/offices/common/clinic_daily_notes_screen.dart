import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart' hide ctoDashboardAdapterProvider;
import 'package:primecare_adapters/primecare_adapters.dart'; // Ensure correct import
import 'package:primecare_ui/primecare_ui.dart';

class ClinicDailyNotesScreen extends ConsumerWidget {
  const ClinicDailyNotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Daily Notes',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: ctoDashboardAdapterProvider,
      );
}
