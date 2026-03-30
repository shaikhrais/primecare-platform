import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/forms/form_renderer_adapter.dart';
import '../core/auth/auth_provider.dart';
import '../modules/auth/login_page.dart';
import '../modules/auth/signup_page.dart';
import '../modules/auth/forgot_password_page.dart';
import '../modules/auth/logout_success_page.dart';
import '../modules/profile/global_profile_page.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_routes.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_layout.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_dashboard.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_settings.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_clients.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_staff.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_schedule.dart';
import '../modules/offices/corporate_head_office/founder_ceo/founder_ceo_reports.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_routes.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_layout.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_dashboard.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_settings.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_clients.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_staff.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_schedule.dart';
import '../modules/offices/corporate_head_office/coo_operations_head/coo_operations_head_reports.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_routes.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_layout.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_dashboard.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_settings.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_clients.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_staff.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_schedule.dart';
import '../modules/offices/corporate_head_office/cfo_finance_head/cfo_finance_head_reports.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_routes.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_layout.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_dashboard.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_settings.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_clients.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_staff.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_schedule.dart';
import '../modules/offices/corporate_head_office/cto_tech_head/cto_tech_head_reports.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_routes.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_layout.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_dashboard.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_settings.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_clients.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_staff.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_schedule.dart';
import '../modules/offices/corporate_head_office/compliance_manager/compliance_manager_reports.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_routes.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_layout.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_dashboard.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_settings.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_clients.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_staff.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_schedule.dart';
import '../modules/offices/corporate_head_office/head_business_development/head_business_development_reports.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_routes.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_layout.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_dashboard.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_settings.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_clients.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_staff.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_schedule.dart';
import '../modules/offices/corporate_head_office/head_marketing/head_marketing_reports.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_routes.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_layout.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_dashboard.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_settings.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_clients.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_staff.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_schedule.dart';
import '../modules/offices/corporate_head_office/training_director/training_director_reports.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_routes.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_layout.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_dashboard.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_settings.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_clients.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_staff.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_schedule.dart';
import '../modules/offices/corporate_head_office/director_of_nursing/director_of_nursing_reports.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_routes.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_layout.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_dashboard.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_settings.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_clients.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_staff.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_schedule.dart';
import '../modules/offices/business_development_team/regional_bd_manager_on/regional_bd_manager_on_reports.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_routes.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_layout.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_dashboard.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_settings.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_clients.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_staff.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_schedule.dart';
import '../modules/offices/business_development_team/regional_bd_manager_usa/regional_bd_manager_usa_reports.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_routes.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_layout.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_dashboard.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_settings.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_clients.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_staff.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_schedule.dart';
import '../modules/offices/business_development_team/franchise_sales_manager/franchise_sales_manager_reports.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_routes.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_layout.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_dashboard.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_settings.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_clients.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_staff.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_schedule.dart';
import '../modules/offices/business_development_team/partnership_manager/partnership_manager_reports.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_routes.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_layout.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_dashboard.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_settings.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_clients.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_staff.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_schedule.dart';
import '../modules/offices/business_development_team/territory_expansion_manager/territory_expansion_manager_reports.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_routes.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_layout.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_dashboard.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_settings.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_clients.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_staff.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_schedule.dart';
import '../modules/offices/franchise_level/franchise_owner/franchise_owner_reports.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_routes.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_layout.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_dashboard.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_settings.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_clients.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_staff.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_schedule.dart';
import '../modules/offices/franchise_level/operations_manager/operations_manager_reports.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_routes.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_layout.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_dashboard.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_settings.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_clients.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_staff.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_schedule.dart';
import '../modules/offices/franchise_level/scheduler_coordinator/scheduler_coordinator_reports.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_routes.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_layout.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_dashboard.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_settings.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_clients.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_staff.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_schedule.dart';
import '../modules/offices/franchise_level/billing_admin/billing_admin_reports.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_routes.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_layout.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_dashboard.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_settings.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_clients.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_staff.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_schedule.dart';
import '../modules/offices/franchise_level/hr_hiring/hr_hiring_reports.dart';
import '../modules/offices/clinical_team/rn/rn_routes.dart';
import '../modules/offices/clinical_team/rn/rn_layout.dart';
import '../modules/offices/clinical_team/rn/rn_dashboard.dart';
import '../modules/offices/clinical_team/rn/rn_settings.dart';
import '../modules/offices/clinical_team/rn/rn_clients.dart';
import '../modules/offices/clinical_team/rn/rn_staff.dart';
import '../modules/offices/clinical_team/rn/rn_schedule.dart';
import '../modules/offices/clinical_team/rn/rn_reports.dart';
import '../modules/offices/clinical_team/rpn/rpn_routes.dart';
import '../modules/offices/clinical_team/rpn/rpn_layout.dart';
import '../modules/offices/clinical_team/rpn/rpn_dashboard.dart';
import '../modules/offices/clinical_team/rpn/rpn_settings.dart';
import '../modules/offices/clinical_team/rpn/rpn_clients.dart';
import '../modules/offices/clinical_team/rpn/rpn_staff.dart';
import '../modules/offices/clinical_team/rpn/rpn_schedule.dart';
import '../modules/offices/clinical_team/rpn/rpn_reports.dart';
import '../modules/offices/clinical_team/rmt/rmt_routes.dart';
import '../modules/offices/clinical_team/rmt/rmt_layout.dart';
import '../modules/offices/clinical_team/rmt/rmt_dashboard.dart';
import '../modules/offices/clinical_team/rmt/rmt_settings.dart';
import '../modules/offices/clinical_team/rmt/rmt_clients.dart';
import '../modules/offices/clinical_team/rmt/rmt_staff.dart';
import '../modules/offices/clinical_team/rmt/rmt_schedule.dart';
import '../modules/offices/clinical_team/rmt/rmt_reports.dart';
import '../modules/offices/clinical_team/psw/psw_routes.dart';
import '../modules/offices/clinical_team/psw/psw_layout.dart';
import '../modules/offices/clinical_team/psw/psw_dashboard.dart';
import '../modules/offices/clinical_team/psw/psw_settings.dart';
import '../modules/offices/clinical_team/psw/psw_clients.dart';
import '../modules/offices/clinical_team/psw/psw_staff.dart';
import '../modules/offices/clinical_team/psw/psw_schedule.dart';
import '../modules/offices/clinical_team/psw/psw_reports.dart';
import '../modules/offices/clinical_team/psw/psw_data_entry_page.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_routes.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_layout.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_dashboard.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_settings.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_clients.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_staff.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_schedule.dart';
import '../modules/offices/clinical_team/physiotherapist/physiotherapist_reports.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_routes.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_layout.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_dashboard.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_settings.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_clients.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_staff.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_schedule.dart';
import '../modules/offices/clinical_team/care_coordinator/care_coordinator_reports.dart';
import '../modules/offices/support_team/customer_support/customer_support_routes.dart';
import '../modules/offices/support_team/customer_support/customer_support_layout.dart';
import '../modules/offices/support_team/customer_support/customer_support_dashboard.dart';
import '../modules/offices/support_team/customer_support/customer_support_settings.dart';
import '../modules/offices/support_team/customer_support/customer_support_clients.dart';
import '../modules/offices/support_team/customer_support/customer_support_staff.dart';
import '../modules/offices/support_team/customer_support/customer_support_schedule.dart';
import '../modules/offices/support_team/customer_support/customer_support_reports.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_routes.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_layout.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_dashboard.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_settings.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_clients.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_staff.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_schedule.dart';
import '../modules/offices/support_team/intake_coordinator/intake_coordinator_reports.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_routes.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_layout.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_dashboard.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_settings.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_clients.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_staff.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_schedule.dart';
import '../modules/offices/support_team/quality_assurance/quality_assurance_reports.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_routes.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_layout.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_dashboard.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_settings.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_clients.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_staff.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_schedule.dart';
import '../modules/offices/support_team/training_coordinator/training_coordinator_reports.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_routes.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_layout.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_dashboard.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_settings.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_clients.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_staff.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_schedule.dart';
import '../modules/offices/support_team/it_administrator/it_administrator_reports.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_routes.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_layout.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_dashboard.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_settings.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_clients.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_staff.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_schedule.dart';
import '../modules/offices/support_team/billing_specialist/billing_specialist_reports.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_routes.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_layout.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_dashboard.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_settings.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_clients.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_staff.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_schedule.dart';
import '../modules/offices/marketing_local_growth/local_marketing_manager/local_marketing_manager_reports.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_routes.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_layout.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_dashboard.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_settings.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_clients.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_staff.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_schedule.dart';
import '../modules/offices/marketing_local_growth/community_outreach/community_outreach_reports.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_routes.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_layout.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_dashboard.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_settings.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_clients.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_staff.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_schedule.dart';
import '../modules/offices/marketing_local_growth/territory_sales_manager/territory_sales_manager_reports.dart';
import '../modules/offices/client_side/client/client_routes.dart';
import '../modules/offices/client_side/client/client_layout.dart';
import '../modules/offices/client_side/client/client_dashboard.dart';
import '../modules/offices/client_side/client/client_settings.dart';
import '../modules/offices/client_side/client/client_clients.dart';
import '../modules/offices/client_side/client/client_staff.dart';
import '../modules/offices/client_side/client/client_schedule.dart';
import '../modules/offices/client_side/client/client_reports.dart';
import '../modules/offices/client_side/family_member/family_member_routes.dart';
import '../modules/offices/client_side/family_member/family_member_layout.dart';
import '../modules/offices/client_side/family_member/family_member_dashboard.dart';
import '../modules/offices/client_side/family_member/family_member_settings.dart';
import '../modules/offices/client_side/family_member/family_member_clients.dart';
import '../modules/offices/client_side/family_member/family_member_staff.dart';
import '../modules/offices/client_side/family_member/family_member_schedule.dart';
import '../modules/offices/client_side/family_member/family_member_reports.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;
  RouterNotifier(this._ref) {
    _ref.listen(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = RouterNotifier(ref);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: notifier,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuth = authState.isAuthenticated;
      final isAuthPage = state.uri.path == '/login' || state.uri.path == '/signup' || state.uri.path == '/forgot_password' || state.uri.path == '/logged_out';

      if (!isAuth && !isAuthPage) return '/login';
      
      if (isAuth && isAuthPage) {
        final role = authState.roleId;
        switch (role) {
          case 'coo_operations_head': return CooOperationsHeadRoutes.dashboard;
          case 'cfo_finance_head': return CfoFinanceHeadRoutes.dashboard;
          case 'cto_tech_head': return CtoTechHeadRoutes.dashboard;
          case 'compliance_manager': return ComplianceManagerRoutes.dashboard;
          case 'director_of_nursing': return DirectorOfNursingRoutes.dashboard;
          case 'franchise_owner': return FranchiseOwnerRoutes.dashboard;
          case 'rn': return RnRoutes.dashboard;
          case 'psw': return PswRoutes.dashboard;
          case 'physiotherapist': return PhysiotherapistRoutes.dashboard;
          case 'care_coordinator': return CareCoordinatorRoutes.dashboard;
          case 'customer_support': return CustomerSupportRoutes.dashboard;
          case 'client': return ClientRoutes.dashboard;
          case 'family_member': return FamilyMemberRoutes.dashboard;
          case 'founder_ceo': 
          default: 
            return FounderCeoRoutes.dashboard;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPageWidget(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupPageWidget(),
      ),
      GoRoute(
        path: '/forgot_password',
        builder: (context, state) => const ForgotPasswordPageWidget(),
      ),
      GoRoute(
        path: '/logged_out',
        builder: (context, state) => const LogoutSuccessPageWidget(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const GlobalProfilePageWidget(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return FounderCeoLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: FounderCeoRoutes.dashboard,
             builder: (_, __) => const FounderCeoDashboardWidget(),
           ),
           GoRoute(
             path: FounderCeoRoutes.clients,
             builder: (_, __) => const FounderCeoClientsWidget(),
           ),
           GoRoute(
             path: FounderCeoRoutes.staff,
             builder: (_, __) => const FounderCeoStaffWidget(),
           ),
           GoRoute(
             path: FounderCeoRoutes.schedule,
             builder: (_, __) => const FounderCeoScheduleWidget(),
           ),
           GoRoute(
             path: FounderCeoRoutes.reports,
             builder: (_, __) => const FounderCeoReportsWidget(),
           ),
           GoRoute(
             path: FounderCeoRoutes.settings,
             builder: (_, __) => const FounderCeoSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CooOperationsHeadLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CooOperationsHeadRoutes.dashboard,
             builder: (_, __) => const CooOperationsHeadDashboardWidget(),
           ),
           GoRoute(
             path: CooOperationsHeadRoutes.clients,
             builder: (_, __) => const CooOperationsHeadClientsWidget(),
           ),
           GoRoute(
             path: CooOperationsHeadRoutes.staff,
             builder: (_, __) => const CooOperationsHeadStaffWidget(),
           ),
           GoRoute(
             path: CooOperationsHeadRoutes.schedule,
             builder: (_, __) => const CooOperationsHeadScheduleWidget(),
           ),
           GoRoute(
             path: CooOperationsHeadRoutes.reports,
             builder: (_, __) => const CooOperationsHeadReportsWidget(),
           ),
           GoRoute(
             path: CooOperationsHeadRoutes.settings,
             builder: (_, __) => const CooOperationsHeadSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CfoFinanceHeadLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CfoFinanceHeadRoutes.dashboard,
             builder: (_, __) => const CfoFinanceHeadDashboardWidget(),
           ),
           GoRoute(
             path: CfoFinanceHeadRoutes.clients,
             builder: (_, __) => const CfoFinanceHeadClientsWidget(),
           ),
           GoRoute(
             path: CfoFinanceHeadRoutes.staff,
             builder: (_, __) => const CfoFinanceHeadStaffWidget(),
           ),
           GoRoute(
             path: CfoFinanceHeadRoutes.schedule,
             builder: (_, __) => const CfoFinanceHeadScheduleWidget(),
           ),
           GoRoute(
             path: CfoFinanceHeadRoutes.reports,
             builder: (_, __) => const CfoFinanceHeadReportsWidget(),
           ),
           GoRoute(
             path: CfoFinanceHeadRoutes.settings,
             builder: (_, __) => const CfoFinanceHeadSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CtoTechHeadLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CtoTechHeadRoutes.dashboard,
             builder: (_, __) => const CtoTechHeadDashboardWidget(),
           ),
           GoRoute(
             path: CtoTechHeadRoutes.clients,
             builder: (_, __) => const CtoTechHeadClientsWidget(),
           ),
           GoRoute(
             path: CtoTechHeadRoutes.staff,
             builder: (_, __) => const CtoTechHeadStaffWidget(),
           ),
           GoRoute(
             path: CtoTechHeadRoutes.schedule,
             builder: (_, __) => const CtoTechHeadScheduleWidget(),
           ),
           GoRoute(
             path: CtoTechHeadRoutes.reports,
             builder: (_, __) => const CtoTechHeadReportsWidget(),
           ),
           GoRoute(
             path: CtoTechHeadRoutes.settings,
             builder: (_, __) => const CtoTechHeadSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ComplianceManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: ComplianceManagerRoutes.dashboard,
             builder: (_, __) => const ComplianceManagerDashboardWidget(),
           ),
           GoRoute(
             path: ComplianceManagerRoutes.clients,
             builder: (_, __) => const ComplianceManagerClientsWidget(),
           ),
           GoRoute(
             path: ComplianceManagerRoutes.staff,
             builder: (_, __) => const ComplianceManagerStaffWidget(),
           ),
           GoRoute(
             path: ComplianceManagerRoutes.schedule,
             builder: (_, __) => const ComplianceManagerScheduleWidget(),
           ),
           GoRoute(
             path: ComplianceManagerRoutes.reports,
             builder: (_, __) => const ComplianceManagerReportsWidget(),
           ),
           GoRoute(
             path: ComplianceManagerRoutes.settings,
             builder: (_, __) => const ComplianceManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HeadBusinessDevelopmentLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.dashboard,
             builder: (_, __) => const HeadBusinessDevelopmentDashboardWidget(),
           ),
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.clients,
             builder: (_, __) => const HeadBusinessDevelopmentClientsWidget(),
           ),
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.staff,
             builder: (_, __) => const HeadBusinessDevelopmentStaffWidget(),
           ),
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.schedule,
             builder: (_, __) => const HeadBusinessDevelopmentScheduleWidget(),
           ),
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.reports,
             builder: (_, __) => const HeadBusinessDevelopmentReportsWidget(),
           ),
           GoRoute(
             path: HeadBusinessDevelopmentRoutes.settings,
             builder: (_, __) => const HeadBusinessDevelopmentSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HeadMarketingLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: HeadMarketingRoutes.dashboard,
             builder: (_, __) => const HeadMarketingDashboardWidget(),
           ),
           GoRoute(
             path: HeadMarketingRoutes.clients,
             builder: (_, __) => const HeadMarketingClientsWidget(),
           ),
           GoRoute(
             path: HeadMarketingRoutes.staff,
             builder: (_, __) => const HeadMarketingStaffWidget(),
           ),
           GoRoute(
             path: HeadMarketingRoutes.schedule,
             builder: (_, __) => const HeadMarketingScheduleWidget(),
           ),
           GoRoute(
             path: HeadMarketingRoutes.reports,
             builder: (_, __) => const HeadMarketingReportsWidget(),
           ),
           GoRoute(
             path: HeadMarketingRoutes.settings,
             builder: (_, __) => const HeadMarketingSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return TrainingDirectorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: TrainingDirectorRoutes.dashboard,
             builder: (_, __) => const TrainingDirectorDashboardWidget(),
           ),
           GoRoute(
             path: TrainingDirectorRoutes.clients,
             builder: (_, __) => const TrainingDirectorClientsWidget(),
           ),
           GoRoute(
             path: TrainingDirectorRoutes.staff,
             builder: (_, __) => const TrainingDirectorStaffWidget(),
           ),
           GoRoute(
             path: TrainingDirectorRoutes.schedule,
             builder: (_, __) => const TrainingDirectorScheduleWidget(),
           ),
           GoRoute(
             path: TrainingDirectorRoutes.reports,
             builder: (_, __) => const TrainingDirectorReportsWidget(),
           ),
           GoRoute(
             path: TrainingDirectorRoutes.settings,
             builder: (_, __) => const TrainingDirectorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return DirectorOfNursingLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: DirectorOfNursingRoutes.dashboard,
             builder: (_, __) => const DirectorOfNursingDashboardWidget(),
           ),
           GoRoute(
             path: DirectorOfNursingRoutes.clients,
             builder: (_, __) => const DirectorOfNursingClientsWidget(),
           ),
           GoRoute(
             path: DirectorOfNursingRoutes.staff,
             builder: (_, __) => const DirectorOfNursingStaffWidget(),
           ),
           GoRoute(
             path: DirectorOfNursingRoutes.schedule,
             builder: (_, __) => const DirectorOfNursingScheduleWidget(),
           ),
           GoRoute(
             path: DirectorOfNursingRoutes.reports,
             builder: (_, __) => const DirectorOfNursingReportsWidget(),
           ),
           GoRoute(
             path: DirectorOfNursingRoutes.settings,
             builder: (_, __) => const DirectorOfNursingSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RegionalBdManagerOnLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: RegionalBdManagerOnRoutes.dashboard,
             builder: (_, __) => const RegionalBdManagerOnDashboardWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerOnRoutes.clients,
             builder: (_, __) => const RegionalBdManagerOnClientsWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerOnRoutes.staff,
             builder: (_, __) => const RegionalBdManagerOnStaffWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerOnRoutes.schedule,
             builder: (_, __) => const RegionalBdManagerOnScheduleWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerOnRoutes.reports,
             builder: (_, __) => const RegionalBdManagerOnReportsWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerOnRoutes.settings,
             builder: (_, __) => const RegionalBdManagerOnSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RegionalBdManagerUsaLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: RegionalBdManagerUsaRoutes.dashboard,
             builder: (_, __) => const RegionalBdManagerUsaDashboardWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerUsaRoutes.clients,
             builder: (_, __) => const RegionalBdManagerUsaClientsWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerUsaRoutes.staff,
             builder: (_, __) => const RegionalBdManagerUsaStaffWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerUsaRoutes.schedule,
             builder: (_, __) => const RegionalBdManagerUsaScheduleWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerUsaRoutes.reports,
             builder: (_, __) => const RegionalBdManagerUsaReportsWidget(),
           ),
           GoRoute(
             path: RegionalBdManagerUsaRoutes.settings,
             builder: (_, __) => const RegionalBdManagerUsaSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return FranchiseSalesManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: FranchiseSalesManagerRoutes.dashboard,
             builder: (_, __) => const FranchiseSalesManagerDashboardWidget(),
           ),
           GoRoute(
             path: FranchiseSalesManagerRoutes.clients,
             builder: (_, __) => const FranchiseSalesManagerClientsWidget(),
           ),
           GoRoute(
             path: FranchiseSalesManagerRoutes.staff,
             builder: (_, __) => const FranchiseSalesManagerStaffWidget(),
           ),
           GoRoute(
             path: FranchiseSalesManagerRoutes.schedule,
             builder: (_, __) => const FranchiseSalesManagerScheduleWidget(),
           ),
           GoRoute(
             path: FranchiseSalesManagerRoutes.reports,
             builder: (_, __) => const FranchiseSalesManagerReportsWidget(),
           ),
           GoRoute(
             path: FranchiseSalesManagerRoutes.settings,
             builder: (_, __) => const FranchiseSalesManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return PartnershipManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: PartnershipManagerRoutes.dashboard,
             builder: (_, __) => const PartnershipManagerDashboardWidget(),
           ),
           GoRoute(
             path: PartnershipManagerRoutes.clients,
             builder: (_, __) => const PartnershipManagerClientsWidget(),
           ),
           GoRoute(
             path: PartnershipManagerRoutes.staff,
             builder: (_, __) => const PartnershipManagerStaffWidget(),
           ),
           GoRoute(
             path: PartnershipManagerRoutes.schedule,
             builder: (_, __) => const PartnershipManagerScheduleWidget(),
           ),
           GoRoute(
             path: PartnershipManagerRoutes.reports,
             builder: (_, __) => const PartnershipManagerReportsWidget(),
           ),
           GoRoute(
             path: PartnershipManagerRoutes.settings,
             builder: (_, __) => const PartnershipManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return TerritoryExpansionManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: TerritoryExpansionManagerRoutes.dashboard,
             builder: (_, __) => const TerritoryExpansionManagerDashboardWidget(),
           ),
           GoRoute(
             path: TerritoryExpansionManagerRoutes.clients,
             builder: (_, __) => const TerritoryExpansionManagerClientsWidget(),
           ),
           GoRoute(
             path: TerritoryExpansionManagerRoutes.staff,
             builder: (_, __) => const TerritoryExpansionManagerStaffWidget(),
           ),
           GoRoute(
             path: TerritoryExpansionManagerRoutes.schedule,
             builder: (_, __) => const TerritoryExpansionManagerScheduleWidget(),
           ),
           GoRoute(
             path: TerritoryExpansionManagerRoutes.reports,
             builder: (_, __) => const TerritoryExpansionManagerReportsWidget(),
           ),
           GoRoute(
             path: TerritoryExpansionManagerRoutes.settings,
             builder: (_, __) => const TerritoryExpansionManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return FranchiseOwnerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: FranchiseOwnerRoutes.dashboard,
             builder: (_, __) => const FranchiseOwnerDashboardWidget(),
           ),
           GoRoute(
             path: FranchiseOwnerRoutes.clients,
             builder: (_, __) => const FranchiseOwnerClientsWidget(),
           ),
           GoRoute(
             path: FranchiseOwnerRoutes.staff,
             builder: (_, __) => const FranchiseOwnerStaffWidget(),
           ),
           GoRoute(
             path: FranchiseOwnerRoutes.schedule,
             builder: (_, __) => const FranchiseOwnerScheduleWidget(),
           ),
           GoRoute(
             path: FranchiseOwnerRoutes.reports,
             builder: (_, __) => const FranchiseOwnerReportsWidget(),
           ),
           GoRoute(
             path: FranchiseOwnerRoutes.settings,
             builder: (_, __) => const FranchiseOwnerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return OperationsManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: OperationsManagerRoutes.dashboard,
             builder: (_, __) => const OperationsManagerDashboardWidget(),
           ),
           GoRoute(
             path: OperationsManagerRoutes.clients,
             builder: (_, __) => const OperationsManagerClientsWidget(),
           ),
           GoRoute(
             path: OperationsManagerRoutes.staff,
             builder: (_, __) => const OperationsManagerStaffWidget(),
           ),
           GoRoute(
             path: OperationsManagerRoutes.schedule,
             builder: (_, __) => const OperationsManagerScheduleWidget(),
           ),
           GoRoute(
             path: OperationsManagerRoutes.reports,
             builder: (_, __) => const OperationsManagerReportsWidget(),
           ),
           GoRoute(
             path: OperationsManagerRoutes.settings,
             builder: (_, __) => const OperationsManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return SchedulerCoordinatorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: SchedulerCoordinatorRoutes.dashboard,
             builder: (_, __) => const SchedulerCoordinatorDashboardWidget(),
           ),
           GoRoute(
             path: SchedulerCoordinatorRoutes.clients,
             builder: (_, __) => const SchedulerCoordinatorClientsWidget(),
           ),
           GoRoute(
             path: SchedulerCoordinatorRoutes.staff,
             builder: (_, __) => const SchedulerCoordinatorStaffWidget(),
           ),
           GoRoute(
             path: SchedulerCoordinatorRoutes.schedule,
             builder: (_, __) => const SchedulerCoordinatorScheduleWidget(),
           ),
           GoRoute(
             path: SchedulerCoordinatorRoutes.reports,
             builder: (_, __) => const SchedulerCoordinatorReportsWidget(),
           ),
           GoRoute(
             path: SchedulerCoordinatorRoutes.settings,
             builder: (_, __) => const SchedulerCoordinatorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BillingAdminLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: BillingAdminRoutes.dashboard,
             builder: (_, __) => const BillingAdminDashboardWidget(),
           ),
           GoRoute(
             path: BillingAdminRoutes.clients,
             builder: (_, __) => const BillingAdminClientsWidget(),
           ),
           GoRoute(
             path: BillingAdminRoutes.staff,
             builder: (_, __) => const BillingAdminStaffWidget(),
           ),
           GoRoute(
             path: BillingAdminRoutes.schedule,
             builder: (_, __) => const BillingAdminScheduleWidget(),
           ),
           GoRoute(
             path: BillingAdminRoutes.reports,
             builder: (_, __) => const BillingAdminReportsWidget(),
           ),
           GoRoute(
             path: BillingAdminRoutes.settings,
             builder: (_, __) => const BillingAdminSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return HrHiringLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: HrHiringRoutes.dashboard,
             builder: (_, __) => const HrHiringDashboardWidget(),
           ),
           GoRoute(
             path: HrHiringRoutes.clients,
             builder: (_, __) => const HrHiringClientsWidget(),
           ),
           GoRoute(
             path: HrHiringRoutes.staff,
             builder: (_, __) => const HrHiringStaffWidget(),
           ),
           GoRoute(
             path: HrHiringRoutes.schedule,
             builder: (_, __) => const HrHiringScheduleWidget(),
           ),
           GoRoute(
             path: HrHiringRoutes.reports,
             builder: (_, __) => const HrHiringReportsWidget(),
           ),
           GoRoute(
             path: HrHiringRoutes.settings,
             builder: (_, __) => const HrHiringSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RnLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: RnRoutes.dashboard,
             builder: (_, __) => const RnDashboardWidget(),
           ),
           GoRoute(
             path: RnRoutes.clients,
             builder: (_, __) => const RnClientsWidget(),
           ),
           GoRoute(
             path: RnRoutes.staff,
             builder: (_, __) => const RnStaffWidget(),
           ),
           GoRoute(
             path: RnRoutes.schedule,
             builder: (_, __) => const RnScheduleWidget(),
           ),
           GoRoute(
             path: RnRoutes.reports,
             builder: (_, __) => const RnReportsWidget(),
           ),
           GoRoute(
             path: RnRoutes.settings,
             builder: (_, __) => const RnSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RpnLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: RpnRoutes.dashboard,
             builder: (_, __) => const RpnDashboardWidget(),
           ),
           GoRoute(
             path: RpnRoutes.clients,
             builder: (_, __) => const RpnClientsWidget(),
           ),
           GoRoute(
             path: RpnRoutes.staff,
             builder: (_, __) => const RpnStaffWidget(),
           ),
           GoRoute(
             path: RpnRoutes.schedule,
             builder: (_, __) => const RpnScheduleWidget(),
           ),
           GoRoute(
             path: RpnRoutes.reports,
             builder: (_, __) => const RpnReportsWidget(),
           ),
           GoRoute(
             path: RpnRoutes.settings,
             builder: (_, __) => const RpnSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return RmtLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: RmtRoutes.dashboard,
             builder: (_, __) => const RmtDashboardWidget(),
           ),
           GoRoute(
             path: RmtRoutes.clients,
             builder: (_, __) => const RmtClientsWidget(),
           ),
           GoRoute(
             path: RmtRoutes.staff,
             builder: (_, __) => const RmtStaffWidget(),
           ),
           GoRoute(
             path: RmtRoutes.schedule,
             builder: (_, __) => const RmtScheduleWidget(),
           ),
           GoRoute(
             path: RmtRoutes.reports,
             builder: (_, __) => const RmtReportsWidget(),
           ),
           GoRoute(
             path: RmtRoutes.settings,
             builder: (_, __) => const RmtSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return PswLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: PswRoutes.dashboard,
             builder: (_, __) => const PswDashboardWidget(),
           ),
           GoRoute(
             path: PswRoutes.clients,
             builder: (_, __) => const PswClientsWidget(),
           ),
           GoRoute(
             path: PswRoutes.staff,
             builder: (_, __) => const PswStaffWidget(),
           ),
           GoRoute(
             path: PswRoutes.schedule,
             builder: (_, __) => const PswScheduleWidget(),
           ),
           GoRoute(
             path: PswRoutes.reports,
             builder: (_, __) => const PswReportsWidget(),
           ),
           GoRoute(
             path: PswRoutes.settings,
             builder: (_, __) => const PswSettingsWidget(),
           ),
           GoRoute(
             path: PswRoutes.allForms,
             builder: (_, __) => const PswDataEntryPage(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return PhysiotherapistLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: PhysiotherapistRoutes.dashboard,
             builder: (_, __) => const PhysiotherapistDashboardWidget(),
           ),
           GoRoute(
             path: PhysiotherapistRoutes.clients,
             builder: (_, __) => const PhysiotherapistClientsWidget(),
           ),
           GoRoute(
             path: PhysiotherapistRoutes.staff,
             builder: (_, __) => const PhysiotherapistStaffWidget(),
           ),
           GoRoute(
             path: PhysiotherapistRoutes.schedule,
             builder: (_, __) => const PhysiotherapistScheduleWidget(),
           ),
           GoRoute(
             path: PhysiotherapistRoutes.reports,
             builder: (_, __) => const PhysiotherapistReportsWidget(),
           ),
           GoRoute(
             path: PhysiotherapistRoutes.settings,
             builder: (_, __) => const PhysiotherapistSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CareCoordinatorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CareCoordinatorRoutes.dashboard,
             builder: (_, __) => const CareCoordinatorDashboardWidget(),
           ),
           GoRoute(
             path: CareCoordinatorRoutes.clients,
             builder: (_, __) => const CareCoordinatorClientsWidget(),
           ),
           GoRoute(
             path: CareCoordinatorRoutes.staff,
             builder: (_, __) => const CareCoordinatorStaffWidget(),
           ),
           GoRoute(
             path: CareCoordinatorRoutes.schedule,
             builder: (_, __) => const CareCoordinatorScheduleWidget(),
           ),
           GoRoute(
             path: CareCoordinatorRoutes.reports,
             builder: (_, __) => const CareCoordinatorReportsWidget(),
           ),
           GoRoute(
             path: CareCoordinatorRoutes.settings,
             builder: (_, __) => const CareCoordinatorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CustomerSupportLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CustomerSupportRoutes.dashboard,
             builder: (_, __) => const CustomerSupportDashboardWidget(),
           ),
           GoRoute(
             path: CustomerSupportRoutes.clients,
             builder: (_, __) => const CustomerSupportClientsWidget(),
           ),
           GoRoute(
             path: CustomerSupportRoutes.staff,
             builder: (_, __) => const CustomerSupportStaffWidget(),
           ),
           GoRoute(
             path: CustomerSupportRoutes.schedule,
             builder: (_, __) => const CustomerSupportScheduleWidget(),
           ),
           GoRoute(
             path: CustomerSupportRoutes.reports,
             builder: (_, __) => const CustomerSupportReportsWidget(),
           ),
           GoRoute(
             path: CustomerSupportRoutes.settings,
             builder: (_, __) => const CustomerSupportSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return IntakeCoordinatorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: IntakeCoordinatorRoutes.dashboard,
             builder: (_, __) => const IntakeCoordinatorDashboardWidget(),
           ),
           GoRoute(
             path: IntakeCoordinatorRoutes.clients,
             builder: (_, __) => const IntakeCoordinatorClientsWidget(),
           ),
           GoRoute(
             path: IntakeCoordinatorRoutes.staff,
             builder: (_, __) => const IntakeCoordinatorStaffWidget(),
           ),
           GoRoute(
             path: IntakeCoordinatorRoutes.schedule,
             builder: (_, __) => const IntakeCoordinatorScheduleWidget(),
           ),
           GoRoute(
             path: IntakeCoordinatorRoutes.reports,
             builder: (_, __) => const IntakeCoordinatorReportsWidget(),
           ),
           GoRoute(
             path: IntakeCoordinatorRoutes.settings,
             builder: (_, __) => const IntakeCoordinatorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return QualityAssuranceLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: QualityAssuranceRoutes.dashboard,
             builder: (_, __) => const QualityAssuranceDashboardWidget(),
           ),
           GoRoute(
             path: QualityAssuranceRoutes.clients,
             builder: (_, __) => const QualityAssuranceClientsWidget(),
           ),
           GoRoute(
             path: QualityAssuranceRoutes.staff,
             builder: (_, __) => const QualityAssuranceStaffWidget(),
           ),
           GoRoute(
             path: QualityAssuranceRoutes.schedule,
             builder: (_, __) => const QualityAssuranceScheduleWidget(),
           ),
           GoRoute(
             path: QualityAssuranceRoutes.reports,
             builder: (_, __) => const QualityAssuranceReportsWidget(),
           ),
           GoRoute(
             path: QualityAssuranceRoutes.settings,
             builder: (_, __) => const QualityAssuranceSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return TrainingCoordinatorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: TrainingCoordinatorRoutes.dashboard,
             builder: (_, __) => const TrainingCoordinatorDashboardWidget(),
           ),
           GoRoute(
             path: TrainingCoordinatorRoutes.clients,
             builder: (_, __) => const TrainingCoordinatorClientsWidget(),
           ),
           GoRoute(
             path: TrainingCoordinatorRoutes.staff,
             builder: (_, __) => const TrainingCoordinatorStaffWidget(),
           ),
           GoRoute(
             path: TrainingCoordinatorRoutes.schedule,
             builder: (_, __) => const TrainingCoordinatorScheduleWidget(),
           ),
           GoRoute(
             path: TrainingCoordinatorRoutes.reports,
             builder: (_, __) => const TrainingCoordinatorReportsWidget(),
           ),
           GoRoute(
             path: TrainingCoordinatorRoutes.settings,
             builder: (_, __) => const TrainingCoordinatorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ItAdministratorLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: ItAdministratorRoutes.dashboard,
             builder: (_, __) => const ItAdministratorDashboardWidget(),
           ),
           GoRoute(
             path: ItAdministratorRoutes.clients,
             builder: (_, __) => const ItAdministratorClientsWidget(),
           ),
           GoRoute(
             path: ItAdministratorRoutes.staff,
             builder: (_, __) => const ItAdministratorStaffWidget(),
           ),
           GoRoute(
             path: ItAdministratorRoutes.schedule,
             builder: (_, __) => const ItAdministratorScheduleWidget(),
           ),
           GoRoute(
             path: ItAdministratorRoutes.reports,
             builder: (_, __) => const ItAdministratorReportsWidget(),
           ),
           GoRoute(
             path: ItAdministratorRoutes.settings,
             builder: (_, __) => const ItAdministratorSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return BillingSpecialistLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: BillingSpecialistRoutes.dashboard,
             builder: (_, __) => const BillingSpecialistDashboardWidget(),
           ),
           GoRoute(
             path: BillingSpecialistRoutes.clients,
             builder: (_, __) => const BillingSpecialistClientsWidget(),
           ),
           GoRoute(
             path: BillingSpecialistRoutes.staff,
             builder: (_, __) => const BillingSpecialistStaffWidget(),
           ),
           GoRoute(
             path: BillingSpecialistRoutes.schedule,
             builder: (_, __) => const BillingSpecialistScheduleWidget(),
           ),
           GoRoute(
             path: BillingSpecialistRoutes.reports,
             builder: (_, __) => const BillingSpecialistReportsWidget(),
           ),
           GoRoute(
             path: BillingSpecialistRoutes.settings,
             builder: (_, __) => const BillingSpecialistSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return LocalMarketingManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: LocalMarketingManagerRoutes.dashboard,
             builder: (_, __) => const LocalMarketingManagerDashboardWidget(),
           ),
           GoRoute(
             path: LocalMarketingManagerRoutes.clients,
             builder: (_, __) => const LocalMarketingManagerClientsWidget(),
           ),
           GoRoute(
             path: LocalMarketingManagerRoutes.staff,
             builder: (_, __) => const LocalMarketingManagerStaffWidget(),
           ),
           GoRoute(
             path: LocalMarketingManagerRoutes.schedule,
             builder: (_, __) => const LocalMarketingManagerScheduleWidget(),
           ),
           GoRoute(
             path: LocalMarketingManagerRoutes.reports,
             builder: (_, __) => const LocalMarketingManagerReportsWidget(),
           ),
           GoRoute(
             path: LocalMarketingManagerRoutes.settings,
             builder: (_, __) => const LocalMarketingManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return CommunityOutreachLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: CommunityOutreachRoutes.dashboard,
             builder: (_, __) => const CommunityOutreachDashboardWidget(),
           ),
           GoRoute(
             path: CommunityOutreachRoutes.clients,
             builder: (_, __) => const CommunityOutreachClientsWidget(),
           ),
           GoRoute(
             path: CommunityOutreachRoutes.staff,
             builder: (_, __) => const CommunityOutreachStaffWidget(),
           ),
           GoRoute(
             path: CommunityOutreachRoutes.schedule,
             builder: (_, __) => const CommunityOutreachScheduleWidget(),
           ),
           GoRoute(
             path: CommunityOutreachRoutes.reports,
             builder: (_, __) => const CommunityOutreachReportsWidget(),
           ),
           GoRoute(
             path: CommunityOutreachRoutes.settings,
             builder: (_, __) => const CommunityOutreachSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return TerritorySalesManagerLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: TerritorySalesManagerRoutes.dashboard,
             builder: (_, __) => const TerritorySalesManagerDashboardWidget(),
           ),
           GoRoute(
             path: TerritorySalesManagerRoutes.clients,
             builder: (_, __) => const TerritorySalesManagerClientsWidget(),
           ),
           GoRoute(
             path: TerritorySalesManagerRoutes.staff,
             builder: (_, __) => const TerritorySalesManagerStaffWidget(),
           ),
           GoRoute(
             path: TerritorySalesManagerRoutes.schedule,
             builder: (_, __) => const TerritorySalesManagerScheduleWidget(),
           ),
           GoRoute(
             path: TerritorySalesManagerRoutes.reports,
             builder: (_, __) => const TerritorySalesManagerReportsWidget(),
           ),
           GoRoute(
             path: TerritorySalesManagerRoutes.settings,
             builder: (_, __) => const TerritorySalesManagerSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return ClientLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: ClientRoutes.dashboard,
             builder: (_, __) => const ClientDashboardWidget(),
           ),
           GoRoute(
             path: ClientRoutes.clients,
             builder: (_, __) => const ClientClientsWidget(),
           ),
           GoRoute(
             path: ClientRoutes.staff,
             builder: (_, __) => const ClientStaffWidget(),
           ),
           GoRoute(
             path: ClientRoutes.schedule,
             builder: (_, __) => const ClientScheduleWidget(),
           ),
           GoRoute(
             path: ClientRoutes.reports,
             builder: (_, __) => const ClientReportsWidget(),
           ),
           GoRoute(
             path: ClientRoutes.settings,
             builder: (_, __) => const ClientSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),
      ShellRoute(
        builder: (context, state, child) {
          return FamilyMemberLayoutWidget(childContent: child);
        },
        routes: [
           GoRoute(
             path: FamilyMemberRoutes.dashboard,
             builder: (_, __) => const FamilyMemberDashboardWidget(),
           ),
           GoRoute(
             path: FamilyMemberRoutes.clients,
             builder: (_, __) => const FamilyMemberClientsWidget(),
           ),
           GoRoute(
             path: FamilyMemberRoutes.staff,
             builder: (_, __) => const FamilyMemberStaffWidget(),
           ),
           GoRoute(
             path: FamilyMemberRoutes.schedule,
             builder: (_, __) => const FamilyMemberScheduleWidget(),
           ),
           GoRoute(
             path: FamilyMemberRoutes.reports,
             builder: (_, __) => const FamilyMemberReportsWidget(),
           ),
           GoRoute(
             path: FamilyMemberRoutes.settings,
             builder: (_, __) => const FamilyMemberSettingsWidget(),
           ),
           GoRoute(
             path: '/schema-form/:formId',
             builder: (context, state) => FormRendererAdapter(formId: state.pathParameters['formId']!),
           ),
        ],
      ),

  ],
);
});
