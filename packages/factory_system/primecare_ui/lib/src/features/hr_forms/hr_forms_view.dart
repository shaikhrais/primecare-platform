import 'package:primecare_ui/primecare_ui.dart';
import 'hr_forms_controller.dart';
import 'hr_forms_model.dart';

class HrFormsView extends ConsumerStatefulWidget {
  const HrFormsView({super.key});

  @override
  ConsumerState<HrFormsView> createState() => _HrFormsViewState();
}

class _HrFormsViewState extends ConsumerState<HrFormsView> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(hrFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Human Resources Command Center', style: theme.typography.h3),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Leave Request'),
              Tab(text: 'Grievance'),
              Tab(text: 'Onboarding'),
              Tab(text: 'Interview'),
              Tab(text: 'Exit Interview'),
            ],
            onTap: (index) {
              ref.read(hrFormsControllerProvider.notifier).selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFormContainer(theme, 'Leave Request Form', _buildLeaveRequestForm(theme)),
            _buildFormContainer(theme, 'Employee Grievance Form', _buildGrievanceForm(theme)),
            _buildFormContainer(theme, 'New Onboarding Entry', _buildOnboardingForm(theme)),
            _buildFormContainer(theme, 'Interview Scheduler', _buildInterviewForm(theme)),
            _buildFormContainer(theme, 'Exit Interview Submission', _buildExitInterviewForm(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(PrimeCareThemeData theme, String title, Widget form) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: PrimeCareCard(
            padding: EdgeInsets.all(theme.spacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.typography.h4),
                SizedBox(height: theme.spacing.lg),
                form,
                SizedBox(height: theme.spacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: PrimeCareButton(
                    onPressed: () {},
                    label: 'Submit for Processing',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveRequestForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Employee Name', placeholder: 'Enter name'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Reason for Leave', placeholder: 'Describe reason'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Start Date', placeholder: 'YYYY-MM-DD'),
      ],
    );
  }

  Widget _buildGrievanceForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Incident Description', placeholder: 'Provide details'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Parties Involved', placeholder: 'List names'),
      ],
    );
  }

  Widget _buildOnboardingForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Candidate ID', placeholder: 'C-XXXXX'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Department Allocation', placeholder: 'Select department'),
      ],
    );
  }

  Widget _buildInterviewForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Candidate Name', placeholder: 'Enter name'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Panel Members', placeholder: 'List interviewers'),
      ],
    );
  }

  Widget _buildExitInterviewForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Termination Reason', placeholder: 'Provide context'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Feedback Summary', placeholder: 'Key takeaways'),
      ],
    );
  }
}

class HrFormsIntent extends PrimeCareScreen {
  HrFormsIntent() : super(title: "HrForms");

  @override
  Widget build(BuildContext context) => const HrFormsView();
}


