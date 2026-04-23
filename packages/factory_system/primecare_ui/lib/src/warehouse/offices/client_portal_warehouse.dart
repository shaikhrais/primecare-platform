// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/warehouse/01_I_component_warehouse.dart';
import 'package:primecare_ui/src/warehouse/offices/base_office_warehouse.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';
import 'package:primecare_ui/src/features/features_manifest.dart';
import 'package:primecare_ui/src/components/forms/01_I_billing_payment_form.dart';

class ClientPortalComponentWarehouse extends BaseOfficeWarehouse {
  @override
  Map<String, ComponentBuilder> get builders => {
    'clientDashboardAdapter': (context, payload) => ClientdashboardadapterPlaceholder(data: payload),
    'clientDashboardDto': (context, payload) => ClientdashboarddtoPlaceholder(data: payload),
    'clientDashboardDtoAdapter': (context, payload) => ClientdashboarddtoadapterPlaceholder(data: payload),
    'clientDashboardMapper': (context, payload) => ClientdashboardmapperPlaceholder(data: payload),
    'clientDashboardMapperAdapter': (context, payload) => ClientdashboardmapperadapterPlaceholder(data: payload),
    'clientDashboardViewModel': (context, payload) => const ClientDashboardScreen(),
    'clientDashboardViewModelAdapter': (context, payload) => ClientdashboardviewmodeladapterPlaceholder(data: payload),

    'familyDashboardAdapter': (context, payload) => FamilydashboardadapterPlaceholder(data: payload),
    'familyDashboardDto': (context, payload) => FamilydashboarddtoPlaceholder(data: payload),
    'familyDashboardDtoAdapter': (context, payload) => FamilydashboarddtoadapterPlaceholder(data: payload),
    'familyDashboardMapper': (context, payload) => FamilydashboardmapperPlaceholder(data: payload),
    'familyDashboardMapperAdapter': (context, payload) => FamilydashboardmapperadapterPlaceholder(data: payload),
    'familyDashboardViewModel': (context, payload) => const FamilyDashboardScreen(),
    'familyDashboardViewModelAdapter': (context, payload) => FamilydashboardviewmodeladapterPlaceholder(data: payload),

    'guestDashboardAdapter': (context, payload) => GuestdashboardadapterPlaceholder(data: payload),
    'guestDashboardDto': (context, payload) => GuestdashboarddtoPlaceholder(data: payload),
    'guestDashboardDtoAdapter': (context, payload) => GuestdashboarddtoadapterPlaceholder(data: payload),
    'guestDashboardMapper': (context, payload) => GuestdashboardmapperPlaceholder(data: payload),
    'guestDashboardMapperAdapter': (context, payload) => GuestdashboardmapperadapterPlaceholder(data: payload),
    'guestDashboardViewModel': (context, payload) => const GuestDashboardScreen(),
    'guestDashboardViewModelAdapter': (context, payload) => GuestdashboardviewmodeladapterPlaceholder(data: payload),

    'patientDashboardAdapter': (context, payload) => PatientdashboardadapterPlaceholder(data: payload),
    'patientDashboardDto': (context, payload) => PatientdashboarddtoPlaceholder(data: payload),
    'patientDashboardDtoAdapter': (context, payload) => PatientdashboarddtoadapterPlaceholder(data: payload),
    'patientDashboardMapper': (context, payload) => PatientdashboardmapperPlaceholder(data: payload),
    'patientDashboardMapperAdapter': (context, payload) => PatientdashboardmapperadapterPlaceholder(data: payload),
    'patientDashboardViewModel': (context, payload) => const PatientDashboardScreen(),
    'patientDashboardViewModelAdapter': (context, payload) => PatientdashboardviewmodeladapterPlaceholder(data: payload),

    'clientLayout': (context, payload) => ClientlayoutPlaceholder(data: payload),
    'patientLayout': (context, payload) => PatientlayoutPlaceholder(data: payload),
    'familyPortalLayout': (context, payload) => FamilyportallayoutPlaceholder(data: payload),
    'guestLayout': (context, payload) => GuestlayoutPlaceholder(data: payload),

    'viewCarePlanForm': (context, payload) => ViewcareplanformPlaceholder(data: payload),
    'submitPatientFeedbackForm': (context, payload) => SubmitpatientfeedbackformPlaceholder(data: payload),
    'requestAppointmentForm': (context, payload) => RequestappointmentformPlaceholder(data: payload),
    'viewMedicalRecordsForm': (context, payload) => ViewmedicalrecordsformPlaceholder(data: payload),
    'updatePersonalProfileForm': (context, payload) => UpdatepersonalprofileformPlaceholder(data: payload),
    'billingPaymentForm': (context, payload) => const BillingPaymentForm(),
    'approveMedicationRefillForm': (context, payload) => ApprovemedicationrefillformPlaceholder(data: payload),
  };
}
