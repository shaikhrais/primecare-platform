import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

class CfoAccountsReceivableScreen extends ConsumerWidget {
  const CfoAccountsReceivableScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => PageTemplate.orchestrate(
        title: 'Cfo Accounts Receivable',
        subtitle: 'Real-time dashboard managed by the PrimeCare Factory Engine.',
        provider: cfoDashboardDataProvider('cfo_accounts_receivable'),
      );
}
