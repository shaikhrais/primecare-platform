import 'package:primecare_ui/primecare_ui.dart';
import 'physiotherapist_controller.dart';

class PhysiotherapistView extends ConsumerWidget {
  const PhysiotherapistView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(physiotherapistControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(state.title, style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rehabilitation Schedule', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.sessions.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center),
                        title: Text(state.sessions[index]),
                        trailing: PrimeCareButton.secondary(onPressed: () {}, label: 'Patient Summary'),
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

class PhysiotherapistIntent extends PrimeCareScreen {
  PhysiotherapistIntent() : super(title: "Physiotherapist");

  @override
  Widget build(BuildContext context) => const PhysiotherapistView();
}


