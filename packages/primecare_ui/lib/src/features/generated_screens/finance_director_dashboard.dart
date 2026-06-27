import 'package:primecare_ui/primecare_ui.dart';

/// Finance Director Dashboard – currently reuses CFO dashboard content for visual tests.
class FinanceDirectorDashboard extends ConsumerStatefulWidget {
  const FinanceDirectorDashboard({super.key});

  @override
  ConsumerState<FinanceDirectorDashboard> createState() =>
      _FinanceDirectorDashboardState();
}

class _FinanceDirectorDashboardState extends ConsumerState<FinanceDirectorDashboard> {
  @override
  Widget build(BuildContext context) {
    // For now, reuse the existing CFO dashboard content.
    return buildCfoDashboardContent(context);
  }
}
