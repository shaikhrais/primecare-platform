import 'package:primecare_ui/primecare_ui.dart';
import 'family_member_controller.dart';

class FamilyMemberView extends ConsumerWidget {
  const FamilyMemberView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(familyMemberControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Family Care Connect', style: theme.typography.h3),
        ),
        body: Padding(
          padding: EdgeInsets.all(theme.spacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Care Updates for ${state.patientName}', style: theme.typography.h4),
              SizedBox(height: theme.spacing.md),
              Expanded(
                child: ListView.builder(
                  itemCount: state.updates.length,
                  itemBuilder: (context, index) {
                    return PrimeCareCard(
                      margin: EdgeInsets.only(bottom: theme.spacing.md),
                      child: ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text(state.updates[index]),
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

class FamilyMemberIntent extends PrimeCareScreen {
  FamilyMemberIntent() : super(title: "FamilyMember");

  @override
  Widget build(BuildContext context) => const FamilyMemberView();
}


