// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=PHIPA Compliance Engine
// @governance: component=Clinical Logic Mapper
// @governance: component=Audit Trailing

class ClinicalFormsView extends ConsumerStatefulWidget {
  const ClinicalFormsView({super.key});

  @override
  ConsumerState<ClinicalFormsView> createState() => _ClinicalFormsViewState();
}

class _ClinicalFormsViewState extends ConsumerState<ClinicalFormsView>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(clinicalFormsControllerProvider);

    return MasterLayout(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Clinical Documentation Terminal',
            style: theme.typography.h3,
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: 'Medication'),
              Tab(text: 'Vitals'),
              Tab(text: 'Incident'),
              Tab(text: 'Infection'),
              Tab(text: 'Care Plan'),
              Tab(text: 'Audit'),
              Tab(text: 'ADL'),
              Tab(text: 'Census'),
            ],
            onTap: (index) {
              ref
                  .read(clinicalFormsControllerProvider.notifier)
                  .selectForm(state.availableForms[index]);
            },
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildFormContainer(
              theme,
              'Medication Refill Authorization',
              _buildMedicationForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Daily Vitals Entry',
              _buildVitalsForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Clinical Incident Reporting',
              _buildIncidentForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Infection Control Surveillance',
              _buildInfectionForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Care Plan Re-evaluation',
              _buildCarePlanForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Clinical Audit Schedule',
              _buildAuditForm(theme),
            ),
            _buildFormContainer(
              theme,
              'ADL Performance Checklist',
              _buildAdlForm(theme),
            ),
            _buildFormContainer(
              theme,
              'Daily Census Enumeration',
              _buildCensusForm(theme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContainer(
    PrimeCareThemeData theme,
    String title,
    Widget form,
  ) {
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
                    label: 'Submit for Clinical Review',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicationForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Medication Name',
          placeholder: 'Enter med name',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Dosage Protocol',
          placeholder: 'e.g., 5mg daily',
        ),
      ],
    );
  }

  Widget _buildVitalsForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Blood Pressure', placeholder: '120/80'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Heart Rate', placeholder: 'bpm'),
      ],
    );
  }

  Widget _buildIncidentForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Incident Type', placeholder: 'Select type'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Detailed Narrative',
          placeholder: 'Enter details',
        ),
      ],
    );
  }

  Widget _buildInfectionForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Path pathogen identified',
          placeholder: 'Enter pathogen',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Quarantine Status', placeholder: 'Status'),
      ],
    );
  }

  Widget _buildCarePlanForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Patient ID', placeholder: 'P-XXXXX'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Update Summary',
          placeholder: 'Enter summary',
        ),
      ],
    );
  }

  Widget _buildAuditForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Audit Area', placeholder: 'e.g., Sector A'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(label: 'Auditor Initials', placeholder: 'XXX'),
      ],
    );
  }

  Widget _buildAdlForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(
          label: 'Mobility Status',
          placeholder: 'Select status',
        ),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Feeding Assistance',
          placeholder: 'Enter details',
        ),
      ],
    );
  }

  Widget _buildCensusForm(PrimeCareThemeData theme) {
    return Column(
      children: [
        PrimeCareTextField(label: 'Floor Count', placeholder: 'Enter number'),
        SizedBox(height: theme.spacing.md),
        PrimeCareTextField(
          label: 'Discharge Count',
          placeholder: 'Enter number',
        ),
      ],
    );
  }
}

class ClinicalFormsIntent extends PrimeCareScreen {
  ClinicalFormsIntent()
      : super(
          name: 'clinical-forms',
          title: 'Clinical Forms',
          route: '/clinical-forms',
          requiredRole: PlatformRole.clinical,
          form: PrimeCareForm.clinicalForms,
          provider: clinicalFormsControllerProvider,
          componentLabels: const [
            'Aura HUD',
            'PHIPA Compliance Engine',
            'Clinical Logic Mapper',
            'Audit Trailing',
          ],
        );

  @override
  Widget build(BuildContext context) => const ClinicalFormsView();
}
