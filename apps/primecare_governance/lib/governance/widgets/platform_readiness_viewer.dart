import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';
import 'governance_kpi_grid.dart';
import 'platform_readiness_viewer_controller.dart';

class PlatformReadinessViewer extends ConsumerWidget {
  const PlatformReadinessViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(platformReadinessViewerControllerProvider);
    if (snapshot.screens.isEmpty) {
      return Center(child: PrimeText('common.no_data'.tr()));
    }
    final screens = snapshot.screens.values.toList()..sort((a, b) {
      final aPending = snapshot.pendingEvidence[a.id]!.isNotEmpty;
      final bPending = snapshot.pendingEvidence[b.id]!.isNotEmpty;
      if (aPending != bPending) return aPending ? -1 : 1;
      return a.id.compareTo(b.id);
    });
    return Material(child: ListView.builder(
      itemCount: screens.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(children: [
            const PrimeText(PlatformReadinessSnapshot.source),
            GovernanceKPIGrid(report: snapshot.report),
          ]);
        }
        final screen = screens[index - 1];
        final pending = snapshot.pendingEvidence[screen.id]!;
        return ListTile(
          key: ValueKey('readiness-${screen.id}'),
          title: PrimeText(screen.id),
          subtitle: PrimeText([
            screen.title, screen.routePath, ...pending,
          ].where((value) => value.isNotEmpty).join('\n')),
          trailing: Icon(pending.isEmpty
            ? Icons.check_circle_outline : Icons.pending_outlined),
        );
      },
    ));
  }
}
