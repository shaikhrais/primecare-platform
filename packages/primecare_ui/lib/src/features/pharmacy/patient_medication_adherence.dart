import 'package:primecare_ui/primecare_ui.dart';

class PatientMedicationAdherenceScreen extends GovernedConsumerWidget {
  const PatientMedicationAdherenceScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Patient Medication Adherence Screen'),
      ),
    );
  }
}
