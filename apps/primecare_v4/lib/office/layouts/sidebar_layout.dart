import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/glass_surface.dart';
import '../../services/auth_service.dart';
import 'sidebar_config.dart';
import '../../routes/app_routes.dart';

class SidebarLayout extends ConsumerWidget {
  const SidebarLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Fetch authorized role
    final role = ref.watch(authProvider).role ?? '';

    // 2. Extract precisely the 10-15 buttons defined for this role
    final menuItems = SidebarConfig.getMenuForRole(role);

    return GlassSurface(
      borderRadius: 0,
      hasGhostBorder: false, // "Avoid vertical lines"
      child: Container(
        width: 250,
        color: Colors.transparent, // Inherit glass blur
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 16.0),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];

            // 3. Resolve the targeted GoRouter path logically
            String targetRoute = '';
            if (item.label.toLowerCase() == 'dashboard') {
              targetRoute = AuthNotifier.getDashboardRouteForRole(role);
            } else if (role.toLowerCase() == 'ceo') {
              final label = item.label.toLowerCase();
              if (label.contains('enterprise overview')) {
                targetRoute = AppRoutes.ceoEnterpriseOverview;
              }
              if (label.contains('franchise overview')) {
                targetRoute = AppRoutes.ceoFranchiseOverview;
              }
              if (label.contains('region performance')) {
                targetRoute = AppRoutes.ceoRegionPerformance;
              }
              if (label.contains('revenue summary')) {
                targetRoute = AppRoutes.ceoRevenueSummary;
              }
              if (label.contains('strategic kpis')) {
                targetRoute = AppRoutes.ceoStrategicKpis;
              }
              if (label.contains('growth pipeline')) {
                targetRoute = AppRoutes.ceoGrowthPipeline;
              }
              if (label.contains('leadership reports')) {
                targetRoute = AppRoutes.ceoLeadershipReports;
              }
              if (label.contains('alerts & risks')) {
                targetRoute = AppRoutes.ceoAlertsAndRisks;
              }
              if (label.contains('organization map')) {
                targetRoute = AppRoutes.ceoOrganizationMap;
              }
              if (label.contains('approvals')) {
                targetRoute = AppRoutes.ceoApprovals;
              }
              if (label.contains('reports')) targetRoute = AppRoutes.ceoReports;
            } else if (role.toLowerCase() == 'coo') {
              final label = item.label.toLowerCase();
              if (label.contains('operations overview')) {
                targetRoute = AppRoutes.cooOperationsOverview;
              }
              if (label.contains('branch operations')) {
                targetRoute = AppRoutes.cooBranchOperations;
              }
              if (label.contains('staffing efficiency')) {
                targetRoute = AppRoutes.cooStaffingEfficiency;
              }
              if (label.contains('scheduling health')) {
                targetRoute = AppRoutes.cooSchedulingHealth;
              }
              if (label.contains('service delivery')) {
                targetRoute = AppRoutes.cooServiceDelivery;
              }
              if (label.contains('issue escalations')) {
                targetRoute = AppRoutes.cooIssueEscalations;
              }
              if (label.contains('compliance view')) {
                targetRoute = AppRoutes.cooComplianceView;
              }
              if (label.contains('workflow performance')) {
                targetRoute = AppRoutes.cooWorkflowPerformance;
              }
              if (label.contains('branch comparison')) {
                targetRoute = AppRoutes.cooBranchComparison;
              }
              if (label.contains('reports')) targetRoute = AppRoutes.cooReports;
            } else if (role.toLowerCase() == 'cfo') {
              final label = item.label.toLowerCase();
              if (label.contains('financial overview')) {
                targetRoute = AppRoutes.cfoFinancialOverview;
              }
              if (label.contains('revenue')) targetRoute = AppRoutes.cfoRevenue;
              if (label.contains('expenses')) {
                targetRoute = AppRoutes.cfoExpenses;
              }
              if (label.contains('franchise financials')) {
                targetRoute = AppRoutes.cfoFranchiseFinancials;
              }
              if (label.contains('payroll')) targetRoute = AppRoutes.cfoPayroll;
              if (label.contains('accounts receivable')) {
                targetRoute = AppRoutes.cfoAccountsReceivable;
              }
              if (label.contains('accounts payable')) {
                targetRoute = AppRoutes.cfoAccountsPayable;
              }
              if (label.contains('invoices')) {
                targetRoute = AppRoutes.cfoInvoices;
              }
              if (label.contains('profitability')) {
                targetRoute = AppRoutes.cfoProfitability;
              }
              if (label.contains('tax & remittance')) {
                targetRoute = AppRoutes.cfoTaxAndRemittance;
              }
              if (label.contains('reports')) targetRoute = AppRoutes.cfoReports;
            } else if (role.toLowerCase() == 'cto') {
              final label = item.label.toLowerCase();
              if (label.contains('system health')) {
                targetRoute = AppRoutes.ctoSystemHealth;
              }
              if (label.contains('platform usage')) {
                targetRoute = AppRoutes.ctoPlatformUsage;
              }
              if (label.contains('feature adoption')) {
                targetRoute = AppRoutes.ctoFeatureAdoption;
              }
              if (label.contains('api monitoring')) {
                targetRoute = AppRoutes.ctoApiMonitoring;
              }
              if (label.contains('integrations')) {
                targetRoute = AppRoutes.ctoIntegrations;
              }
              if (label.contains('audit logs')) {
                targetRoute = AppRoutes.ctoAuditLogs;
              }
              if (label.contains('access control')) {
                targetRoute = AppRoutes.ctoAccessControl;
              }
              if (label.contains('release management')) {
                targetRoute = AppRoutes.ctoReleaseManagement;
              }
              if (label.contains('issue tracking')) {
                targetRoute = AppRoutes.ctoIssueTracking;
              }
              if (label.contains('infrastructure')) {
                targetRoute = AppRoutes.ctoInfrastructure;
              }
              if (label.contains('reports')) targetRoute = AppRoutes.ctoReports;
            } else if (role.toLowerCase() == 'compliance manager') {
              final label = item.label.toLowerCase();
              if (label.contains('compliance cases')) {
                targetRoute = AppRoutes.complianceManagerComplianceCases;
              }
              if (label.contains('policies')) {
                targetRoute = AppRoutes.complianceManagerPolicies;
              }
              if (label.contains('audits')) {
                targetRoute = AppRoutes.complianceManagerAudits;
              }
              if (label.contains('incident review')) {
                targetRoute = AppRoutes.complianceManagerIncidentReview;
              }
              if (label.contains('credential tracking')) {
                targetRoute = AppRoutes.complianceManagerCredentialTracking;
              }
              if (label.contains('document expiry')) {
                targetRoute = AppRoutes.complianceManagerDocumentExpiry;
              }
              if (label.contains('risk register')) {
                targetRoute = AppRoutes.complianceManagerRiskRegister;
              }
              if (label.contains('corrective actions')) {
                targetRoute = AppRoutes.complianceManagerCorrectiveActions;
              }
              if (label.contains('training compliance')) {
                targetRoute = AppRoutes.complianceManagerTrainingCompliance;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.complianceManagerReports;
              }
            } else if (role.toLowerCase() == 'head of business development') {
              final label = item.label.toLowerCase();
              if (label.contains('lead pipeline')) {
                targetRoute = AppRoutes.headOfBusinessDevelopmentLeadPipeline;
              }
              if (label.contains('franchise pipeline')) {
                targetRoute =
                    AppRoutes.headOfBusinessDevelopmentFranchisePipeline;
              }
              if (label.contains('territory map')) {
                targetRoute = AppRoutes.headOfBusinessDevelopmentTerritoryMap;
              }
              if (label.contains('partnerships')) {
                targetRoute = AppRoutes.headOfBusinessDevelopmentPartnerships;
              }
              if (label.contains('opportunities')) {
                targetRoute = AppRoutes.headOfBusinessDevelopmentOpportunities;
              }
              if (label.contains('sales performance')) {
                targetRoute =
                    AppRoutes.headOfBusinessDevelopmentSalesPerformance;
              }
              if (label.contains('expansion forecast')) {
                targetRoute =
                    AppRoutes.headOfBusinessDevelopmentExpansionForecast;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.headOfBusinessDevelopmentReports;
              }
            } else if (role.toLowerCase() == 'head of marketing') {
              final label = item.label.toLowerCase();
              if (label.contains('campaigns')) {
                targetRoute = AppRoutes.headOfMarketingCampaigns;
              }
              if (label.contains('leads')) {
                targetRoute = AppRoutes.headOfMarketingLeads;
              }
              if (label.contains('funnel analytics')) {
                targetRoute = AppRoutes.headOfMarketingFunnelAnalytics;
              }
              if (label.contains('brand assets')) {
                targetRoute = AppRoutes.headOfMarketingBrandAssets;
              }
              if (label.contains('regional campaigns')) {
                targetRoute = AppRoutes.headOfMarketingRegionalCampaigns;
              }
              if (label.contains('content approval')) {
                targetRoute = AppRoutes.headOfMarketingContentApproval;
              }
              if (label.contains('performance reports')) {
                targetRoute = AppRoutes.headOfMarketingPerformanceReports;
              }
            } else if (role.toLowerCase() == 'training director') {
              final label = item.label.toLowerCase();
              if (label.contains('training programs')) {
                targetRoute = AppRoutes.trainingDirectorTrainingPrograms;
              }
              if (label.contains('staff training matrix')) {
                targetRoute = AppRoutes.trainingDirectorStaffTrainingMatrix;
              }
              if (label.contains('compliance training')) {
                targetRoute = AppRoutes.trainingDirectorComplianceTraining;
              }
              if (label.contains('course library')) {
                targetRoute = AppRoutes.trainingDirectorCourseLibrary;
              }
              if (label.contains('assessments')) {
                targetRoute = AppRoutes.trainingDirectorAssessments;
              }
              if (label.contains('certifications')) {
                targetRoute = AppRoutes.trainingDirectorCertifications;
              }
              if (label.contains('trainer assignments')) {
                targetRoute = AppRoutes.trainingDirectorTrainerAssignments;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.trainingDirectorReports;
              }
            } else if (role.toLowerCase() == 'regional bdm') {
              final label = item.label.toLowerCase();
              if (label.contains('leads')) {
                targetRoute = AppRoutes.regionalBdmLeads;
              }
              if (label.contains('franchise pipeline')) {
                targetRoute = AppRoutes.regionalBdmFranchisePipeline;
              }
              if (label.contains('territory growth')) {
                targetRoute = AppRoutes.regionalBdmTerritoryGrowth;
              }
              if (label.contains('meetings')) {
                targetRoute = AppRoutes.regionalBdmMeetings;
              }
              if (label.contains('deal tracker')) {
                targetRoute = AppRoutes.regionalBdmDealTracker;
              }
              if (label.contains('partners')) {
                targetRoute = AppRoutes.regionalBdmPartners;
              }
              if (label.contains('competitor notes')) {
                targetRoute = AppRoutes.regionalBdmCompetitorNotes;
              }
              if (label.contains('tasks')) {
                targetRoute = AppRoutes.regionalBdmTasks;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.regionalBdmReports;
              }
            } else if (role.toLowerCase() == 'franchise sales manager') {
              final label = item.label.toLowerCase();
              if (label.contains('leads')) {
                targetRoute = AppRoutes.franchiseSalesManagerLeads;
              }
              if (label.contains('prospects')) {
                targetRoute = AppRoutes.franchiseSalesManagerProspects;
              }
              if (label.contains('discovery calls')) {
                targetRoute = AppRoutes.franchiseSalesManagerDiscoveryCalls;
              }
              if (label.contains('proposals')) {
                targetRoute = AppRoutes.franchiseSalesManagerProposals;
              }
              if (label.contains('sales pipeline')) {
                targetRoute = AppRoutes.franchiseSalesManagerSalesPipeline;
              }
              if (label.contains('contracts')) {
                targetRoute = AppRoutes.franchiseSalesManagerContracts;
              }
              if (label.contains('follow-ups')) {
                targetRoute = AppRoutes.franchiseSalesManagerFollowUps;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.franchiseSalesManagerReports;
              }
            } else if (role.toLowerCase() == 'partnership manager') {
              final label = item.label.toLowerCase();
              if (label.contains('partners')) {
                targetRoute = AppRoutes.partnershipManagerPartners;
              }
              if (label.contains('outreach')) {
                targetRoute = AppRoutes.partnershipManagerOutreach;
              }
              if (label.contains('active deals')) {
                targetRoute = AppRoutes.partnershipManagerActiveDeals;
              }
              if (label.contains('proposals')) {
                targetRoute = AppRoutes.partnershipManagerProposals;
              }
              if (label.contains('renewals')) {
                targetRoute = AppRoutes.partnershipManagerRenewals;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.partnershipManagerReports;
              }
            } else if (role.toLowerCase() == 'territory expansion manager') {
              final label = item.label.toLowerCase();
              if (label.contains('territory map')) {
                targetRoute = AppRoutes.territoryExpansionManagerTerritoryMap;
              }
              if (label.contains('market research')) {
                targetRoute = AppRoutes.territoryExpansionManagerMarketResearch;
              }
              if (label.contains('demographics')) {
                targetRoute = AppRoutes.territoryExpansionManagerDemographics;
              }
              if (label.contains('open territories')) {
                targetRoute =
                    AppRoutes.territoryExpansionManagerOpenTerritories;
              }
              if (label.contains('expansion plans')) {
                targetRoute = AppRoutes.territoryExpansionManagerExpansionPlans;
              }
              if (label.contains('site selection')) {
                targetRoute = AppRoutes.territoryExpansionManagerSiteSelection;
              }
              if (label.contains('forecast')) {
                targetRoute = AppRoutes.territoryExpansionManagerForecast;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.territoryExpansionManagerReports;
              }
            } else if (role.toLowerCase() == 'franchise owner') {
              final label = item.label.toLowerCase();
              if (label.contains('branch overview')) {
                targetRoute = AppRoutes.franchiseOwnerBranchOverview;
              }
              if (label.contains('financial snapshot')) {
                targetRoute = AppRoutes.franchiseOwnerFinancialSnapshot;
              }
              if (label.contains('staff')) {
                targetRoute = AppRoutes.franchiseOwnerStaff;
              }
              if (label.contains('appointments')) {
                targetRoute = AppRoutes.franchiseOwnerAppointments;
              }
              if (label.contains('clients')) {
                targetRoute = AppRoutes.franchiseOwnerClients;
              }
              if (label.contains('compliance')) {
                targetRoute = AppRoutes.franchiseOwnerCompliance;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.franchiseOwnerReports;
              }
              if (label.contains('hiring')) {
                targetRoute = AppRoutes.franchiseOwnerHiring;
              }
            } else if (role.toLowerCase() == 'operations manager') {
              final label = item.label.toLowerCase();
              if (label.contains('daily operations')) {
                targetRoute = AppRoutes.operationsManagerDailyOperations;
              }
              if (label.contains('schedule')) {
                targetRoute = AppRoutes.operationsManagerSchedule;
              }
              if (label.contains('shifts')) {
                targetRoute = AppRoutes.operationsManagerShifts;
              }
              if (label.contains('issues')) {
                targetRoute = AppRoutes.operationsManagerIssues;
              }
              if (label.contains('service quality')) {
                targetRoute = AppRoutes.operationsManagerServiceQuality;
              }
              if (label.contains('staff coordination')) {
                targetRoute = AppRoutes.operationsManagerStaffCoordination;
              }
              if (label.contains('attendance')) {
                targetRoute = AppRoutes.operationsManagerAttendance;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.operationsManagerReports;
              }
            } else if (role.toLowerCase() == 'scheduler / coordinator') {
              final label = item.label.toLowerCase();
              if (label.contains('appointment calendar')) {
                targetRoute = AppRoutes.schedulerCoordinatorAppointmentCalendar;
              }
              if (label.contains('shift calendar')) {
                targetRoute = AppRoutes.schedulerCoordinatorShiftCalendar;
              }
              if (label.contains('provider availability')) {
                targetRoute =
                    AppRoutes.schedulerCoordinatorProviderAvailability;
              }
              if (label.contains('booking requests')) {
                targetRoute = AppRoutes.schedulerCoordinatorBookingRequests;
              }
              if (label.contains('open shifts')) {
                targetRoute = AppRoutes.schedulerCoordinatorOpenShifts;
              }
              if (label.contains('assignments')) {
                targetRoute = AppRoutes.schedulerCoordinatorAssignments;
              }
              if (label.contains('conflicts')) {
                targetRoute = AppRoutes.schedulerCoordinatorConflicts;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.schedulerCoordinatorReports;
              }
            } else if (role.toLowerCase() == 'admin') {
              final label = item.label.toLowerCase();
              if (label.contains('invoices')) {
                targetRoute = AppRoutes.adminInvoices;
              }
              if (label.contains('payments')) {
                targetRoute = AppRoutes.adminPayments;
              }
              if (label.contains('claims')) targetRoute = AppRoutes.adminClaims;
              if (label.contains('reconciliation')) {
                targetRoute = AppRoutes.adminReconciliation;
              }
              if (label.contains('outstanding balances')) {
                targetRoute = AppRoutes.adminOutstandingBalances;
              }
              if (label.contains('refunds')) {
                targetRoute = AppRoutes.adminRefunds;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.adminReports;
              }
            } else if (role.toLowerCase() == 'hr / hiring') {
              final label = item.label.toLowerCase();
              if (label.contains('applicants')) {
                targetRoute = AppRoutes.hrHiringApplicants;
              }
              if (label.contains('interviews')) {
                targetRoute = AppRoutes.hrHiringInterviews;
              }
              if (label.contains('offers')) {
                targetRoute = AppRoutes.hrHiringOffers;
              }
              if (label.contains('onboarding')) {
                targetRoute = AppRoutes.hrHiringOnboarding;
              }
              if (label.contains('staff documents')) {
                targetRoute = AppRoutes.hrHiringStaffDocuments;
              }
              if (label.contains('credentials')) {
                targetRoute = AppRoutes.hrHiringCredentials;
              }
              if (label.contains('training status')) {
                targetRoute = AppRoutes.hrHiringTrainingStatus;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.hrHiringReports;
              }
            } else if (role.toLowerCase() == 'rn') {
              final label = item.label.toLowerCase();
              if (label.contains('todays schedule')) {
                targetRoute = AppRoutes.rnTodaysSchedule;
              }
              if (label.contains('assigned clients')) {
                targetRoute = AppRoutes.rnAssignedClients;
              }
              if (label.contains('nursing notes')) {
                targetRoute = AppRoutes.rnNursingNotes;
              }
              if (label.contains('care plans')) {
                targetRoute = AppRoutes.rnCarePlans;
              }
              if (label.contains('medication notes')) {
                targetRoute = AppRoutes.rnMedicationNotes;
              }
              if (label.contains('vitals')) targetRoute = AppRoutes.rnVitals;
              if (label.contains('incident reports')) {
                targetRoute = AppRoutes.rnIncidentReports;
              }
              if (label.contains('progress updates')) {
                targetRoute = AppRoutes.rnProgressUpdates;
              }
              if (label.contains('client history')) {
                targetRoute = AppRoutes.rnClientHistory;
              }
            } else if (role.toLowerCase() == 'rpn') {
              final label = item.label.toLowerCase();
              if (label.contains('todays schedule')) {
                targetRoute = AppRoutes.rpnTodaysSchedule;
              }
              if (label.contains('assigned clients')) {
                targetRoute = AppRoutes.rpnAssignedClients;
              }
              if (label.contains('nursing notes')) {
                targetRoute = AppRoutes.rpnNursingNotes;
              }
              if (label.contains('care updates')) {
                targetRoute = AppRoutes.rpnCareUpdates;
              }
              if (label.contains('vitals')) targetRoute = AppRoutes.rpnVitals;
              if (label.contains('medication support')) {
                targetRoute = AppRoutes.rpnMedicationSupport;
              }
              if (label.contains('client history')) {
                targetRoute = AppRoutes.rpnClientHistory;
              }
              if (label.contains('incident reports')) {
                targetRoute = AppRoutes.rpnIncidentReports;
              }
            } else if (role.toLowerCase() == 'rmt') {
              final label = item.label.toLowerCase();
              if (label.contains('todays schedule')) {
                targetRoute = AppRoutes.rmtTodaysSchedule;
              }
              if (label.contains('clients')) targetRoute = AppRoutes.rmtClients;
              if (label.contains('assessment')) {
                targetRoute = AppRoutes.rmtAssessment;
              }
              if (label.contains('soap notes')) {
                targetRoute = AppRoutes.rmtSoapNotes;
              }
              if (label.contains('treatment plans')) {
                targetRoute = AppRoutes.rmtTreatmentPlans;
              }
              if (label.contains('homecare')) {
                targetRoute = AppRoutes.rmtHomecare;
              }
              if (label.contains('session history')) {
                targetRoute = AppRoutes.rmtSessionHistory;
              }
              if (label.contains('body chart')) {
                targetRoute = AppRoutes.rmtBodyChart;
              }
              if (label.contains('intake forms')) {
                targetRoute = AppRoutes.rmtIntakeForms;
              }
              if (label.contains('invoices')) {
                targetRoute = AppRoutes.rmtInvoices;
              }
            } else if (role.toLowerCase() == 'psw') {
              final label = item.label.toLowerCase();
              if (label.contains('todays shifts')) {
                targetRoute = AppRoutes.pswTodaysShifts;
              }
              if (label.contains('assigned clients')) {
                targetRoute = AppRoutes.pswAssignedClients;
              }
              if (label.contains('care tasks')) {
                targetRoute = AppRoutes.pswCareTasks;
              }
              if (label.contains('adl tracking')) {
                targetRoute = AppRoutes.pswAdlTracking;
              }
              if (label.contains('daily logs')) {
                targetRoute = AppRoutes.pswDailyLogs;
              }
              if (label.contains('check in / out')) {
                targetRoute = AppRoutes.pswCheckInOut;
              }
              if (label.contains('client updates')) {
                targetRoute = AppRoutes.pswClientUpdates;
              }
              if (label.contains('incident reports')) {
                targetRoute = AppRoutes.pswIncidentReports;
              }
              if (label.contains('completed visits')) {
                targetRoute = AppRoutes.pswCompletedVisits;
              }
            } else if (role.toLowerCase() == 'customer support') {
              final label = item.label.toLowerCase();
              if (label.contains('tickets')) {
                targetRoute = AppRoutes.customerSupportTickets;
              }
              if (label.contains('escalations')) {
                targetRoute = AppRoutes.customerSupportEscalations;
              }
              if (label.contains('issue categories')) {
                targetRoute = AppRoutes.customerSupportIssueCategories;
              }
              if (label.contains('templates')) {
                targetRoute = AppRoutes.customerSupportTemplates;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.customerSupportReports;
              }
            } else if (role.toLowerCase() == 'intake coordinator') {
              final label = item.label.toLowerCase();
              if (label.contains('new intakes')) {
                targetRoute = AppRoutes.intakeCoordinatorNewIntakes;
              }
              if (label.contains('intake forms')) {
                targetRoute = AppRoutes.intakeCoordinatorIntakeForms;
              }
              if (label.contains('eligibility')) {
                targetRoute = AppRoutes.intakeCoordinatorEligibility;
              }
              if (label.contains('scheduling')) {
                targetRoute = AppRoutes.intakeCoordinatorScheduling;
              }
              if (label.contains('client assignment')) {
                targetRoute = AppRoutes.intakeCoordinatorClientAssignment;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.intakeCoordinatorReports;
              }
            } else if (role.toLowerCase() == 'quality assurance') {
              final label = item.label.toLowerCase();
              if (label.contains('audits')) {
                targetRoute = AppRoutes.qualityAssuranceAudits;
              }
              if (label.contains('reviews')) {
                targetRoute = AppRoutes.qualityAssuranceReviews;
              }
              if (label.contains('complaints')) {
                targetRoute = AppRoutes.qualityAssuranceComplaints;
              }
              if (label.contains('corrective actions')) {
                targetRoute = AppRoutes.qualityAssuranceCorrectiveActions;
              }
              if (label.contains('scorecards')) {
                targetRoute = AppRoutes.qualityAssuranceScorecards;
              }
              if (label.contains('compliance checks')) {
                targetRoute = AppRoutes.qualityAssuranceComplianceChecks;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.qualityAssuranceReports;
              }
            } else if (role.toLowerCase() == 'training coordinator') {
              final label = item.label.toLowerCase();
              if (label.contains('training schedule')) {
                targetRoute = AppRoutes.trainingCoordinatorTrainingSchedule;
              }
              if (label.contains('courses')) {
                targetRoute = AppRoutes.trainingCoordinatorCourses;
              }
              if (label.contains('progress')) {
                targetRoute = AppRoutes.trainingCoordinatorProgress;
              }
              if (label.contains('workshops')) {
                targetRoute = AppRoutes.trainingCoordinatorWorkshops;
              }
              if (label.contains('attendance')) {
                targetRoute = AppRoutes.trainingCoordinatorAttendance;
              }
              if (label.contains('materials')) {
                targetRoute = AppRoutes.trainingCoordinatorMaterials;
              }
              if (label.contains('certifications')) {
                targetRoute = AppRoutes.trainingCoordinatorCertifications;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.trainingCoordinatorReports;
              }
            } else if (role.toLowerCase() == 'local marketing manager') {
              final label = item.label.toLowerCase();
              if (label.contains('campaigns')) {
                targetRoute = AppRoutes.localMarketingManagerCampaigns;
              }
              if (label.contains('leads')) {
                targetRoute = AppRoutes.localMarketingManagerLeads;
              }
              if (label.contains('content calendar')) {
                targetRoute = AppRoutes.localMarketingManagerContentCalendar;
              }
              if (label.contains('events')) {
                targetRoute = AppRoutes.localMarketingManagerEvents;
              }
              if (label.contains('budget')) {
                targetRoute = AppRoutes.localMarketingManagerBudget;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.localMarketingManagerReports;
              }
              if (label.contains('assets')) {
                targetRoute = AppRoutes.localMarketingManagerAssets;
              }
            } else if (role.toLowerCase() == 'community outreach') {
              final label = item.label.toLowerCase();
              if (label.contains('programs')) {
                targetRoute = AppRoutes.communityOutreachPrograms;
              }
              if (label.contains('events')) {
                targetRoute = AppRoutes.communityOutreachEvents;
              }
              if (label.contains('partnerships')) {
                targetRoute = AppRoutes.communityOutreachPartnerships;
              }
              if (label.contains('volunteers')) {
                targetRoute = AppRoutes.communityOutreachVolunteers;
              }
              if (label.contains('contacts')) {
                targetRoute = AppRoutes.communityOutreachContacts;
              }
              if (label.contains('follow-ups')) {
                targetRoute = AppRoutes.communityOutreachFollowUps;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.communityOutreachReports;
              }
            } else if (role.toLowerCase() == 'territory sales manager') {
              final label = item.label.toLowerCase();
              if (label.contains('leads')) {
                targetRoute = AppRoutes.territorySalesManagerLeads;
              }
              if (label.contains('pipeline')) {
                targetRoute = AppRoutes.territorySalesManagerPipeline;
              }
              if (label.contains('field activity')) {
                targetRoute = AppRoutes.territorySalesManagerFieldActivity;
              }
              if (label.contains('conversions')) {
                targetRoute = AppRoutes.territorySalesManagerConversions;
              }
              if (label.contains('area performance')) {
                targetRoute = AppRoutes.territorySalesManagerAreaPerformance;
              }
              if (label.contains('competitors')) {
                targetRoute = AppRoutes.territorySalesManagerCompetitors;
              }
              if (label.contains('reports')) {
                targetRoute = AppRoutes.territorySalesManagerReports;
              }
            } else if (role.toLowerCase() == 'client') {
              final label = item.label.toLowerCase();
              if (label.contains('book appointment')) {
                targetRoute = AppRoutes.clientBookAppointment;
              }
              if (label.contains('my appointments')) {
                targetRoute = AppRoutes.clientMyAppointments;
              }
              if (label.contains('care team')) {
                targetRoute = AppRoutes.clientCareTeam;
              }
              if (label.contains('treatment history')) {
                targetRoute = AppRoutes.clientTreatmentHistory;
              }
              if (label.contains('payments')) {
                targetRoute = AppRoutes.clientPayments;
              }
              if (label.contains('profile')) {
                targetRoute = AppRoutes.clientProfile;
              }
            } else if (role.toLowerCase() == 'family member') {
              final label = item.label.toLowerCase();
              if (label.contains('loved one schedule')) {
                targetRoute = AppRoutes.familyMemberLovedOneSchedule;
              }
              if (label.contains('care updates')) {
                targetRoute = AppRoutes.familyMemberCareUpdates;
              }
              if (label.contains('billing')) {
                targetRoute = AppRoutes.familyMemberBilling;
              }
              if (label.contains('emergency contacts')) {
                targetRoute = AppRoutes.familyMemberEmergencyContacts;
              }
              if (label.contains('profile')) {
                targetRoute = AppRoutes.familyMemberProfile;
              }
            }

            if (targetRoute.isEmpty) {
              if (item.label.toLowerCase() == 'settings') {
                targetRoute = AppRoutes.globalSettings;
              } else if (item.label.toLowerCase() == 'messages' ||
                  item.label.toLowerCase() == 'chat') {
                targetRoute = AppRoutes.messagingHub;
              } else if (item.label.toLowerCase() == 'documents') {
                targetRoute = AppRoutes.documentVault;
              } else if (item.label.toLowerCase() == 'notifications') {
                targetRoute = AppRoutes.notificationCenter;
              }
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 2.0,
              ),
              child: ListTile(
                key: const Key('data-status-id=shared-global-sidebar-action-1'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  item.icon,
                  size: 22,
                  color: const Color(0xFF006565),
                ),
                title: Text(
                  item.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Colors.blueGrey,
                  ),
                ),
                onTap: () {
                  if (targetRoute.isNotEmpty) {
                    context.go(targetRoute);
                  } else {
                    final formattedId = item.label.toLowerCase().replaceAll(
                      ' ',
                      '_',
                    );
                    context.go('/provider/feature/$formattedId');
                  }
                },
                hoverColor: const Color(0xFF006565).withValues(alpha: 0.05),
              ),
            );
          },
        ),
      ),
    );
  }
}
