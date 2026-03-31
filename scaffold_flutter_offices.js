const fs = require('fs');
const path = require('path');

// Target the existing Flutter application specifically
const rootDir = path.join(__dirname, 'apps', 'primecare_v4', 'lib', 'offices');

const structure = {
  // 1. Corporate / Head Office
  'corporate/roles/ceo': ['ceo_dashboard.dart', 'ceo_layout.dart', 'ceo_sidebar.dart', 'ceo_topbar.dart', 'ceo_settings.dart', 'analytics_dashboard.dart', 'financial_overview.dart'],
  'corporate/roles/coo': ['coo_dashboard.dart', 'coo_layout.dart', 'operations_overview.dart'],
  'corporate/roles/cfo': ['cfo_dashboard.dart', 'cfo_layout.dart', 'financial_reports.dart'],
  'corporate/roles/cto': ['cto_dashboard.dart', 'cto_layout.dart', 'system_settings.dart'],
  'corporate/roles/compliance_manager': ['compliance_dashboard.dart', 'compliance_tracking.dart', 'compliance_layout.dart'],
  'corporate/roles/head_of_bus_dev': ['bus_dev_dashboard.dart', 'global_leads.dart'],
  'corporate/roles/head_of_marketing': ['marketing_overview.dart'],
  'corporate/roles/training_director': ['training_admin_dashboard.dart'],

  // 2. Business Development Team
  'business_development/roles/regional_manager_ontario': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/regional_manager_usa': ['region_dashboard.dart', 'territory_tracking.dart'],
  'business_development/roles/franchise_sales_manager': ['pipeline_dashboard.dart', 'franchise_pipeline.dart'],
  'business_development/roles/partnership_manager': ['partner_management.dart'],
  'business_development/roles/territory_expansion_manager': ['expansion_dashboard.dart'],

  // 3. Franchise Level
  'franchise/roles/franchise_owner': ['owner_dashboard.dart', 'daily_operations.dart', 'franchise_layout.dart'],
  'franchise/roles/operations_manager': ['ops_manager_dashboard.dart', 'staff_management.dart'],
  'franchise/roles/scheduler': ['scheduling_dashboard.dart', 'master_schedule.dart'],
  'franchise/roles/billing_admin': ['billing_dashboard.dart', 'invoices.dart'],
  'franchise/roles/hr_hiring': ['hr_dashboard.dart', 'candidate_pipeline.dart'],

  // 4. Clinical Team
  'clinic/roles/rn': ['rn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart', 'rn_layout.dart'],
  'clinic/roles/rpn': ['rpn_dashboard.dart', 'care_plans.dart', 'treatment_notes.dart'],
  'clinic/roles/rmt': ['rmt_dashboard.dart', 'treatment_notes.dart', 'rmt_layout.dart'],
  'clinic/roles/psw': ['psw_dashboard.dart', 'daily_logs.dart'],

  // 5. Support Team
  'support/roles/customer_support': ['support_dashboard.dart', 'tickets.dart', 'issue_tracking.dart', 'support_layout.dart'],
  'support/roles/intake_coordinator': ['intake_dashboard.dart', 'client_intake_forms.dart'],
  'support/roles/quality_assurance': ['qa_dashboard.dart', 'qa_reports.dart'],
  'support/roles/training_coordinator': ['training_modules.dart'],

  // 6. Marketing and Local Growth
  'marketing/roles/local_marketing_manager': ['local_campaigns.dart', 'marketing_layout.dart'],
  'marketing/roles/community_outreach': ['community_events.dart'],
  'marketing/roles/territory_sales_manager': ['lead_generation.dart'],

  // 7. Client Side
  'client/roles/client': ['client_dashboard.dart', 'book_appointment.dart', 'view_schedule.dart', 'chat_with_provider.dart', 'payments.dart', 'client_layout.dart'],
  'client/roles/family_member': ['family_dashboard.dart', 'linked_accounts.dart'],

  // Shared Screens
  'shared_screens': ['global_settings.dart', 'global_profile.dart', 'notification_center.dart', 'messaging_hub.dart', 'document_vault.dart']
};

const commonUiTemplate = `import 'package:flutter/material.dart';

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generated Screen')),
      body: const Center(
        child: Text('Placeholder View'),
      ),
    );
  }
}
`;

function scaffold() {
  console.log('Generating architecture at:', rootDir);

  for (const [folder, files] of Object.entries(structure)) {
    const fullFolderPath = path.join(rootDir, ...folder.split('/'));
    
    // Create directory
    if (!fs.existsSync(fullFolderPath)) {
      fs.mkdirSync(fullFolderPath, { recursive: true });
    }

    // Create files inside directory (snake_case strictly)
    for (const file of files) {
      const filePath = path.join(fullFolderPath, file);
      if (!fs.existsSync(filePath)) {
        fs.writeFileSync(filePath, commonUiTemplate);
      }
    }
  }

  console.log('Successfully scaffolded all Flutter Office Roles and Layouts!');
}

scaffold();
