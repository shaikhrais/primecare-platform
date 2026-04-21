// Layer: 01_INFRASTRUCTURE
import 'package:primecare_core/features/features_manifest.dart';
import 'package:flutter/material.dart';
import 'package:primecare_core/00_B_flutter_core.dart';

import 'package:primecare_ui/src/components/aura/01_I_aura_dashboard_hud.dart';
import 'package:primecare_ui/src/components/forms/clinical/01_I_patient_intake_form.dart';
import 'package:primecare_ui/src/components/forms/clinical/01_I_vitals_capture_form.dart';
import 'package:primecare_ui/src/components/forms/admin/01_I_new_staff_provisioning_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_clinical_incident_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_billing_payment_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_medication_administration_form.dart';
import 'package:primecare_ui/src/components/forms/01_I_employee_timesheet_form.dart';
import 'package:primecare_ui/src/components/generated_placeholders/01_I_primecare_placeholders.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder =
    Widget Function(BuildContext context, dynamic dataPayload);

/// A centralized registry to securely map component string types to their respective Builders.
/// This replaces large switch statements and is O(1) time complexity.
class ComponentWarehouse {
  static final Map<String, ComponentBuilder> _registry = {
    'aWSAuthContext': (context, payload) =>
        AwsauthcontextPlaceholder(data: payload),
    'aWSAuthProvider': (context, payload) =>
        AwsauthproviderPlaceholder(data: payload),
    'aWSAuthenticator': (context, payload) =>
        AwsauthenticatorPlaceholder(data: payload),
    'addFranchiseLeadForm': (context, payload) =>
        AddfranchiseleadformPlaceholder(data: payload),
    'adjustFontSize': (context, payload) =>
        AdjustfontsizePlaceholder(data: payload),
    'adminDashboardAdapter': (context, payload) =>
        AdmindashboardadapterPlaceholder(data: payload),
    'adminDashboardDto': (context, payload) =>
        AdmindashboarddtoPlaceholder(data: payload),
    'adminDashboardDtoAdapter': (context, payload) =>
        AdmindashboarddtoadapterPlaceholder(data: payload),
    'adminDashboardMapper': (context, payload) =>
        AdmindashboardmapperPlaceholder(data: payload),
    'adminDashboardMapperAdapter': (context, payload) =>
        AdmindashboardmapperadapterPlaceholder(data: payload),
    'adminDashboardViewModel': (context, payload) =>
        AdmindashboardviewmodelPlaceholder(data: payload),
    'adminDashboardViewModelAdapter': (context, payload) =>
        AdmindashboardviewmodeladapterPlaceholder(data: payload),
    'adminLayout': (context, payload) => AdminlayoutPlaceholder(data: payload),
    'adminReconciliationDashboardAdapter': (context, payload) =>
        AdminreconciliationdashboardadapterPlaceholder(data: payload),
    'adminReconciliationDashboardDto': (context, payload) =>
        AdminreconciliationdashboarddtoPlaceholder(data: payload),
    'adminReconciliationDashboardMapper': (context, payload) =>
        AdminreconciliationdashboardmapperPlaceholder(data: payload),
    'alignCenterIcon': (context, payload) =>
        AligncentericonPlaceholder(data: payload),
    'alignJustifyIcon': (context, payload) =>
        AlignjustifyiconPlaceholder(data: payload),
    'alignLeftIcon': (context, payload) =>
        AlignlefticonPlaceholder(data: payload),
    'alignRightIcon': (context, payload) =>
        AlignrighticonPlaceholder(data: payload),
    'app': (context, payload) => AppScreen(data: payload),
    'approveExpenseReimbursementForm': (context, payload) =>
        ApproveexpensereimbursementformPlaceholder(data: payload),
    'approveFranchiseDisclosureForm': (context, payload) =>
        ApprovefranchisedisclosureformPlaceholder(data: payload),
    'approveLeaveRequestForm': (context, payload) =>
        ApproveleaverequestformPlaceholder(data: payload),
    'approveMedicationRefillForm': (context, payload) =>
        ApprovemedicationrefillformPlaceholder(data: payload),
    'approvePayrollRunForm': (context, payload) =>
        ApprovepayrollrunformPlaceholder(data: payload),
    'approveRealEstateForm': (context, payload) =>
        ApproverealestateformPlaceholder(data: payload),
    'approveSystemAccessForm': (context, payload) =>
        ApprovesystemaccessformPlaceholder(data: payload),
    'arrowLeftIcon': (context, payload) =>
        ArrowlefticonPlaceholder(data: payload),
    'assignCarePodForm': (context, payload) =>
        AssigncarepodformPlaceholder(data: payload),
    'assignLeadForm': (context, payload) =>
        AssignleadformPlaceholder(data: payload),
    'assignTrainingModuleForm': (context, payload) =>
        AssigntrainingmoduleformPlaceholder(data: payload),
    'auditComplianceForm': (context, payload) =>
        AuditcomplianceformPlaceholder(data: payload),
    'auditGlobalEducationForm': (context, payload) =>
        AuditglobaleducationformPlaceholder(data: payload),
    'auditOverrideForm': (context, payload) =>
        AuditoverrideformPlaceholder(data: payload),
    'auditPayrollDiscrepancyForm': (context, payload) =>
        AuditpayrolldiscrepancyformPlaceholder(data: payload),
    'auditRoyaltyPaymentForm': (context, payload) =>
        AuditroyaltypaymentformPlaceholder(data: payload),
    'auditSecurityComplianceForm': (context, payload) =>
        AuditsecuritycomplianceformPlaceholder(data: payload),
    'auditSystemLogsForm': (context, payload) =>
        AuditsystemlogsformPlaceholder(data: payload),
    'authLayout': (context, payload) => AuthlayoutPlaceholder(data: payload),
    'authPagesMessageSection': (context, payload) =>
        AuthpagesmessagesectionPlaceholder(data: payload),
    'authSplitLayout': (context, payload) =>
        AuthsplitlayoutPlaceholder(data: payload),
    'authentication': (context, payload) => AuthenticationScreen(data: payload),
    'awsSignInTab': (context, payload) =>
        AwssignintabPlaceholder(data: payload),
    'awsSignUpTab': (context, payload) =>
        AwssignuptabPlaceholder(data: payload),
    'banIcon': (context, payload) => BaniconPlaceholder(data: payload),
    'baseForm': (context, payload) => BaseformPlaceholder(data: payload),
    'billingAdminDashboardAdapter': (context, payload) =>
        BillingadmindashboardadapterPlaceholder(data: payload),
    'billingAdminDashboardDto': (context, payload) =>
        BillingadmindashboarddtoPlaceholder(data: payload),
    'billingAdminDashboardDtoAdapter': (context, payload) =>
        BillingadmindashboarddtoadapterPlaceholder(data: payload),
    'billingAdminDashboardMapper': (context, payload) =>
        BillingadmindashboardmapperPlaceholder(data: payload),
    'billingAdminDashboardMapperAdapter': (context, payload) =>
        BillingadmindashboardmapperadapterPlaceholder(data: payload),
    'billingAdminDashboardViewModel': (context, payload) =>
        BillingAdminDashboardScreen(data: payload),
    'blockQuoteIcon': (context, payload) =>
        BlockquoteiconPlaceholder(data: payload),
    'boldIcon': (context, payload) => BoldiconPlaceholder(data: payload),
    'button': (context, payload) => ButtonScreen(data: payload),
    'carePlanEvaluationForm': (context, payload) =>
        CareplanevaluationformPlaceholder(data: payload),
    'ceoDashboardAdapter': (context, payload) =>
        CeodashboardadapterPlaceholder(data: payload),
    'ceoDashboardDto': (context, payload) =>
        CeodashboarddtoPlaceholder(data: payload),
    'ceoDashboardDtoAdapter': (context, payload) =>
        CeodashboarddtoadapterPlaceholder(data: payload),
    'ceoDashboardMapper': (context, payload) =>
        CeodashboardmapperPlaceholder(data: payload),
    'ceoDashboardMapperAdapter': (context, payload) =>
        CeodashboardmapperadapterPlaceholder(data: payload),
    'ceoDashboardProvider': (context, payload) =>
        CeodashboardproviderPlaceholder(data: payload),
    'ceoDashboardScreen': (context, payload) =>
        CeoDashboardScreen(data: payload as DashboardMetrics?),
    'ceoDashboardViewModel': (context, payload) =>
        CeoDashboardScreen(data: payload as DashboardMetrics?),
    'ceoDashboardViewModelAdapter': (context, payload) =>
        CeodashboardviewmodeladapterPlaceholder(data: payload),
    'cfoDashboardAdapter': (context, payload) =>
        CfodashboardadapterPlaceholder(data: payload),
    'cfoDashboardDto': (context, payload) =>
        CfodashboarddtoPlaceholder(data: payload),
    'cfoDashboardDtoAdapter': (context, payload) =>
        CfodashboarddtoadapterPlaceholder(data: payload),
    'cfoDashboardMapper': (context, payload) =>
        CfodashboardmapperPlaceholder(data: payload),
    'cfoDashboardMapperAdapter': (context, payload) =>
        CfodashboardmapperadapterPlaceholder(data: payload),
    'cfoDashboardProvider': (context, payload) =>
        CfodashboardproviderPlaceholder(data: payload),
    'cfoDashboardScreen': (context, payload) =>
        CfoDashboardScreen(data: payload),
    'cfoDashboardViewModel': (context, payload) =>
        CfoDashboardScreen(data: payload),
    'cfoDashboardViewModelAdapter': (context, payload) =>
        CfodashboardviewmodeladapterPlaceholder(data: payload),
    'chevronDownIcon': (context, payload) =>
        ChevrondowniconPlaceholder(data: payload),
    'clientDashboardAdapter': (context, payload) =>
        ClientdashboardadapterPlaceholder(data: payload),
    'clientDashboardDto': (context, payload) =>
        ClientdashboarddtoPlaceholder(data: payload),
    'clientDashboardDtoAdapter': (context, payload) =>
        ClientdashboarddtoadapterPlaceholder(data: payload),
    'clientDashboardMapper': (context, payload) =>
        ClientdashboardmapperPlaceholder(data: payload),
    'clientDashboardMapperAdapter': (context, payload) =>
        ClientdashboardmapperadapterPlaceholder(data: payload),
    'clientDashboardViewModel': (context, payload) =>
        ClientdashboardviewmodelPlaceholder(data: payload),
    'clientDashboardViewModelAdapter': (context, payload) =>
        ClientdashboardviewmodeladapterPlaceholder(data: payload),
    'clientLayout': (context, payload) =>
        ClientlayoutPlaceholder(data: payload),
    'clinicDashboardAdapter': (context, payload) =>
        ClinicdashboardadapterPlaceholder(data: payload),
    'clinicDashboardDto': (context, payload) =>
        ClinicdashboarddtoPlaceholder(data: payload),
    'clinicDashboardDtoAdapter': (context, payload) =>
        ClinicdashboarddtoadapterPlaceholder(data: payload),
    'clinicDashboardMapper': (context, payload) =>
        ClinicdashboardmapperPlaceholder(data: payload),
    'clinicDashboardMapperAdapter': (context, payload) =>
        ClinicdashboardmapperadapterPlaceholder(data: payload),
    'clinicDashboardViewModel': (context, payload) =>
        ClinicalDirectorDashboardScreen(data: payload),
    'clinicDashboardViewModelAdapter': (context, payload) =>
        ClinicdashboardviewmodeladapterPlaceholder(data: payload),
    'closeIcon': (context, payload) => CloseiconPlaceholder(data: payload),
    'code2Icon': (context, payload) => Code2iconPlaceholder(data: payload),
    'codeBlockIcon': (context, payload) =>
        CodeblockiconPlaceholder(data: payload),
    'communityOutreachDashboardAdapter': (context, payload) =>
        CommunityoutreachdashboardadapterPlaceholder(data: payload),
    'communityOutreachDashboardDto': (context, payload) =>
        CommunityoutreachdashboarddtoPlaceholder(data: payload),
    'communityOutreachDashboardDtoAdapter': (context, payload) =>
        CommunityoutreachdashboarddtoadapterPlaceholder(data: payload),
    'communityOutreachDashboardMapper': (context, payload) =>
        CommunityoutreachdashboardmapperPlaceholder(data: payload),
    'communityOutreachDashboardViewModel': (context, payload) =>
        CommunityoutreachdashboardviewmodelPlaceholder(data: payload),
    'complianceManagerDashboardAdapter': (context, payload) =>
        CompliancemanagerdashboardadapterPlaceholder(data: payload),
    'complianceManagerDashboardDto': (context, payload) =>
        CompliancemanagerdashboarddtoPlaceholder(data: payload),
    'complianceManagerDashboardDtoAdapter': (context, payload) =>
        CompliancemanagerdashboarddtoadapterPlaceholder(data: payload),
    'complianceManagerDashboardMapper': (context, payload) =>
        CompliancemanagerdashboardmapperPlaceholder(data: payload),
    'complianceManagerDashboardViewModel': (context, payload) =>
        ComplianceManagerDashboardScreen(data: payload),
    'configurator': (context, payload) => ConfiguratorScreen(data: payload),
    'cooDashboardAdapter': (context, payload) =>
        CoodashboardadapterPlaceholder(data: payload),
    'cooDashboardDto': (context, payload) =>
        CoodashboarddtoPlaceholder(data: payload),
    'cooDashboardDtoAdapter': (context, payload) =>
        CoodashboarddtoadapterPlaceholder(data: payload),
    'cooDashboardMapper': (context, payload) =>
        CoodashboardmapperPlaceholder(data: payload),
    'cooDashboardMapperAdapter': (context, payload) =>
        CoodashboardmapperadapterPlaceholder(data: payload),
    'cooDashboardProvider': (context, payload) =>
        CoodashboardproviderPlaceholder(data: payload),
    'cooDashboardScreen': (context, payload) =>
        CooDashboardScreen(data: payload),
    'cooDashboardViewModel': (context, payload) =>
        CooDashboardScreen(data: payload),
    'cooDashboardViewModelAdapter': (context, payload) =>
        CoodashboardviewmodeladapterPlaceholder(data: payload),
    'cornerDownLeftIcon': (context, payload) =>
        CornerdownlefticonPlaceholder(data: payload),
    'createAdPlacementForm': (context, payload) =>
        CreateadplacementformPlaceholder(data: payload),
    'createCannedResponseForm': (context, payload) =>
        CreatecannedresponseformPlaceholder(data: payload),
    'createCustomInvoiceForm': (context, payload) =>
        CreatecustominvoiceformPlaceholder(data: payload),
    'createRevenueReportForm': (context, payload) =>
        CreaterevenuereportformPlaceholder(data: payload),
    'createSupplyOrderForm': (context, payload) =>
        CreatesupplyorderformPlaceholder(data: payload),
    'ctoDashboardAdapter': (context, payload) =>
        CtodashboardadapterPlaceholder(data: payload),
    'ctoDashboardDto': (context, payload) =>
        CtodashboarddtoPlaceholder(data: payload),
    'ctoDashboardDtoAdapter': (context, payload) =>
        CtodashboarddtoadapterPlaceholder(data: payload),
    'ctoDashboardMapper': (context, payload) =>
        CtodashboardmapperPlaceholder(data: payload),
    'ctoDashboardMapperAdapter': (context, payload) =>
        CtodashboardmapperadapterPlaceholder(data: payload),
    'ctoDashboardViewModel': (context, payload) =>
        CtoDashboardScreen(data: payload),
    'trainingDirectorDashboardViewModel': (context, payload) =>
        TrainingDirectorDashboardScreenPlaceholder(data: payload),
    'ctoDashboardViewModelAdapter': (context, payload) =>
        CtodashboardviewmodeladapterPlaceholder(data: payload),
    'financeDirectorDashboardViewModel': (context, payload) =>
        FinanceDirectorDashboardScreen(data: payload),
    'customerSupportDashboardAdapter': (context, payload) =>
        CustomersupportdashboardadapterPlaceholder(data: payload),
    'customerSupportDashboardDto': (context, payload) =>
        CustomersupportdashboarddtoPlaceholder(data: payload),
    'customerSupportDashboardDtoAdapter': (context, payload) =>
        CustomersupportdashboarddtoadapterPlaceholder(data: payload),
    'customerSupportDashboardMapper': (context, payload) =>
        CustomersupportdashboardmapperPlaceholder(data: payload),
    'customerSupportDashboardViewModel': (context, payload) =>
        CustomerSupportDashboardScreen(
          data: payload as CustomerSupportDashboardViewModel?,
        ),
    'dailyVitalsCardForm': (context, payload) =>
        DailyvitalscardformPlaceholder(data: payload),
    'dataTable': (context, payload) => DatatablePlaceholder(data: payload),
    'dataTableTopToolbar': (context, payload) =>
        DatatabletoptoolbarPlaceholder(data: payload),
    'demoContent': (context, payload) => DemocontentPlaceholder(data: payload),
    'demoDashboardScreen': (context, payload) =>
        DemodashboardscreenPlaceholder(data: payload),
    'demoDashboardScreenAdapter': (context, payload) =>
        DemodashboardscreenadapterPlaceholder(data: payload),
    'demoDashboardViewModel': (context, payload) =>
        DemodashboardviewmodelPlaceholder(data: payload),
    'demoDashboardViewModelAdapter': (context, payload) =>
        DemodashboardviewmodeladapterPlaceholder(data: payload),
    'demoFrame': (context, payload) => DemoframePlaceholder(data: payload),
    'demoLayoutFooterContent': (context, payload) =>
        DemolayoutfootercontentPlaceholder(data: payload),
    'demoSidebarContent': (context, payload) =>
        DemosidebarcontentPlaceholder(data: payload),
    'disciplineLogForm': (context, payload) =>
        DisciplinelogformPlaceholder(data: payload),
    'documentationButton': (context, payload) =>
        DocumentationbuttonPlaceholder(data: payload),
    'dragAssignWidget': (context, payload) =>
        DragassignwidgetPlaceholder(data: payload),
    'dropdownMenu': (context, payload) =>
        DropdownmenuPlaceholder(data: payload),
    'dynamicRoleDashboardScreen': (context, payload) =>
        DynamicroledashboardscreenPlaceholder(data: payload),
    'dynamicRoleDashboardScreenAdapter': (context, payload) =>
        DynamicroledashboardscreenadapterPlaceholder(data: payload),
    'error401PageView': (context, payload) =>
        Error401pageviewPlaceholder(data: payload),
    'error404PageView': (context, payload) =>
        Error404pageviewPlaceholder(data: payload),
    'errorBoundary': (context, payload) =>
        ErrorboundaryPlaceholder(data: payload),
    'etaTrackerWidget': (context, payload) =>
        EtatrackerwidgetPlaceholder(data: payload),
    'exampleView': (context, payload) => ExampleviewPlaceholder(data: payload),
    'externalLinkIcon': (context, payload) =>
        ExternallinkiconPlaceholder(data: payload),
    'familyDashboardAdapter': (context, payload) =>
        FamilydashboardadapterPlaceholder(data: payload),
    'familyDashboardDto': (context, payload) =>
        FamilydashboarddtoPlaceholder(data: payload),
    'familyDashboardDtoAdapter': (context, payload) =>
        FamilydashboarddtoadapterPlaceholder(data: payload),
    'familyDashboardMapper': (context, payload) =>
        FamilydashboardmapperPlaceholder(data: payload),
    'familyDashboardMapperAdapter': (context, payload) =>
        FamilydashboardmapperadapterPlaceholder(data: payload),
    'familyDashboardViewModel': (context, payload) =>
        FamilydashboardviewmodelPlaceholder(data: payload),
    'familyDashboardViewModelAdapter': (context, payload) =>
        FamilydashboardviewmodeladapterPlaceholder(data: payload),
    'firebaseAuthContext': (context, payload) =>
        FirebaseauthcontextPlaceholder(data: payload),
    'firebaseAuthProvider': (context, payload) =>
        FirebaseauthproviderPlaceholder(data: payload),
    'firebaseSignInForm': (context, payload) =>
        FirebasesigninformPlaceholder(data: payload),
    'firebaseSignInTab': (context, payload) =>
        FirebasesignintabPlaceholder(data: payload),
    'firebaseSignUpForm': (context, payload) =>
        FirebasesignupformPlaceholder(data: payload),
    'firebaseSignUpTab': (context, payload) =>
        FirebasesignuptabPlaceholder(data: payload),
    'footerLayout1': (context, payload) =>
        Footerlayout1Placeholder(data: payload),
    'footerLayout2': (context, payload) =>
        Footerlayout2Placeholder(data: payload),
    'footerLayout3': (context, payload) =>
        Footerlayout3Placeholder(data: payload),
    'footerTheme': (context, payload) => FooterthemePlaceholder(data: payload),
    'forgotPasswordScreen': (context, payload) =>
        ForgotpasswordscreenPlaceholder(data: payload),
    'framedDemo': (context, payload) => FrameddemoPlaceholder(data: payload),
    'franchiseDashboardAdapter': (context, payload) =>
        FranchisedashboardadapterPlaceholder(data: payload),
    'franchiseDashboardDto': (context, payload) =>
        FranchisedashboarddtoPlaceholder(data: payload),
    'franchiseDashboardDtoAdapter': (context, payload) =>
        FranchisedashboarddtoadapterPlaceholder(data: payload),
    'franchiseDashboardMapper': (context, payload) =>
        FranchisedashboardmapperPlaceholder(data: payload),
    'franchiseDashboardMapperAdapter': (context, payload) =>
        FranchisedashboardmapperadapterPlaceholder(data: payload),
    'franchiseDashboardViewModel': (context, payload) =>
        FranchisedashboardviewmodelPlaceholder(data: payload),
    'franchiseDashboardViewModelAdapter': (context, payload) =>
        FranchisedashboardviewmodeladapterPlaceholder(data: payload),
    'franchiseOnboardingChecklistForm': (context, payload) =>
        FranchiseonboardingchecklistformPlaceholder(data: payload),
    'franchiseOwnerDashboardAdapter': (context, payload) =>
        FranchiseownerdashboardadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardDto': (context, payload) =>
        FranchiseownerdashboarddtoPlaceholder(data: payload),
    'franchiseOwnerDashboardDtoAdapter': (context, payload) =>
        FranchiseownerdashboarddtoadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardMapper': (context, payload) =>
        FranchiseownerdashboardmapperPlaceholder(data: payload),
    'franchiseOwnerDashboardMapperAdapter': (context, payload) =>
        FranchiseownerdashboardmapperadapterPlaceholder(data: payload),
    'franchiseOwnerDashboardViewModel': (context, payload) =>
        FranchiseownerdashboardviewmodelPlaceholder(data: payload),
    'franchiseReconciliationDashboardDto': (context, payload) =>
        FranchisereconciliationdashboarddtoPlaceholder(data: payload),
    'franchiseRefundsDashboardAdapter': (context, payload) =>
        FranchiserefundsdashboardadapterPlaceholder(data: payload),
    'franchiseRefundsDashboardDto': (context, payload) =>
        FranchiserefundsdashboarddtoPlaceholder(data: payload),
    'franchiseRefundsDashboardDtoAdapter': (context, payload) =>
        FranchiserefundsdashboarddtoadapterPlaceholder(data: payload),
    'franchiseRefundsDashboardMapper': (context, payload) =>
        FranchiserefundsdashboardmapperPlaceholder(data: payload),
    'franchiseRefundsDashboardViewModel': (context, payload) =>
        FranchiserefundsdashboardviewmodelPlaceholder(data: payload),
    'franchiseReportsDashboardAdapter': (context, payload) =>
        FranchisereportsdashboardadapterPlaceholder(data: payload),
    'franchiseReportsDashboardDto': (context, payload) =>
        FranchisereportsdashboarddtoPlaceholder(data: payload),
    'franchiseReportsDashboardDtoAdapter': (context, payload) =>
        FranchisereportsdashboarddtoadapterPlaceholder(data: payload),
    'franchiseReportsDashboardMapper': (context, payload) =>
        FranchisereportsdashboardmapperPlaceholder(data: payload),
    'franchiseReportsDashboardViewModel': (context, payload) =>
        FranchisereportsdashboardviewmodelPlaceholder(data: payload),
    'franchiseSalesManagerDashboardDto': (context, payload) =>
        FranchisesalesmanagerdashboarddtoPlaceholder(data: payload),
    'franchiseSalesManagerDashboardMapper': (context, payload) =>
        FranchisesalesmanagerdashboardmapperPlaceholder(data: payload),
    'fullScreenToggle': (context, payload) =>
        FullscreentogglePlaceholder(data: payload),
    'fuseAuthContext': (context, payload) =>
        FuseauthcontextPlaceholder(data: payload),
    'fuseAuthProvider': (context, payload) =>
        FuseauthproviderPlaceholder(data: payload),
    'fuseAuthorization': (context, payload) =>
        FuseauthorizationPlaceholder(data: payload),
    'fuseAwaitRender': (context, payload) =>
        FuseawaitrenderPlaceholder(data: payload),
    'fuseCountdown': (context, payload) =>
        FusecountdownPlaceholder(data: payload),
    'fuseDialog': (context, payload) => FusedialogPlaceholder(data: payload),
    'fuseDialogContextProvider': (context, payload) =>
        FusedialogcontextproviderPlaceholder(data: payload),
    'fuseExample': (context, payload) => FuseexamplePlaceholder(data: payload),
    'fuseHighlight': (context, payload) =>
        FusehighlightPlaceholder(data: payload),
    'fuseLayout': (context, payload) => FuselayoutPlaceholder(data: payload),
    'fuseLayoutConfig': (context, payload) =>
        FuselayoutconfigPlaceholder(data: payload),
    'fuseLayoutConfigs': (context, payload) =>
        FuselayoutconfigsPlaceholder(data: payload),
    'fuseLayoutSettingsContext': (context, payload) =>
        FuselayoutsettingscontextPlaceholder(data: payload),
    'fuseLoading': (context, payload) => FuseloadingPlaceholder(data: payload),
    'fuseNavBadge': (context, payload) =>
        FusenavbadgePlaceholder(data: payload),
    'fuseNavHorizontalCollapse': (context, payload) =>
        FusenavhorizontalcollapsePlaceholder(data: payload),
    'fuseNavHorizontalGroup': (context, payload) =>
        FusenavhorizontalgroupPlaceholder(data: payload),
    'fuseNavHorizontalItem': (context, payload) =>
        FusenavhorizontalitemPlaceholder(data: payload),
    'fuseNavHorizontalLayout1': (context, payload) =>
        Fusenavhorizontallayout1Placeholder(data: payload),
    'fuseNavHorizontalLink': (context, payload) =>
        FusenavhorizontallinkPlaceholder(data: payload),
    'fuseNavItem': (context, payload) => FusenavitemPlaceholder(data: payload),
    'fuseNavVerticalCollapse': (context, payload) =>
        FusenavverticalcollapsePlaceholder(data: payload),
    'fuseNavVerticalGroup': (context, payload) =>
        FusenavverticalgroupPlaceholder(data: payload),
    'fuseNavVerticalItem': (context, payload) =>
        FusenavverticalitemPlaceholder(data: payload),
    'fuseNavVerticalItemBase': (context, payload) =>
        FusenavverticalitembasePlaceholder(data: payload),
    'fuseNavVerticalLayout1': (context, payload) =>
        Fusenavverticallayout1Placeholder(data: payload),
    'fuseNavVerticalLayout2': (context, payload) =>
        Fusenavverticallayout2Placeholder(data: payload),
    'fuseNavVerticalLink': (context, payload) =>
        FusenavverticallinkPlaceholder(data: payload),
    'fuseNavVerticalTab': (context, payload) =>
        FusenavverticaltabPlaceholder(data: payload),
    'fuseNavigation': (context, payload) =>
        FusenavigationPlaceholder(data: payload),
    'fusePageCarded': (context, payload) =>
        FusepagecardedPlaceholder(data: payload),
    'fusePageCardedHeader': (context, payload) =>
        FusepagecardedheaderPlaceholder(data: payload),
    'fusePageCardedSidebar': (context, payload) =>
        FusepagecardedsidebarPlaceholder(data: payload),
    'fusePageCardedSidebarContent': (context, payload) =>
        FusepagecardedsidebarcontentPlaceholder(data: payload),
    'fusePageSimple': (context, payload) =>
        FusepagesimplePlaceholder(data: payload),
    'fusePageSimpleHeader': (context, payload) =>
        FusepagesimpleheaderPlaceholder(data: payload),
    'fusePageSimpleSidebar': (context, payload) =>
        FusepagesimplesidebarPlaceholder(data: payload),
    'fusePageSimpleSidebarContent': (context, payload) =>
        FusepagesimplesidebarcontentPlaceholder(data: payload),
    'fuseScrollbars': (context, payload) =>
        FusescrollbarsPlaceholder(data: payload),
    'fuseSearch': (context, payload) => FusesearchPlaceholder(data: payload),
    'fuseSettings': (context, payload) =>
        FusesettingsPlaceholder(data: payload),
    'fuseSettingsContext': (context, payload) =>
        FusesettingscontextPlaceholder(data: payload),
    'fuseSettingsProvider': (context, payload) =>
        FusesettingsproviderPlaceholder(data: payload),
    'fuseSettingsViewerDialog': (context, payload) =>
        FusesettingsviewerdialogPlaceholder(data: payload),
    'fuseShortcuts': (context, payload) =>
        FuseshortcutsPlaceholder(data: payload),
    'fuseSidePanel': (context, payload) =>
        FusesidepanelPlaceholder(data: payload),
    'fuseSplashScreen': (context, payload) =>
        FusesplashscreenPlaceholder(data: payload),
    'fuseSuspense': (context, payload) =>
        FusesuspensePlaceholder(data: payload),
    'fuseSvgIcon': (context, payload) => FusesvgiconPlaceholder(data: payload),
    'fuseTheme': (context, payload) => FusethemePlaceholder(data: payload),
    'fuseThemeHooks': (context, payload) =>
        FusethemehooksPlaceholder(data: payload),
    'fuseThemeSelector': (context, payload) =>
        FusethemeselectorPlaceholder(data: payload),
    'generalManagerDashboardAdapter': (context, payload) =>
        GeneralmanagerdashboardadapterPlaceholder(data: payload),
    'generalManagerDashboardDto': (context, payload) =>
        GeneralmanagerdashboarddtoPlaceholder(data: payload),
    'generalManagerDashboardDtoAdapter': (context, payload) =>
        GeneralmanagerdashboarddtoadapterPlaceholder(data: payload),
    'generalManagerDashboardMapper': (context, payload) =>
        GeneralmanagerdashboardmapperPlaceholder(data: payload),
    'generalManagerDashboardMapperAdapter': (context, payload) =>
        GeneralmanagerdashboardmapperadapterPlaceholder(data: payload),
    'generalManagerDashboardViewModel': (context, payload) =>
        GeneralManagerDashboardScreenPlaceholder(data: payload),
    'goToDocBox': (context, payload) => GotodocboxPlaceholder(data: payload),
    'greetingHeaderWidget': (context, payload) =>
        GreetingheaderwidgetPlaceholder(data: payload),
    'guestDashboardAdapter': (context, payload) =>
        GuestdashboardadapterPlaceholder(data: payload),
    'guestDashboardDto': (context, payload) =>
        GuestdashboarddtoPlaceholder(data: payload),
    'guestDashboardDtoAdapter': (context, payload) =>
        GuestdashboarddtoadapterPlaceholder(data: payload),
    'guestDashboardMapper': (context, payload) =>
        GuestdashboardmapperPlaceholder(data: payload),
    'guestDashboardMapperAdapter': (context, payload) =>
        GuestdashboardmapperadapterPlaceholder(data: payload),
    'guestDashboardViewModel': (context, payload) =>
        GuestdashboardviewmodelPlaceholder(data: payload),
    'guestDashboardViewModelAdapter': (context, payload) =>
        GuestdashboardviewmodeladapterPlaceholder(data: payload),
    'headOfBusDevDashboardAdapter': (context, payload) =>
        HeadofbusdevdashboardadapterPlaceholder(data: payload),
    'headOfBusDevDashboardDto': (context, payload) =>
        HeadofbusdevdashboarddtoPlaceholder(data: payload),
    'headOfBusDevDashboardDtoAdapter': (context, payload) =>
        HeadofbusdevdashboarddtoadapterPlaceholder(data: payload),
    'headOfBusDevDashboardMapper': (context, payload) =>
        HeadofbusdevdashboardmapperPlaceholder(data: payload),
    'headOfBusDevDashboardMapperAdapter': (context, payload) =>
        HeadofbusdevdashboardmapperadapterPlaceholder(data: payload),
    'headOfBusDevDashboardViewModel': (context, payload) =>
        HeadofbusdevdashboardviewmodelPlaceholder(data: payload),
    'headOfMarketingDashboardAdapter': (context, payload) =>
        HeadofmarketingdashboardadapterPlaceholder(data: payload),
    'headOfMarketingDashboardDto': (context, payload) =>
        HeadofmarketingdashboarddtoPlaceholder(data: payload),
    'headOfMarketingDashboardDtoAdapter': (context, payload) =>
        HeadofmarketingdashboarddtoadapterPlaceholder(data: payload),
    'headOfMarketingDashboardMapper': (context, payload) =>
        HeadofmarketingdashboardmapperPlaceholder(data: payload),
    'headOfMarketingDashboardViewModel': (context, payload) =>
        HeadOfMarketingDashboardScreen(
          data: payload as HeadOfMarketingDashboardViewModel?,
        ),
    'headingButton': (context, payload) =>
        HeadingbuttonPlaceholder(data: payload),
    'headingDropdownMenu': (context, payload) =>
        HeadingdropdownmenuPlaceholder(data: payload),
    'headingFiveIcon': (context, payload) =>
        HeadingfiveiconPlaceholder(data: payload),
    'headingFourIcon': (context, payload) =>
        HeadingfouriconPlaceholder(data: payload),
    'headingIcon': (context, payload) => HeadingiconPlaceholder(data: payload),
    'headingOneIcon': (context, payload) =>
        HeadingoneiconPlaceholder(data: payload),
    'headingSixIcon': (context, payload) =>
        HeadingsixiconPlaceholder(data: payload),
    'headingThreeIcon': (context, payload) =>
        HeadingthreeiconPlaceholder(data: payload),
    'headingTwoIcon': (context, payload) =>
        HeadingtwoiconPlaceholder(data: payload),
    'highlightPopover': (context, payload) =>
        HighlightpopoverPlaceholder(data: payload),
    'highlighterIcon': (context, payload) =>
        HighlightericonPlaceholder(data: payload),
    'hrHiringDashboardAdapter': (context, payload) =>
        HrhiringdashboardadapterPlaceholder(data: payload),
    'hrHiringDashboardDto': (context, payload) =>
        HrhiringdashboarddtoPlaceholder(data: payload),
    'hrHiringDashboardDtoAdapter': (context, payload) =>
        HrhiringdashboarddtoadapterPlaceholder(data: payload),
    'hrHiringDashboardMapper': (context, payload) =>
        HrhiringdashboardmapperPlaceholder(data: payload),
    'hrHiringDashboardMapperAdapter': (context, payload) =>
        HrhiringdashboardmapperadapterPlaceholder(data: payload),
    'hrHiringDashboardViewModel': (context, payload) =>
        HrManagerDashboardScreen(data: payload as HrHiringDashboardViewModel?),
    'hrHiringDashboardViewModelAdapter': (context, payload) =>
        HrhiringdashboardviewmodeladapterPlaceholder(data: payload),
    'i18nContext': (context, payload) => I18ncontextPlaceholder(data: payload),
    'i18nProvider': (context, payload) =>
        I18nproviderPlaceholder(data: payload),
    'imagePlusIcon': (context, payload) =>
        ImageplusiconPlaceholder(data: payload),
    'imageUploadButton': (context, payload) =>
        ImageuploadbuttonPlaceholder(data: payload),
    'imageUploadNode': (context, payload) =>
        ImageuploadnodePlaceholder(data: payload),
    'index': (context, payload) => IndexformPlaceholder(data: payload),
    'initializeFirebase': (context, payload) =>
        InitializefirebasePlaceholder(data: payload),
    'intakeDashboardAdapter': (context, payload) =>
        IntakedashboardadapterPlaceholder(data: payload),
    'intakeDashboardDto': (context, payload) =>
        IntakedashboarddtoPlaceholder(data: payload),
    'intakeDashboardDtoAdapter': (context, payload) =>
        IntakedashboarddtoadapterPlaceholder(data: payload),
    'intakeDashboardMapper': (context, payload) =>
        IntakedashboardmapperPlaceholder(data: payload),
    'intakeDashboardMapperAdapter': (context, payload) =>
        IntakedashboardmapperadapterPlaceholder(data: payload),
    'intakeDashboardViewModel': (context, payload) =>
        IntakedashboardviewmodelPlaceholder(data: payload),
    'intakeDashboardViewModelAdapter': (context, payload) =>
        IntakedashboardviewmodeladapterPlaceholder(data: payload),
    'italicIcon': (context, payload) => ItaliciconPlaceholder(data: payload),
    'jwSignUpTab': (context, payload) => JwsignuptabPlaceholder(data: payload),
    'jwtAuthContext': (context, payload) =>
        JwtauthcontextPlaceholder(data: payload),
    'jwtAuthProvider': (context, payload) =>
        JwtauthproviderPlaceholder(data: payload),
    'jwtSignInForm': (context, payload) =>
        JwtsigninformPlaceholder(data: payload),
    'jwtSignInTab': (context, payload) =>
        JwtsignintabPlaceholder(data: payload),
    'jwtSignUpForm': (context, payload) =>
        JwtsignupformPlaceholder(data: payload),
    'languageSwitcher': (context, payload) =>
        LanguageswitcherPlaceholder(data: payload),
    'layout1': (context, payload) => Layout1Screen(data: payload),
    'layout2': (context, payload) => Layout2Screen(data: payload),
    'layout3': (context, payload) => Layout3Screen(data: payload),
    'leaveRequestForm': (context, payload) =>
        LeaverequestformPlaceholder(data: payload),
    'leftSideLayout1': (context, payload) =>
        Leftsidelayout1Placeholder(data: payload),
    'leftSideLayout2': (context, payload) =>
        Leftsidelayout2Placeholder(data: payload),
    'leftSideLayout3': (context, payload) =>
        Leftsidelayout3Placeholder(data: payload),
    'lightDarkModeToggle': (context, payload) =>
        LightdarkmodetogglePlaceholder(data: payload),
    'link': (context, payload) => LinkScreen(data: payload),
    'linkIcon': (context, payload) => LinkiconPlaceholder(data: payload),
    'linkPopover': (context, payload) => LinkpopoverPlaceholder(data: payload),
    'listButton': (context, payload) => ListbuttonPlaceholder(data: payload),
    'listDropdownMenu': (context, payload) =>
        ListdropdownmenuPlaceholder(data: payload),
    'listIcon': (context, payload) => ListiconPlaceholder(data: payload),
    'listOrderedIcon': (context, payload) =>
        ListorderediconPlaceholder(data: payload),
    'listTodoIcon': (context, payload) =>
        ListtodoiconPlaceholder(data: payload),
    'localMarketingManagerDashboardDto': (context, payload) =>
        LocalmarketingmanagerdashboarddtoPlaceholder(data: payload),
    'localMarketingManagerDashboardMapper': (context, payload) =>
        LocalmarketingmanagerdashboardmapperPlaceholder(data: payload),
    'logClinicalIncidentForm': (context, payload) =>
        LogclinicalincidentformPlaceholder(data: payload),
    'logEmployeeGrievanceForm': (context, payload) =>
        LogemployeegrievanceformPlaceholder(data: payload),
    'logFranchiseeVettingCallForm': (context, payload) =>
        LogfranchiseevettingcallformPlaceholder(data: payload),
    'logInfectionControlForm': (context, payload) =>
        LoginfectioncontrolformPlaceholder(data: payload),
    'logInventorySpoilageForm': (context, payload) =>
        LoginventoryspoilageformPlaceholder(data: payload),
    'logPettyCashForm': (context, payload) =>
        LogpettycashformPlaceholder(data: payload),
    'loginScreen': (context, payload) => LoginscreenPlaceholder(data: payload),
    'logo': (context, payload) => LogoScreen(data: payload),
    'mainProjectSelection': (context, payload) =>
        MainprojectselectionPlaceholder(data: payload),
    'mainThemeProvider': (context, payload) =>
        MainthemeproviderPlaceholder(data: payload),
    'markButton': (context, payload) => MarkbuttonPlaceholder(data: payload),
    'masterAppShell': (context, payload) =>
        MasterappshellPlaceholder(data: payload),
    'masterDashboardPage': (context, payload) =>
        MasterdashboardpagePlaceholder(data: payload),
    'masterDashboardPageAdapter': (context, payload) =>
        MasterdashboardpageadapterPlaceholder(data: payload),
    'masterDetailLayout': (context, payload) =>
        MasterdetaillayoutPlaceholder(data: payload),
    'masterLayout': (context, payload) =>
        MasterlayoutPlaceholder(data: payload),
    'mfaScreen': (context, payload) => MfascreenPlaceholder(data: payload),
    'mockApi': (context, payload) => MockapiPlaceholder(data: payload),
    'moodSliderWidget': (context, payload) =>
        MoodsliderwidgetPlaceholder(data: payload),
    'moonStarIcon': (context, payload) =>
        MoonstariconPlaceholder(data: payload),
    'navLinkAdapter': (context, payload) =>
        NavlinkadapterPlaceholder(data: payload),
    'navbarContextProvider': (context, payload) =>
        NavbarcontextproviderPlaceholder(data: payload),
    'navbarLayout2': (context, payload) =>
        Navbarlayout2Placeholder(data: payload),
    'navbarLayout3': (context, payload) =>
        Navbarlayout3Placeholder(data: payload),
    'navbarMobileLayout2': (context, payload) =>
        Navbarmobilelayout2Placeholder(data: payload),
    'navbarMobileLayout3': (context, payload) =>
        Navbarmobilelayout3Placeholder(data: payload),
    'navbarPinToggleButton': (context, payload) =>
        NavbarpintogglebuttonPlaceholder(data: payload),
    'navbarStyle1': (context, payload) =>
        Navbarstyle1Placeholder(data: payload),
    'navbarStyle1Content': (context, payload) =>
        Navbarstyle1contentPlaceholder(data: payload),
    'navbarStyle2': (context, payload) =>
        Navbarstyle2Placeholder(data: payload),
    'navbarStyle2Content': (context, payload) =>
        Navbarstyle2contentPlaceholder(data: payload),
    'navbarTheme': (context, payload) => NavbarthemePlaceholder(data: payload),
    'navbarToggleButton': (context, payload) =>
        NavbartogglebuttonPlaceholder(data: payload),
    'navbarToggleFab': (context, payload) =>
        NavbartogglefabPlaceholder(data: payload),
    'navbarToggleFabLayout1': (context, payload) =>
        Navbartogglefablayout1Placeholder(data: payload),
    'navbarToggleFabLayout2': (context, payload) =>
        Navbartogglefablayout2Placeholder(data: payload),
    'navbarWrapperLayout1': (context, payload) =>
        Navbarwrapperlayout1Placeholder(data: payload),
    'navbarWrapperLayout2': (context, payload) =>
        Navbarwrapperlayout2Placeholder(data: payload),
    'navbarWrapperLayout3': (context, payload) =>
        Navbarwrapperlayout3Placeholder(data: payload),
    'navigation': (context, payload) => NavigationScreen(data: payload),
    'navigationContextProvider': (context, payload) =>
        NavigationcontextproviderPlaceholder(data: payload),
    'navigationSearch': (context, payload) =>
        NavigationsearchPlaceholder(data: payload),
    'navigationShortcuts': (context, payload) =>
        NavigationshortcutsPlaceholder(data: payload),
    'newEmployeeOnboardingForm': (context, payload) =>
        NewemployeeonboardingformPlaceholder(data: payload),
    'nodeButton': (context, payload) => NodebuttonPlaceholder(data: payload),
    'numberFormController': (context, payload) =>
        NumberformcontrollerPlaceholder(data: payload),
    'nurtureLocalizedLeadForm': (context, payload) =>
        NurturelocalizedleadformPlaceholder(data: payload),
    'operationsManagerDashboardAdapter': (context, payload) =>
        OperationsmanagerdashboardadapterPlaceholder(data: payload),
    'operationsManagerDashboardDto': (context, payload) =>
        OperationsmanagerdashboarddtoPlaceholder(data: payload),
    'operationsManagerDashboardDtoAdapter': (context, payload) =>
        OperationsmanagerdashboarddtoadapterPlaceholder(data: payload),
    'operationsManagerDashboardMapper': (context, payload) =>
        OperationsmanagerdashboardmapperPlaceholder(data: payload),
    'operationsManagerDashboardViewModel': (context, payload) =>
        OperationsManagerDashboardScreen(
          data: payload as OperationsManagerDashboardViewModel?,
        ),
    'overrideGlobalScheduleForm': (context, payload) =>
        OverrideglobalscheduleformPlaceholder(data: payload),
    'ownerDashboardAdapter': (context, payload) =>
        OwnerdashboardadapterPlaceholder(data: payload),
    'ownerDashboardDto': (context, payload) =>
        OwnerdashboarddtoPlaceholder(data: payload),
    'ownerDashboardDtoAdapter': (context, payload) =>
        OwnerdashboarddtoadapterPlaceholder(data: payload),
    'ownerDashboardMapper': (context, payload) =>
        OwnerdashboardmapperPlaceholder(data: payload),
    'ownerDashboardMapperAdapter': (context, payload) =>
        OwnerdashboardmapperadapterPlaceholder(data: payload),
    'ownerDashboardViewModel': (context, payload) =>
        OwnerdashboardviewmodelPlaceholder(data: payload),
    'ownerDashboardViewModelAdapter': (context, payload) =>
        OwnerdashboardviewmodeladapterPlaceholder(data: payload),
    'pageBreadcrumb': (context, payload) =>
        PagebreadcrumbPlaceholder(data: payload),
    'pageTitle': (context, payload) => PagetitlePlaceholder(data: payload),
    'palettePreview': (context, payload) =>
        PalettepreviewPlaceholder(data: payload),
    'paletteSelector': (context, payload) =>
        PaletteselectorPlaceholder(data: payload),
    'partnershipManagerDashboardAdapter': (context, payload) =>
        PartnershipmanagerdashboardadapterPlaceholder(data: payload),
    'partnershipManagerDashboardDto': (context, payload) =>
        PartnershipmanagerdashboarddtoPlaceholder(data: payload),
    'partnershipManagerDashboardMapper': (context, payload) =>
        PartnershipmanagerdashboardmapperPlaceholder(data: payload),
    'partnershipManagerDashboardViewModel': (context, payload) =>
        PartnershipmanagerdashboardviewmodelPlaceholder(data: payload),
    'patientDashboardAdapter': (context, payload) =>
        PatientdashboardadapterPlaceholder(data: payload),
    'patientDashboardDto': (context, payload) =>
        PatientdashboarddtoPlaceholder(data: payload),
    'patientDashboardDtoAdapter': (context, payload) =>
        PatientdashboarddtoadapterPlaceholder(data: payload),
    'patientDashboardMapper': (context, payload) =>
        PatientdashboardmapperPlaceholder(data: payload),
    'patientDashboardMapperAdapter': (context, payload) =>
        PatientdashboardmapperadapterPlaceholder(data: payload),
    'patientDashboardViewModel': (context, payload) =>
        PatientdashboardviewmodelPlaceholder(data: payload),
    'patientDashboardViewModelAdapter': (context, payload) =>
        PatientdashboardviewmodeladapterPlaceholder(data: payload),
    'patientIntakeForm': (context, payload) =>
        PatientintakeformPlaceholder(data: payload),
    'popover': (context, payload) => PopoverScreen(data: payload),
    'poweredByLinks': (context, payload) =>
        PoweredbylinksPlaceholder(data: payload),
    'primecareResponsiveShell': (context, payload) =>
        PrimecareresponsiveshellPlaceholder(data: payload),
    'providerLayout': (context, payload) =>
        ProviderlayoutPlaceholder(data: payload),
    'purchaseButton': (context, payload) =>
        PurchasebuttonPlaceholder(data: payload),
    'qaDashboardAdapter': (context, payload) =>
        QadashboardadapterPlaceholder(data: payload),
    'qaDashboardDto': (context, payload) =>
        QadashboarddtoPlaceholder(data: payload),
    'qaDashboardDtoAdapter': (context, payload) =>
        QadashboarddtoadapterPlaceholder(data: payload),
    'qaDashboardMapper': (context, payload) =>
        QadashboardmapperPlaceholder(data: payload),
    'qaDashboardMapperAdapter': (context, payload) =>
        QadashboardmapperadapterPlaceholder(data: payload),
    'qaDashboardProvider': (context, payload) =>
        QadashboardproviderPlaceholder(data: payload),
    'qaDashboardScreen': (context, payload) =>
        QadashboardscreenPlaceholder(data: payload),
    'qaDashboardViewModel': (context, payload) =>
        QadashboardviewmodelPlaceholder(data: payload),
    'qaDashboardViewModelAdapter': (context, payload) =>
        QadashboardviewmodeladapterPlaceholder(data: payload),
    'quickPanel': (context, payload) => QuickpanelPlaceholder(data: payload),
    'quickPanelContextProvider': (context, payload) =>
        QuickpanelcontextproviderPlaceholder(data: payload),
    'quickPanelToggleButton': (context, payload) =>
        QuickpaneltogglebuttonPlaceholder(data: payload),
    'radioFormController': (context, payload) =>
        RadioformcontrollerPlaceholder(data: payload),
    'redo2Icon': (context, payload) => Redo2iconPlaceholder(data: payload),
    'regionalBdmDashboardAdapter': (context, payload) =>
        RegionalbdmdashboardadapterPlaceholder(data: payload),
    'regionalBdmDashboardDto': (context, payload) =>
        RegionalbdmdashboarddtoPlaceholder(data: payload),
    'regionalBdmDashboardDtoAdapter': (context, payload) =>
        RegionalbdmdashboarddtoadapterPlaceholder(data: payload),
    'regionalBdmDashboardMapper': (context, payload) =>
        RegionalbdmdashboardmapperPlaceholder(data: payload),
    'regionalBdmDashboardMapperAdapter': (context, payload) =>
        RegionalbdmdashboardmapperadapterPlaceholder(data: payload),
    'regionalBdmDashboardProvider': (context, payload) =>
        RegionalbdmdashboardproviderPlaceholder(data: payload),
    'regionalBdmDashboardScreen': (context, payload) =>
        RegionalbdmdashboardscreenPlaceholder(data: payload),
    'regionalBdmDashboardViewModel': (context, payload) =>
        RegionalbdmdashboardviewmodelPlaceholder(data: payload),
    'regionalBdmDashboardViewModelAdapter': (context, payload) =>
        RegionalbdmdashboardviewmodeladapterPlaceholder(data: payload),
    'regionalManagerOntarioDashboardDto': (context, payload) =>
        RegionalmanagerontariodashboarddtoPlaceholder(data: payload),
    'registerCorporateRiskForm': (context, payload) =>
        RegistercorporateriskformPlaceholder(data: payload),
    'requestShiftAdjustmentForm': (context, payload) =>
        RequestshiftadjustmentformPlaceholder(data: payload),
    'reviewCarePlanForm': (context, payload) =>
        ReviewcareplanformPlaceholder(data: payload),
    'reviewClinicalIncidentForm': (context, payload) =>
        ReviewclinicalincidentformPlaceholder(data: payload),
    'reviewFleetMaintenanceForm': (context, payload) =>
        ReviewfleetmaintenanceformPlaceholder(data: payload),
    'reviewLeadConversionForm': (context, payload) =>
        ReviewleadconversionformPlaceholder(data: payload),
    'reviewLegalContractForm': (context, payload) =>
        ReviewlegalcontractformPlaceholder(data: payload),
    'reviewMarketShareForm': (context, payload) =>
        ReviewmarketshareformPlaceholder(data: payload),
    'reviewMedicationInventoryForm': (context, payload) =>
        ReviewmedicationinventoryformPlaceholder(data: payload),
    'reviewMonthlyExpensesForm': (context, payload) =>
        ReviewmonthlyexpensesformPlaceholder(data: payload),
    'reviewOnboardingStatusForm': (context, payload) =>
        ReviewonboardingstatusformPlaceholder(data: payload),
    'reviewPeerPerformanceForm': (context, payload) =>
        ReviewpeerperformanceformPlaceholder(data: payload),
    'reviewVendorContractsForm': (context, payload) =>
        ReviewvendorcontractsformPlaceholder(data: payload),
    'rightSideLayout1': (context, payload) =>
        Rightsidelayout1Placeholder(data: payload),
    'rightSideLayout2': (context, payload) =>
        Rightsidelayout2Placeholder(data: payload),
    'rightSideLayout3': (context, payload) =>
        Rightsidelayout3Placeholder(data: payload),
    'rolePermissionsForm': (context, payload) =>
        RolepermissionsformPlaceholder(data: payload),
    'rootThemeProvider': (context, payload) =>
        RootthemeproviderPlaceholder(data: payload),
    'route': (context, payload) => RouteScreen(data: payload),
    'routesConfig': (context, payload) =>
        RoutesconfigPlaceholder(data: payload),
    'scheduleClinicalAuditForm': (context, payload) =>
        ScheduleclinicalauditformPlaceholder(data: payload),
    'scheduleFacilityMaintenanceForm': (context, payload) =>
        SchedulefacilitymaintenanceformPlaceholder(data: payload),
    'scheduleInterviewForm': (context, payload) =>
        ScheduleinterviewformPlaceholder(data: payload),
    'scheduleOpenHouseForm': (context, payload) =>
        ScheduleopenhouseformPlaceholder(data: payload),
    'schemePreview': (context, payload) =>
        SchemepreviewPlaceholder(data: payload),
    'sectionPreview': (context, payload) =>
        SectionpreviewPlaceholder(data: payload),
    'separator': (context, payload) => SeparatorScreen(data: payload),
    'settingsPanel': (context, payload) =>
        SettingspanelPlaceholder(data: payload),
    'signInPageForm': (context, payload) =>
        SigninpageformPlaceholder(data: payload),
    'signInPageTitle': (context, payload) =>
        SigninpagetitlePlaceholder(data: payload),
    'signInPageView': (context, payload) =>
        SigninpageviewPlaceholder(data: payload),
    'signOutPageTitle': (context, payload) =>
        SignoutpagetitlePlaceholder(data: payload),
    'signOutPageView': (context, payload) =>
        SignoutpageviewPlaceholder(data: payload),
    'signUpPageTitle': (context, payload) =>
        SignuppagetitlePlaceholder(data: payload),
    'signUpPageView': (context, payload) =>
        SignuppageviewPlaceholder(data: payload),
    'signupScreen': (context, payload) =>
        SignupscreenPlaceholder(data: payload),
    'simpleEditor': (context, payload) =>
        SimpleeditorPlaceholder(data: payload),
    'singleInputForm': (context, payload) =>
        SingleinputformPlaceholder(data: payload),
    'slideToClockInWidget': (context, payload) =>
        SlidetoclockinwidgetPlaceholder(data: payload),
    'spacer': (context, payload) => SpacerScreen(data: payload),
    'splashScreen': (context, payload) =>
        SplashscreenPlaceholder(data: payload),
    'strikeIcon': (context, payload) => StrikeiconPlaceholder(data: payload),
    'submitAdlChecklistForm': (context, payload) =>
        SubmitadlchecklistformPlaceholder(data: payload),
    'submitDailyCensusForm': (context, payload) =>
        SubmitdailycensusformPlaceholder(data: payload),
    'submitExitInterviewForm': (context, payload) =>
        SubmitexitinterviewformPlaceholder(data: payload),
    'submitHealthcareClaimForm': (context, payload) =>
        SubmithealthcareclaimformPlaceholder(data: payload),
    'submitMarketingBudgetForm': (context, payload) =>
        SubmitmarketingbudgetformPlaceholder(data: payload),
    'subscriptIcon': (context, payload) =>
        SubscripticonPlaceholder(data: payload),
    'subscriptionUpgradeScreen': (context, payload) =>
        SubscriptionupgradescreenPlaceholder(data: payload),
    'sunIcon': (context, payload) => SuniconPlaceholder(data: payload),
    'superscriptIcon': (context, payload) =>
        SuperscripticonPlaceholder(data: payload),
    'switchFormController': (context, payload) =>
        SwitchformcontrollerPlaceholder(data: payload),
    'textAlignButton': (context, payload) =>
        TextalignbuttonPlaceholder(data: payload),
    'themePreview': (context, payload) =>
        ThemepreviewPlaceholder(data: payload),
    'themeToggle': (context, payload) => ThemetogglePlaceholder(data: payload),
    'themesPanel': (context, payload) => ThemespanelPlaceholder(data: payload),
    'titleReferenceLink': (context, payload) =>
        TitlereferencelinkPlaceholder(data: payload),
    'toolbar': (context, payload) => ToolbarScreen(data: payload),
    'toolbarLayout1': (context, payload) =>
        Toolbarlayout1Placeholder(data: payload),
    'toolbarLayout2': (context, payload) =>
        Toolbarlayout2Placeholder(data: payload),
    'toolbarLayout3': (context, payload) =>
        Toolbarlayout3Placeholder(data: payload),
    'toolbarTheme': (context, payload) =>
        ToolbarthemePlaceholder(data: payload),
    'tooltip': (context, payload) => TooltipScreen(data: payload),
    'trashIcon': (context, payload) => TrashiconPlaceholder(data: payload),
    'underlineIcon': (context, payload) =>
        UnderlineiconPlaceholder(data: payload),
    'undo2Icon': (context, payload) => Undo2iconPlaceholder(data: payload),
    'undoRedoButton': (context, payload) =>
        UndoredobuttonPlaceholder(data: payload),
    'useAuth': (context, payload) => UseauthPlaceholder(data: payload),
    'useAwsAuth': (context, payload) => UseawsauthPlaceholder(data: payload),
    'useFirebaseAuth': (context, payload) =>
        UsefirebaseauthPlaceholder(data: payload),
    'useFuseDialogContext': (context, payload) =>
        UsefusedialogcontextPlaceholder(data: payload),
    'useFuseLayoutSettings': (context, payload) =>
        UsefuselayoutsettingsPlaceholder(data: payload),
    'useFuseRouteParameter': (context, payload) =>
        UsefuserouteparameterPlaceholder(data: payload),
    'useFuseSettings': (context, payload) =>
        UsefusesettingsPlaceholder(data: payload),
    'useI18n': (context, payload) => Usei18nPlaceholder(data: payload),
    'useJwtAuth': (context, payload) => UsejwtauthPlaceholder(data: payload),
    'useLocalStorage': (context, payload) =>
        UselocalstoragePlaceholder(data: payload),
    'useNavigate': (context, payload) => UsenavigatePlaceholder(data: payload),
    'useNavigationItems': (context, payload) =>
        UsenavigationitemsPlaceholder(data: payload),
    'usePathname': (context, payload) => UsepathnamePlaceholder(data: payload),
    'useUser': (context, payload) => UseuserPlaceholder(data: payload),
    'userMenu': (context, payload) => UsermenuPlaceholder(data: payload),
    'withRouter': (context, payload) => WithrouterPlaceholder(data: payload),
    'withUser': (context, payload) => WithuserPlaceholder(data: payload),
    'stat_card_grid': _buildStatCardGrid,
    'activity_feed': _buildActivityFeed,
    'data_table': _buildDataTable,
    'risk_monitor': _buildRiskMonitor,
    'financial_rail': _buildFinancialRail,
    'management_action': _buildManagementAction,
    'clinical_metric': _buildClinicalMetric,
    'compliance_gate': _buildComplianceGate,
    'analytics_chart': _buildAnalyticsChart,
    'aura_dashboard_hud': (context, payload) => const AuraDashboardHud(),
    'stitch_screen': _buildStitchScreen,
    'patient_intake_form': (context, payload) =>
        PatientIntakeForm(initialData: payload),
    'vitals_capture_form': (context, payload) {
      String? patientId;
      if (payload is Map) {
        patientId = payload['patientId'] as String?;
      } else if (payload is String) {
        patientId = payload;
      }
      return VitalsCaptureForm(patientId: patientId);
    },
    'staff_provisioning_form': (context, payload) =>
        NewStaffProvisioningForm(initialData: payload),
    'clinical_incident_form': (context, payload) =>
        ClinicalIncidentForm(initialData: payload),
    'billing_payment_form': (context, payload) =>
        BillingPaymentForm(initialData: payload),
    'medication_administration_form': (context, payload) =>
        MedicationAdministrationForm(initialData: payload),
    'employee_timesheet_form': (context, payload) =>
        EmployeeTimesheetForm(initialData: payload),
    'ai_forecasting': _buildAIForecastingDashlet,
  };

