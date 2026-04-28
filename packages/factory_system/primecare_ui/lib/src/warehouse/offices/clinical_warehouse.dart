import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
// import 'package:primecare_ui/src/components/generated_placeholders/primecare_placeholders.dart';
// import 'package:primecare_ui/src/features/features_manifest.dart';
// import 'package:primecare_ui/src/components/forms/clinical/patient_intake_form.dart';
// import 'package:primecare_ui/src/components/forms/clinical/vitals_capture_form.dart';
// import 'package:primecare_ui/src/components/forms/clinical_incident_form.dart';
// import 'package:primecare_ui/src/components/forms/medication_administration_form.dart';

class ClinicalComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'clinicDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'clinicDashboardDto': (context, payload) => const SizedBox.shrink(),
    'clinicDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'clinicDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'clinicDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'clinicDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'clinicDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'clinicalIncidentForm': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardDto': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardDtoAdapter': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardMapperAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'intakeDashboardViewModel': (context, payload) => const SizedBox.shrink(),
    'intakeDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'patientIntakeForm': (context, payload) => const SizedBox.shrink(),
    'vitalsCaptureForm': (context, payload) => const SizedBox.shrink(),
    'medicationAdministrationForm': (context, payload) =>
        const SizedBox.shrink(),

    'logClinicalIncidentForm': (context, payload) => const SizedBox.shrink(),
    'logInfectionControlForm': (context, payload) => const SizedBox.shrink(),
    'carePlanEvaluationForm': (context, payload) => const SizedBox.shrink(),
    'dailyVitalsCardForm': (context, payload) => const SizedBox.shrink(),

    'qaManagerDashboardAdapter': (context, payload) => const SizedBox.shrink(),
    'qaManagerDashboardDto': (context, payload) => const SizedBox.shrink(),
    'qaManagerDashboardMapper': (context, payload) => const SizedBox.shrink(),
    'qaManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),
    'qaManagerDashboardViewModelAdapter': (context, payload) =>
        const SizedBox.shrink(),

    'complianceManagerDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'complianceManagerDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'complianceManagerDashboardDtoAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'complianceManagerDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'complianceManagerDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),

    'infectionControlDashboardAdapter': (context, payload) =>
        const SizedBox.shrink(),
    'infectionControlDashboardDto': (context, payload) =>
        const SizedBox.shrink(),
    'infectionControlDashboardMapper': (context, payload) =>
        const SizedBox.shrink(),
    'infectionControlDashboardViewModel': (context, payload) =>
        const SizedBox.shrink(),
  };
}
