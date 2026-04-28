import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';
import 'package:primecare_ui/src/features/shared/controller_infrastructure.dart';

class BillingAdminDashboardController {
  final WidgetRef ref;

  BillingAdminDashboardController(this.ref);

  void refresh() {
    ref.invalidate(billingAdminDashboardAdapterProvider);
  }
}
