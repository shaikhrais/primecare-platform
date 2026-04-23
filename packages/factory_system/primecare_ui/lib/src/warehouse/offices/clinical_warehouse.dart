// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';
import 'package:primecare_ui/src/components/forms/clinical/01_I_patient_intake_form.dart';
import 'package:primecare_ui/src/components/forms/clinical/01_I_vitals_capture_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_clinical_incident_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_medication_administration_form.dart';

class ClinicalComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'clinicDashboardAdapter': (context, payload) => ClinicdashboardadapterPlaceholder(data: payload),
    'clinicDashboardDto': (context, payload) => ClinicdashboarddtoPlaceholder(data: payload),
    'clinicDashboardDtoAdapter': (context, payload) => ClinicdashboarddtoadapterPlaceholder(data: payload),
    'clinicDashboardMapper': (context, payload) => ClinicdashboardmapperPlaceholder(data: payload),
    'clinicDashboardMapperAdapter': (context, payload) => ClinicdashboardmapperadapterPlaceholder(data: payload),
    'clinicDashboardViewModel': (context, payload) =>
        const ClinicaldirectordashboardscreenPlaceholder(),
    'clinicDashboardViewModelAdapter': (context, payload) => ClinicdashboardviewmodeladapterPlaceholder(data: payload),

    'clinicalIncidentForm': (context, payload) => const ClinicalIncidentForm(),
    'intakeDashboardAdapter': (context, payload) => IntakedashboardadapterPlaceholder(data: payload),
    'intakeDashboardDto': (context, payload) => IntakedashboarddtoPlaceholder(data: payload),
    'intakeDashboardDtoAdapter': (context, payload) => IntakedashboarddtoadapterPlaceholder(data: payload),
    'intakeDashboardMapper': (context, payload) => IntakedashboardmapperPlaceholder(data: payload),
    'intakeDashboardMapperAdapter': (context, payload) => IntakedashboardmapperadapterPlaceholder(data: payload),
    'intakeDashboardViewModel': (context, payload) => const IntakeDashboardScreen(),
    'intakeDashboardViewModelAdapter': (context, payload) => IntakedashboardviewmodeladapterPlaceholder(data: payload),

    'patientIntakeForm': (context, payload) => const PatientIntakeForm(),
    'vitalsCaptureForm': (context, payload) => const VitalsCaptureForm(),
    'medicationAdministrationForm': (context, payload) => const MedicationAdministrationForm(),
    
    'logClinicalIncidentForm': (context, payload) => LogclinicalincidentformPlaceholder(data: payload),
    'logInfectionControlForm': (context, payload) => LoginfectioncontrolformPlaceholder(data: payload),
    'carePlanEvaluationForm': (context, payload) => CareplanevaluationformPlaceholder(data: payload),
    'dailyVitalsCardForm': (context, payload) => DailyvitalscardformPlaceholder(data: payload),

    'qaManagerDashboardAdapter': (context, payload) => QadashboardadapterPlaceholder(data: payload),
    'qaManagerDashboardDto': (context, payload) => QadashboarddtoPlaceholder(data: payload),
    'qaManagerDashboardMapper': (context, payload) => QadashboardmapperPlaceholder(data: payload),
    'qaManagerDashboardViewModel': (context, payload) => const QaDashboardScreen(),
    'qaManagerDashboardViewModelAdapter': (context, payload) => QadashboardadapterPlaceholder(data: payload),

    'complianceManagerDashboardAdapter': (context, payload) => CompliancemanagerdashboardadapterPlaceholder(data: payload),
    'complianceManagerDashboardDto': (context, payload) => CompliancemanagerdashboarddtoPlaceholder(data: payload),
    'complianceManagerDashboardDtoAdapter': (context, payload) => CompliancemanagerdashboarddtoadapterPlaceholder(data: payload),
    'complianceManagerDashboardMapper': (context, payload) => CompliancemanagerdashboardmapperPlaceholder(data: payload),
    'complianceManagerDashboardViewModel': (context, payload) => const ComplianceManagerDashboardScreen(),

    'infectionControlDashboardAdapter': (context, payload) => BasePlaceholder(name: 'InfectionControlDashboardAdapter', data: payload),
    'infectionControlDashboardDto': (context, payload) => BasePlaceholder(name: 'InfectionControlDashboardDto', data: payload),
    'infectionControlDashboardMapper': (context, payload) => BasePlaceholder(name: 'InfectionControlDashboardMapper', data: payload),
    'infectionControlDashboardViewModel': (context, payload) => const DynamicScreenDashboardScreen(),
  };
}
