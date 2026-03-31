const fs = require('fs');
const path = require('path');

// Placing it explicitly in a highly visible primecare_frontend folder
const rootDir = path.join(__dirname, 'apps', 'primecare_frontend', 'src');

const structure = {
  'components/common': ['button.tsx', 'card.tsx'],
  'components/layouts': ['master_layout.tsx', 'provider_layout.tsx', 'admin_layout.tsx', 'client_layout.tsx'],
  'components/navigation': ['common_topbar.tsx', 'dynamic_sidebar.tsx'],
  
  // 1. Corporate / Head Office
  'offices/corporate/roles/ceo': ['ceo_dashboard.tsx', 'ceo_layout.tsx', 'ceo_sidebar.ts', 'ceo_topbar.ts', 'ceo_settings.tsx', 'analytics_dashboard.tsx', 'financial_overview.tsx'],
  'offices/corporate/roles/coo': ['coo_dashboard.tsx', 'coo_layout.tsx', 'operations_overview.tsx'],
  'offices/corporate/roles/cfo': ['cfo_dashboard.tsx', 'cfo_layout.tsx', 'financial_reports.tsx'],
  'offices/corporate/roles/cto': ['cto_dashboard.tsx', 'cto_layout.tsx', 'system_settings.tsx'],
  'offices/corporate/roles/compliance_manager': ['compliance_dashboard.tsx', 'compliance_tracking.tsx', 'compliance_layout.tsx'],
  'offices/corporate/roles/head_of_bus_dev': ['bus_dev_dashboard.tsx', 'global_leads.tsx'],
  'offices/corporate/roles/head_of_marketing': ['marketing_overview.tsx'],
  'offices/corporate/roles/training_director': ['training_admin_dashboard.tsx'],

  // 2. Business Development Team
  'offices/business_development/roles/regional_manager_ontario': ['region_dashboard.tsx', 'territory_tracking.tsx'],
  'offices/business_development/roles/regional_manager_usa': ['region_dashboard.tsx', 'territory_tracking.tsx'],
  'offices/business_development/roles/franchise_sales_manager': ['pipeline_dashboard.tsx', 'franchise_pipeline.tsx'],
  'offices/business_development/roles/partnership_manager': ['partner_management.tsx'],
  'offices/business_development/roles/territory_expansion_manager': ['expansion_dashboard.tsx'],

  // 3. Franchise Level
  'offices/franchise/roles/franchise_owner': ['owner_dashboard.tsx', 'daily_operations.tsx', 'franchise_layout.tsx'],
  'offices/franchise/roles/operations_manager': ['ops_manager_dashboard.tsx', 'staff_management.tsx'],
  'offices/franchise/roles/scheduler': ['scheduling_dashboard.tsx', 'master_schedule.tsx'],
  'offices/franchise/roles/billing_admin': ['billing_dashboard.tsx', 'invoices.tsx'],
  'offices/franchise/roles/hr_hiring': ['hr_dashboard.tsx', 'candidate_pipeline.tsx'],

  // 4. Clinical Team ('clinic' instead of 'clinical' as requested)
  'offices/clinic/roles/rn': ['rn_dashboard.tsx', 'care_plans.tsx', 'treatment_notes.tsx', 'rn_layout.tsx'],
  'offices/clinic/roles/rpn': ['rpn_dashboard.tsx', 'care_plans.tsx', 'treatment_notes.tsx'],
  'offices/clinic/roles/rmt': ['rmt_dashboard.tsx', 'treatment_notes.tsx', 'rmt_layout.tsx'],
  'offices/clinic/roles/psw': ['psw_dashboard.tsx', 'daily_logs.tsx'],

  // 5. Support Team
  'offices/support/roles/customer_support': ['support_dashboard.tsx', 'tickets.tsx', 'issue_tracking.tsx', 'support_layout.tsx'],
  'offices/support/roles/intake_coordinator': ['intake_dashboard.tsx', 'client_intake_forms.tsx'],
  'offices/support/roles/quality_assurance': ['qa_dashboard.tsx', 'qa_reports.tsx'],
  'offices/support/roles/training_coordinator': ['training_modules.tsx'],

  // 6. Marketing and Local Growth
  'offices/marketing/roles/local_marketing_manager': ['local_campaigns.tsx', 'marketing_layout.tsx'],
  'offices/marketing/roles/community_outreach': ['community_events.tsx'],
  'offices/marketing/roles/territory_sales_manager': ['lead_generation.tsx'],

  // 7. Client Side
  'offices/client/roles/client': ['client_dashboard.tsx', 'book_appointment.tsx', 'view_schedule.tsx', 'chat_with_provider.tsx', 'payments.tsx', 'client_layout.tsx'],
  'offices/client/roles/family_member': ['family_dashboard.tsx', 'linked_accounts.tsx'],

  // Shared Screens
  'shared_screens': ['global_settings.tsx', 'global_profile.tsx', 'notification_center.tsx', 'messaging_hub.tsx', 'document_vault.tsx']
};

const commonUiTemplate = `import React from 'react';\n\nexport default function Placeholder() {\n  return <div>Component Boilerplate</div>;\n}\n`;

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

  console.log('Successfully scaffolded all Office Roles and Layouts!');
}

scaffold();
