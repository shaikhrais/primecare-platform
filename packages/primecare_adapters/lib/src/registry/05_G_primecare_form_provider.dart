// Layer: 05_REGISTRY_GOVERNANCE
import '../../primecare_adapters.dart';

/// Central provider that resolves the appropriate hydrated adapter for a given PrimeCareForm.
/// This allows the UI to simply request a form type and receive the bound data.
final primecareFormProvider =
    Provider.family<
      FutureProvider<Result<PrimeCareDashboardViewModel>>,
      PrimeCareForm
    >((ref, form) {
      switch (form) {
        case PrimeCareForm.ceoDashboard:
          return ceoDashboardAdapterProvider;
        case PrimeCareForm.cfoDashboard:
          return cfoDashboardAdapterProvider;
        case PrimeCareForm.cooDashboard:
          return cooDashboardAdapterProvider;
        case PrimeCareForm.ctoDashboard:
          return ctoDashboardAdapterProvider;
        case PrimeCareForm.complianceManagerDashboard:
          return complianceManagerDashboardAdapterProvider;
        case PrimeCareForm.financeDirectorDashboard:
          return financeDirectorDashboardAdapterProvider;
        case PrimeCareForm.trainingDirectorDashboard:
          return trainingDirectorDashboardAdapterProvider;
        case PrimeCareForm.trainingHub:
          return trainingHubAdapterProvider;
        case PrimeCareForm.courseArchitectTool:
          return courseArchitectAdapterProvider;
        case PrimeCareForm.generalManagerDashboard:
          return generalManagerDashboardAdapterProvider;
        case PrimeCareForm.clinicDashboard:
          return clinicDashboardAdapterProvider;
        case PrimeCareForm.patientDashboard:
          return patientDashboardAdapterProvider;
        case PrimeCareForm.familyDashboard:
          return familyDashboardAdapterProvider;
        case PrimeCareForm.clientDashboard:
          return clientDashboardAdapterProvider;
        case PrimeCareForm.guestDashboard:
          return guestDashboardAdapterProvider;
        case PrimeCareForm.intakeDashboard:
          return intakeDashboardAdapterProvider;
        case PrimeCareForm.qaDashboard:
          return qaDashboardAdapterProvider;
        case PrimeCareForm.customerSupportDashboard:
          return customerSupportDashboardAdapterProvider;
        case PrimeCareForm.trainingCoordinatorDashboard:
          return trainingCoordinatorDashboardAdapterProvider;
        case PrimeCareForm.billingAdminDashboard:
          return billingAdminDashboardAdapterProvider;
        case PrimeCareForm.hrHiringDashboard:
          return hrHiringDashboardAdapterProvider;
        case PrimeCareForm.operationsManagerDashboard:
          return operationsManagerDashboardAdapterProvider;
        case PrimeCareForm.ownerDashboard:
          return ownerDashboardAdapterProvider;
        case PrimeCareForm.communityOutreachDashboard:
          return communityOutreachDashboardAdapterProvider;
        case PrimeCareForm.headOfMarketingDashboard:
          return headOfMarketingDashboardAdapterProvider;
        case PrimeCareForm.localMarketingManagerDashboard:
          return localMarketingManagerDashboardAdapterProvider;
        case PrimeCareForm.verifyCertificateForm:
          return verifyCertificateFormAdapterProvider;
        default:
          // Fallback to generic dashboard adapter for remaining forms (e.g. specialized screens)
          return genericDashboardAdapterProvider(form);
      }
    });
