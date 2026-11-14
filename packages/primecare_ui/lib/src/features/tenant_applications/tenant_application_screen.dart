import 'package:primecare_ui/primecare_ui.dart';
import 'tenant_application_catalog.g.dart';
import 'tenant_application_panel.dart';
export 'tenant_application_panel.dart' show nativeApplicationClientProvider,nativeTaskLeaveBlockProvider,canLeaveNativeApplicationTasks,NativeApplicationIdentity;

/// Existing screen2534/API16578 authorizes this native composition before either
/// child mounts. Profile remains read-only; account security stays on /success.
class TenantApplicationScreen extends GovernedConsumerWidget {
  const TenantApplicationScreen({super.key});
  @override Widget buildScreen(BuildContext context,WidgetRef ref) {
    final auth=ref.watch(authProvider);
    if(!auth.isInitialized || !auth.isAuthenticated || auth.userId?.isNotEmpty!=true ||
        auth.tenantId?.isNotEmpty!=true || auth.token?.isNotEmpty!=true ||
        auth.role!=nativeApplicationDestinations['host']['role']) return const SizedBox.shrink();
    final identity=NativeApplicationIdentity(auth.userId!,auth.tenantId!,auth.role!,auth.token!);
    return TenantApplicationPanel(key:ValueKey(identity),identity:identity);
  }
}

