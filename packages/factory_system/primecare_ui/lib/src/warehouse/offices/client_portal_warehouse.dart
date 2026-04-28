import 'package:flutter/material.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';

import 'package:primecare_ui/src/features/features_view.dart';

class ClientPortalComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'clientDashboardAdapter': (context, payload) =>
        const Text('Placeholder: Clientdashboardadapter'),
    'clientDashboardDto': (context, payload) =>
        const Text('Placeholder: Clientdashboarddto'),
    'clientDashboardDtoAdapter': (context, payload) =>
        const Text('Placeholder: Clientdashboarddtoadapter'),
    'clientDashboardMapper': (context, payload) =>
        const Text('Placeholder: Clientdashboardmapper'),
    'clientDashboardMapperAdapter': (context, payload) =>
        const Text('Placeholder: Clientdashboardmapperadapter'),
    'clientDashboardViewModel': (context, payload) =>
        const ClientDashboardView(),
    'clientDashboardViewModelAdapter': (context, payload) =>
        const Text('Placeholder: Clientdashboardviewmodeladapter'),

    'familyDashboardAdapter': (context, payload) =>
        const Text('Placeholder: Familydashboardadapter'),
    'familyDashboardDto': (context, payload) =>
        const Text('Placeholder: Familydashboarddto'),
    'familyDashboardDtoAdapter': (context, payload) =>
        const Text('Placeholder: Familydashboarddtoadapter'),
    'familyDashboardMapper': (context, payload) =>
        const Text('Placeholder: Familydashboardmapper'),
    'familyDashboardMapperAdapter': (context, payload) =>
        const Text('Placeholder: Familydashboardmapperadapter'),
    'familyDashboardViewModel': (context, payload) =>
        const FamilyDashboardView(),
    'familyDashboardViewModelAdapter': (context, payload) =>
        const Text('Placeholder: Familydashboardviewmodeladapter'),

    'guestDashboardAdapter': (context, payload) =>
        const Text('Placeholder: Guestdashboardadapter'),
    'guestDashboardDto': (context, payload) =>
        const Text('Placeholder: Guestdashboarddto'),
    'guestDashboardDtoAdapter': (context, payload) =>
        const Text('Placeholder: Guestdashboarddtoadapter'),
    'guestDashboardMapper': (context, payload) =>
        const Text('Placeholder: Guestdashboardmapper'),
    'guestDashboardMapperAdapter': (context, payload) =>
        const Text('Placeholder: Guestdashboardmapperadapter'),
    'guestDashboardViewModel': (context, payload) => const GuestDashboardView(),
    'guestDashboardViewModelAdapter': (context, payload) =>
        const Text('Placeholder: Guestdashboardviewmodeladapter'),

    'patientDashboardAdapter': (context, payload) =>
        const Text('Placeholder: Patientdashboardadapter'),
    'patientDashboardDto': (context, payload) =>
        const Text('Placeholder: Patientdashboarddto'),
    'patientDashboardDtoAdapter': (context, payload) =>
        const Text('Placeholder: Patientdashboarddtoadapter'),
    'patientDashboardMapper': (context, payload) =>
        const Text('Placeholder: Patientdashboardmapper'),
    'patientDashboardMapperAdapter': (context, payload) =>
        const Text('Placeholder: Patientdashboardmapperadapter'),
    'patientDashboardViewModel': (context, payload) =>
        const PatientDashboardView(),
    'patientDashboardViewModelAdapter': (context, payload) =>
        const Text('Placeholder: Patientdashboardviewmodeladapter'),

    'clientLayout': (context, payload) =>
        const Text('Placeholder: Clientlayout'),
    'patientLayout': (context, payload) =>
        const Text('Placeholder: Patientlayout'),
    'familyPortalLayout': (context, payload) =>
        const Text('Placeholder: Familyportallayout'),
    'guestLayout': (context, payload) => const Text('Placeholder: Guestlayout'),

    'viewCarePlanForm': (context, payload) =>
        const Text('Placeholder: Viewcareplanform'),
    'submitPatientFeedbackForm': (context, payload) =>
        const Text('Placeholder: Submitpatientfeedbackform'),
    'requestAppointmentForm': (context, payload) =>
        const Text('Placeholder: Requestappointmentform'),
    'viewMedicalRecordsForm': (context, payload) =>
        const Text('Placeholder: Viewmedicalrecordsform'),
    'updatePersonalProfileForm': (context, payload) =>
        const Text('Placeholder: Updatepersonalprofileform'),
    'billingPaymentForm': (context, payload) =>
        const Text('BillingPaymentForm'),
    'approveMedicationRefillForm': (context, payload) =>
        const Text('Placeholder: Approvemedicationrefillform'),
  };
}
