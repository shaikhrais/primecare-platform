// Governance - Category: middleware | Purpose: UPGRADED_BY_AI Automatically querying the synced Prisma models const data = await prisma.compliancemanagerauditsscree...
// UPGRADED_BY_AI
import 'dart:convert';
import 'package:server_core/server_core.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:database_client/database_client.dart';

part 'src/features/compliance_manager_audits_screen_routes/compliance_manager_audits_screen_routes.dart';
part 'src/features/compliance_manager_compliance_cases_screen_routes/compliance_manager_compliance_cases_screen_routes.dart';
part 'src/features/compliance_manager_corrective_actions_screen_routes/compliance_manager_corrective_actions_screen_routes.dart';
part 'src/features/compliance_manager_credential_tracking_screen_routes/compliance_manager_credential_tracking_screen_routes.dart';
part 'src/features/compliance_manager_dashboard_screen_routes/compliance_manager_dashboard_screen_routes.dart';
part 'src/features/compliance_manager_document_expiry_screen_routes/compliance_manager_document_expiry_screen_routes.dart';
part 'src/features/compliance_manager_incident_review_screen_routes/compliance_manager_incident_review_screen_routes.dart';
part 'src/features/compliance_manager_policies_screen_routes/compliance_manager_policies_screen_routes.dart';
part 'src/features/compliance_manager_reports_screen_routes/compliance_manager_reports_screen_routes.dart';
part 'src/features/compliance_manager_training_compliance_screen_routes/compliance_manager_training_compliance_screen_routes.dart';
part 'src/features/coo_compliance_view_screen_routes/coo_compliance_view_screen_routes.dart';
part 'src/features/cto_audit_logs_screen_routes/cto_audit_logs_screen_routes.dart';
part 'src/features/training_director_compliance_training_screen_routes/training_director_compliance_training_screen_routes.dart';
part 'src/features/franchise_owner_compliance_screen_routes/franchise_owner_compliance_screen_routes.dart';
part 'src/features/qa_dashboard_screen_routes/qa_dashboard_screen_routes.dart';
part 'src/features/quality_assurance_audits_screen_routes/quality_assurance_audits_screen_routes.dart';
part 'src/features/quality_assurance_compliance_checks_screen_routes/quality_assurance_compliance_checks_screen_routes.dart';

class ApiRoutes extends BaseModularApiRoutes {
  final prisma = PrismaClient();


  @override
  Iterable<BaseApiRoutes> get modules => [
    ComplianceManagerAuditsScreenRoutes(prisma),
    ComplianceManagerComplianceCasesScreenRoutes(prisma),
    ComplianceManagerCorrectiveActionsScreenRoutes(prisma),
    ComplianceManagerCredentialTrackingScreenRoutes(prisma),
    ComplianceManagerDashboardScreenRoutes(prisma),
    ComplianceManagerDocumentExpiryScreenRoutes(prisma),
    ComplianceManagerIncidentReviewScreenRoutes(prisma),
    ComplianceManagerPoliciesScreenRoutes(prisma),
    ComplianceManagerReportsScreenRoutes(prisma),
    ComplianceManagerTrainingComplianceScreenRoutes(prisma),
    CooComplianceViewScreenRoutes(prisma),
    CtoAuditLogsScreenRoutes(prisma),
    TrainingDirectorComplianceTrainingScreenRoutes(prisma),
    FranchiseOwnerComplianceScreenRoutes(prisma),
    QaDashboardScreenRoutes(prisma),
    QualityAssuranceAuditsScreenRoutes(prisma),
    QualityAssuranceComplianceChecksScreenRoutes(prisma),
  ];
}
