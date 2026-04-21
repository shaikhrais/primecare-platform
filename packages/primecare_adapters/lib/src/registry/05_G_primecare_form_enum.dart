// Layer: 05_REGISTRY_GOVERNANCE

/// Registry of all hydrated data-bound adapters on the PrimeCare Platform.
/// This enum drives the dynamic dashboard orchestration engine.
enum PrimeCareForm {
  ceoDashboard,
  cfoDashboard,
  cooDashboard,
  ctoDashboard,
  complianceManagerDashboard,
  financeDirectorDashboard,
  regionalBdmDashboard,
  franchiseOwnerDashboard,
  operationsManagerDashboard,
  hrManagerDashboard,
  schedulerDashboard,
  billingAdminDashboard,
  clinicDashboard,
  patientDashboard,
  customerSupportDashboard,
  intakeDashboard,
  qaDashboard,
  localMarketingDashboard,
  territoryExpansionDashboard,
  trainingDirectorDashboard,
  // ... more added as platform scales
}

extension PrimeCareFormExtension on PrimeCareForm {
  String get route {
    switch (this) {
      case PrimeCareForm.ceoDashboard: return 'CEO';
      case PrimeCareForm.cfoDashboard: return 'CFO';
      case PrimeCareForm.cooDashboard: return 'COO';
      case PrimeCareForm.ctoDashboard: return 'CTO';
      case PrimeCareForm.complianceManagerDashboard: return 'COMPLIANCE_MANAGER';
      case PrimeCareForm.financeDirectorDashboard: return 'FINANCE_DIRECTOR';
      case PrimeCareForm.regionalBdmDashboard: return 'REGIONAL_BDM';
      case PrimeCareForm.franchiseOwnerDashboard: return 'FRANCHISE_OWNER';
      case PrimeCareForm.operationsManagerDashboard: return 'OPERATIONS_MANAGER';
      case PrimeCareForm.hrManagerDashboard: return 'HR_MANAGER';
      case PrimeCareForm.schedulerDashboard: return 'SCHEDULER';
      case PrimeCareForm.billingAdminDashboard: return 'BILLING_ADMIN';
      case PrimeCareForm.clinicDashboard: return 'CLINIC';
      case PrimeCareForm.patientDashboard: return 'PATIENT';
      case PrimeCareForm.customerSupportDashboard: return 'CUSTOMER_SUPPORT';
      case PrimeCareForm.intakeDashboard: return 'INTAKE';
      case PrimeCareForm.qaDashboard: return 'QA';
      case PrimeCareForm.localMarketingDashboard: return 'LOCAL_MARKETING';
      case PrimeCareForm.territoryExpansionDashboard: return 'TERRITORY_EXPANSION';
      case PrimeCareForm.trainingDirectorDashboard: return 'TRAINING_DIRECTOR';
    }
  }

  String get label {
    switch (this) {
      case PrimeCareForm.ceoDashboard: return 'CEO Enterprise Overview';
      case PrimeCareForm.cfoDashboard: return 'CFO Financial Overview';
      case PrimeCareForm.cooDashboard: return 'COO Operations Health';
      case PrimeCareForm.ctoDashboard: return 'CTO Systems Monitoring';
      case PrimeCareForm.complianceManagerDashboard: return 'Compliance Audit Registry';
      case PrimeCareForm.financeDirectorDashboard: return 'Finance Director Hub';
      default: return name;
    }
  }
}
