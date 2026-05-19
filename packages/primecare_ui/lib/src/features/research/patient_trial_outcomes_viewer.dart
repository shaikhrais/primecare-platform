import 'package:primecare_ui/primecare_ui.dart';

class PatientTrialOutcomesViewerScreen extends GovernedConsumerWidget {
  const PatientTrialOutcomesViewerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Patient Trial Outcomes Viewer Screen'),
      ),
    );
  }
}
