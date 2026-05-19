import 'package:primecare_ui/primecare_ui.dart';

class RemotePatientMonitoringDashboardScreen extends GovernedConsumerWidget {
  const RemotePatientMonitoringDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Remote Patient Monitoring Dashboard Screen'),
      ),
    );
  }
}