  /// Register a new component dynamically (could be used for lazy-loaded plugins).
  static void registerComponent(String type, ComponentBuilder builder) {
    _registry[type] = builder;
  }

  /// Retrieve the builder for a component type. Returns a fallback builder if not found.
  static ComponentBuilder getBuilder(String componentType) {
    return _registry[componentType] ?? _buildUnknownComponent(componentType);
  }

  /// Extracts the required Builder and creates the widget safely.
  static Widget build(BuildContext context, UIComponentBlueprint blueprint) {
    final builder = getBuilder(blueprint.componentType);
    final widget = builder(context, blueprint.dataPayload);

    // Resolution for "Duplicate GlobalKey" issues: Wrap in a KeyedSubtree with a unique ID
    // derived from the blueprint type and payload identity/hash.
    // We add a 'salt' to the key to distinguish between top-level orchestration and nested items.
    return KeyedSubtree(
      key: ValueKey(
        'warehouse_${blueprint.componentType}_${blueprint.dataPayload.hashCode}',
      ),
      child: widget,
    );
  }

  // --- Builders for default widgets ---

  static Widget _buildStatCardGrid(BuildContext context, dynamic dataPayload) {
    // Expected a list of KPI objects
    if (dataPayload == null || dataPayload is! List) {
      return const SizedBox.shrink();
    }
    final kpis = dataPayload;
    final ds = PrimeCareDesignSystem.of(context);

    return PrimeResponsiveGrid(
      children: kpis.map((kpi) {
        if (kpi is UniversalKpi) {
          return PrimeCareStatCard(
            title: kpi.title,
            value: kpi.value,
            deltaSuffix: kpi.trendValue != 0.0
                ? "${kpi.trendValue > 0 ? '+' : ''}${kpi.trendValue}%"
                : null,
            icon: _inferIcon(kpi.title),
            iconColor: _inferColor(ds, kpi.status),
          );
        }

        // Fallback for raw map data or dynamic objects
        try {
          final title = (kpi is Map) ? kpi['title'] : (kpi as dynamic).title;
          final value = (kpi is Map) ? kpi['value'] : (kpi as dynamic).value;
          final status = (kpi is Map)
              ? (kpi['status'] ?? 'neutral')
              : (kpi as dynamic).status;
          final trend = (kpi is Map)
              ? kpi['trend']?.toString()
              : (kpi as dynamic).trend?.toString();

          return PrimeCareStatCard(
            title: title as String? ?? 'Metric',
            value: value as String? ?? '0',
            deltaSuffix: trend,
            icon: _inferIcon(title ?? 'Metric'),
            iconColor: _inferColor(ds, status?.toString() ?? 'neutral'),
          );
        } catch (e) {
          return const PrimeCareStatCard(
            title: 'Error',
            value: '!',
            icon: LucideIcons.alertCircle,
          );
        }
      }).toList(),
    );
  }

