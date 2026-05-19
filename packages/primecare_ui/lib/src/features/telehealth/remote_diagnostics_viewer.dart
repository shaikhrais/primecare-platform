import 'package:primecare_ui/primecare_ui.dart';

class RemoteDiagnosticsViewerScreen extends GovernedConsumerWidget {
  const RemoteDiagnosticsViewerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Remote Diagnostics Viewer Screen'),
      ),
    );
  }
}
