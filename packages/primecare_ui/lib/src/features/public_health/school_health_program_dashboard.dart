// Governance - Category: view | Purpose: UI Screen component rendering the School Health Program Dashboard workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

class SchoolHealthProgramDashboardScreen extends GovernedConsumerWidget {
  const SchoolHealthProgramDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('School Health Program Dashboard Screen'),
      ),
    );
  }
}
