import 'package:primecare_ui/primecare_ui.dart';

class AsynchronousConsultationInboxScreen extends GovernedConsumerWidget {
  const AsynchronousConsultationInboxScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text('Asynchronous Consultation Inbox Screen'),
      ),
    );
  }
}
