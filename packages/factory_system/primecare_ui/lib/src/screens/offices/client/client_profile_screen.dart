import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ClientProfileScreen extends ConsumerWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Client Profile',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: clientDashboardDataProvider('client_profile'),
      );
}
