import 'package:primecare_ui/primecare_ui.dart' show PrimeListTile;
import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon;
import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';
import 'platform_discovery_viewer_controller.dart';

class PlatformDiscoveryViewer extends ConsumerWidget {
  const PlatformDiscoveryViewer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(platformDiscoveryViewerControllerProvider);
    if (!snapshot.available) {
      return Center(child: PrimeText('common.offline_mode'.tr()));
    }
    if (snapshot.services.isEmpty) {
      return Center(child: PrimeText('common.no_data'.tr()));
    }
    final services = snapshot.services.entries.toList()..sort((a, b) => a.key.compareTo(b.key));
    return Material(child: ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return PrimeListTile(key: ValueKey('discovery-${service.key}'),
          title: PrimeText(service.key), subtitle: PrimeText(service.value),
          trailing: PrimeIcon(service.value == 'healthy'
            ? Icons.check_circle_outline : Icons.info_outline));
      },
    ));
  }
}
