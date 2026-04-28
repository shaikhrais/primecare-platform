// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ChiropractorView extends ConsumerWidget {
  const ChiropractorView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(chiropractorControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(title: Text(state.title, style: theme.typography.h3)),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today\'s Schedule', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.appointments.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.event),
                        title: Text(state.appointments[index]),
                        trailing: PrimeCareButton.secondary(
                          onPressed: () {},
                          label: 'View File',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChiropractorIntent extends PrimeCareScreen {
  ChiropractorIntent() : super(title: 'Chiropractor');

  @override
  Widget build(BuildContext context) => const ChiropractorView();
}