  static Widget _buildActivityFeed(BuildContext context, dynamic dataPayload) {
    final activities = dataPayload as List<dynamic>;
    final ds = PrimeCareDesignSystem.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Row(
            children: [
              Icon(LucideIcons.activity, size: 16, color: ds.colors.primary),
              const SizedBox(width: 8),
              Text(
                'INSTITUTIONAL CONTINUITY FEED',
                style: TextStyle(
                  color: ds.colors.primary,
                  fontSize: 11,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        ...activities.map((activity) {
          String title;
          String timestamp;
          String colorStr;

          if (activity is DashboardActivity) {
            title = activity.title;
            timestamp = activity.timestamp;
            colorStr = activity.color;
          } else if (activity is Map) {
            // Fallback for raw map data
            title = activity['title'] as String? ?? 'Activity';
            timestamp = activity['timestamp'] as String? ?? '';
            // Support both 'color' and 'type' keys for backward compatibility
            colorStr =
                (activity['color'] ?? activity['type']) as String? ?? 'primary';
          } else {
            // Surgical fallback for dynamic objects that might not be detected by type check
            try {
              title = (activity as dynamic).title as String? ?? 'System Update';
              timestamp =
                  (activity as dynamic).timestamp as String? ?? 'Recently';
              colorStr = (activity as dynamic).color as String? ?? 'primary';
            } catch (_) {
              title = 'System Update';
              timestamp = 'Recently';
              colorStr = 'primary';
            }
          }

          final color = colorStr == 'success' || colorStr == 'green'
              ? ds.colors.success
              : (colorStr == 'warning' || colorStr == 'orange'
                    ? ds.colors.warning
                    : (colorStr == 'danger' || colorStr == 'red'
                          ? ds.colors.danger
                          : ds.colors.primary));

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: ds.colors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: ds.colors.borderSubtle),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 32,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: ds.colors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        timestamp,
                        style: TextStyle(
                          color: ds.colors.textTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  static Widget _buildDataTable(BuildContext context, dynamic dataPayload) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ds.colors.borderSubtle),
      ),
      child: Column(
        children: [
          Icon(
            LucideIcons.database,
            size: 48,
            color: ds.colors.primary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 16),
          Text(
            'HYDRATED DATA MATRIX',
            style: TextStyle(
              color: ds.colors.textPrimary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Institutional records are fully synchronized and available in memory.',
            textAlign: TextAlign.center,
            style: TextStyle(color: ds.colors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  static Widget _buildRiskMonitor(BuildContext context, dynamic dataPayload) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: ds.colors.danger.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: ds.colors.danger.withValues(alpha: 0.1),
            blurRadius: 40,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.shieldAlert, color: ds.colors.danger, size: 28),
              const SizedBox(width: 16),
              Text(
                'Risk Surveillance Engine'.toUpperCase(),
                style: TextStyle(
                  color: ds.colors.textPrimary,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Text(
                'LIVE',
                style: TextStyle(
                  color: ds.colors.danger,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Monitoring algorithmic health and care quality signals across all tenants.',
            style: TextStyle(color: ds.colors.textSecondary, height: 1.5),
          ),
        ],
      ),
    );
  }

  static Widget _buildFinancialRail(BuildContext context, dynamic dataPayload) {
    // Expected dynamic list of FinancialMetric (or raw maps)
    final metricsRaw = dataPayload as List<dynamic>;
    final ds = PrimeCareDesignSystem.of(context);
    final metrics = metricsRaw.map((m) {
      if (m is FinancialMetric) return m;
      return FinancialMetric.fromJson(m as Map<String, dynamic>);
    }).toList();

    return Column(
      children: metrics.map((metric) {
        final color = _inferColor(ds, metric.status);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: ds.colors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: color.withValues(alpha: 0.2)),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.05),
                blurRadius: 15,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(LucideIcons.landmark, color: color, size: 20),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.label.toUpperCase(),
                      style: TextStyle(
                        color: ds.colors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      metric.value,
                      style: TextStyle(
                        color: ds.colors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              if (metric.trend != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    metric.trend!,
                    style: TextStyle(
                      color: color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  static Widget _buildStitchScreen(BuildContext context, dynamic dataPayload) {
    final screenId = dataPayload as String;
    // Note: In a production environment, this would fetch the actual high-fidelity
    // components from the Stitch backend via the screenId.
    // For now, we delegate to the StitchEngineRenderer with simulated items
    // tagged with the screenId for traceability.
    return StitchEngineRenderer(
      featureId: screenId,
      items: [
        FeatureViewModel(
          id: 'ceo-1',
          title: 'Executive Revenue Command',
          description:
              'High-fidelity financial data stream for Screen $screenId',
          status: 'ACTIVE',
        ),
        FeatureViewModel(
          id: 'ceo-2',
          title: 'Institutional Risk Surveillance',
          description: 'Predictive risk monitoring for $screenId',
          status: 'MONITORING',
        ),
      ],
    );
  }

  static Widget _buildManagementAction(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: ds.colors.warning.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Critical Controls',
            style: TextStyle(
              color: ds.colors.warning,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildActionButton(
                context,
                'Quarantine Tenant',
                LucideIcons.lock,
                ds.colors.danger,
              ),
              _buildActionButton(
                context,
                'System Audit',
                LucideIcons.fileSearch,
                ds.colors.primary,
              ),
              _buildActionButton(
                context,
                'Freeze Payouts',
                LucideIcons.pause,
                ds.colors.warning,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildClinicalMetric(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final payloadMap = dataPayload as Map<String, dynamic>;
    final title = payloadMap['title'] as String? ?? 'Clinical Intelligence';
    final metrics = payloadMap['metrics'] as List<dynamic>? ?? [];
    final ds = PrimeCareDesignSystem.of(context);

    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: ds.colors.surface,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: ds.colors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: PrimeCareColors.black.withAlpha(20),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  color: ds.colors.textPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(LucideIcons.trendingUp, color: ds.colors.success, size: 18),
            ],
          ),
          const SizedBox(height: 24),
          ...metrics.map((mRaw) {
            final m = mRaw as Map<String, dynamic>;
            final label = m['label'] as String;
            final value = (m['value'] as num).toDouble();

            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          color: ds.colors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${(value * 100).toInt()}%',
                        style: TextStyle(
                          color: ds.colors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        decoration: BoxDecoration(
                          color: ds.colors.borderSubtle,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: value,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [ds.colors.primary, ds.colors.secondary],
                            ),
                            borderRadius: BorderRadius.circular(3),
                            boxShadow: [
                              BoxShadow(
                                color: ds.colors.primary.withValues(alpha: 0.3),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // FOUND1
  static Widget _buildComplianceGate(
    BuildContext context,
    dynamic dataPayload,
  ) {
    final ds = PrimeCareDesignSystem.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ds.colors.primary.withValues(alpha: 0.1),
            ds.colors.success.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ds.colors.success.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(LucideIcons.shieldCheck, color: ds.colors.success, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'REGULATORY COMPLIANCE GATE',
                  style: TextStyle(
                    color: ds.colors.success,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1.1,
                  ),
                ),
                Text(
                  'All institutional checkpoints verified and passed.',
                  style: TextStyle(
                    color: ds.colors.textSecondary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  static ComponentBuilder _buildUnknownComponent(String type) {
    return (BuildContext context, dynamic payload) {
      return Center(child: Text('Unknown component type: $type'));
    };
  }

  static Widget _buildAnalyticsChart(
    BuildContext context,
    dynamic dataPayload,
  ) {
    if (dataPayload is! AnalyticsChart) {
      return const SizedBox.shrink();
    }

    return Consumer(
      builder: (context, ref, child) {
        final auraToggles = ref.watch(auraDashboardToggleProvider);
        final isAuraActive = auraToggles[dataPayload.id] ?? false;

        final ds = PrimeCareDesignSystem.of(context);
        return PrimeCareChartCard(
          title: dataPayload.title,
          isAuraActive: isAuraActive,
          chart: SizedBox(
            height: 250,
            child: PrimeCareLineChart(
              chart: dataPayload,
              lineColor: _inferColor(ds, dataPayload.id),
              isPredictive: isAuraActive,
            ),
          ),
          isAuraSupported: true,
          onPinToggle: () {},
          onAuraToggle: () {
            ref
                .read(auraDashboardToggleProvider.notifier)
                .toggle(dataPayload.id);
          },
          onDetailPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => PrimeCareReportScreen(
                  reportId: dataPayload.reportId ?? 'unspecified',
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- Utility Methods ---
  static IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice'))
      return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule'))
      return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical'))
      return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn'))
      return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline'))
      return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  static Color _inferColor(PrimeCareDesignSystem ds, String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up' || s == 'active')
      return ds.colors.success;
    if (s == 'warning' || s == 'attention') return ds.colors.warning;
    if (s == 'critical' || s == 'down' || s == 'negative' || s == 'error')
      return ds.colors.danger;
    return ds.colors.primary;
  }

  static Widget _buildAIForecastingDashlet(
    BuildContext context,
    dynamic dataPayload,
  ) {
    if (dataPayload is! AIAnalyticsForecastingData) {
      return const SizedBox.shrink();
    }
    return AIForecastingDashlet(data: dataPayload);
  }
}
