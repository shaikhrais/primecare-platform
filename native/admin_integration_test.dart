import 'package:integration_test/integration_test.dart';
import 'admin_cases/admin_rebuild_test.dart' as accounts;
import 'admin_cases/admin_status_filter_test.dart' as filters;

/// Reuse shared Admin UI regressions on native engines without screen copies.
/// These tests use a controlled transport; live Admin API E2E is separate.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  accounts.main();
  filters.main();
}
