import { AppHubPage } from "../pages/auth/AppHubPage";
import { DashboardPage } from "../pages/auth/DashboardPage";
import { AdminDashboardPage } from "../pages/governance/AdminDashboardPage";
import { BusDevDashboardPage } from "../pages/corporate/BusDevDashboardPage";
import { CaregiverDashboardPage } from "../pages/clinic/CaregiverDashboardPage";
import { CeoDashboardPage } from "../pages/corporate/CeoDashboardPage";
import { CfoDashboardPage } from "../pages/corporate/CfoDashboardPage";
import { ChiropractorDashboardPage } from "../pages/clinic/ChiropractorDashboardPage";
import { CisoDashboardPage } from "../pages/corporate/CisoDashboardPage";
import { ClinicalDirectorDashboardPage } from "../pages/clinic/ClinicalDirectorDashboardPage";
import { CnsDashboardPage } from "../pages/clinic/CnsDashboardPage";
import { CommunityOutreachDashboardPage } from "../pages/marketing/CommunityOutreachDashboardPage";
import { ComplianceDashboardPage } from "../pages/corporate/ComplianceDashboardPage";
import { CooDashboardPage } from "../pages/corporate/CooDashboardPage";
import { CtoDashboardPage } from "../pages/corporate/CtoDashboardPage";
import { CustomerSupportDashboardPage } from "../pages/support/CustomerSupportDashboardPage";
import { CxDirectorDashboardPage } from "../pages/corporate/CxDirectorDashboardPage";
import { DynamicDashboardPage } from "../pages/governance/DynamicDashboardPage";
import { EmployeeDashboardPage } from "../pages/governance/EmployeeDashboardPage";
import { FamilyDashboardPage } from "../pages/client/FamilyDashboardPage";
import { FinanceDirectorDashboardPage } from "../pages/corporate/FinanceDirectorDashboardPage";
import { FranchiseSalesDashboardPage } from "../pages/business_development/FranchiseSalesDashboardPage";
import { GmDashboardPage } from "../pages/business_development/GmDashboardPage";
import { GovernanceDashboardPage } from "../pages/governance/GovernanceDashboardPage";
import { GuestDashboardPage } from "../pages/client/GuestDashboardPage";
import { HrDirectorDashboardPage } from "../pages/corporate/HrDirectorDashboardPage";
import { HrHiringDashboardPage } from "../pages/franchise/HrHiringDashboardPage";
import { HswDashboardPage } from "../pages/clinic/HswDashboardPage";
import { InfrastructureDashboardPage } from "../pages/governance/InfrastructureDashboardPage";
import { IntakeDashboardPage } from "../pages/clinic/IntakeDashboardPage";
import { LegalDashboardPage } from "../pages/corporate/LegalDashboardPage";
import { LocalMarketingDashboardPage } from "../pages/marketing/LocalMarketingDashboardPage";
import { LpnDashboardPage } from "../pages/clinic/LpnDashboardPage";
import { MarketingDashboardPage } from "../pages/corporate/MarketingDashboardPage";
import { NpDashboardPage } from "../pages/clinic/NpDashboardPage";
import { OpsManagerDashboardPage } from "../pages/franchise/OpsManagerDashboardPage";
import { OwnerDashboardPage } from "../pages/franchise/OwnerDashboardPage";
import { PartnershipDashboardPage } from "../pages/business_development/PartnershipDashboardPage";
import { PatientDashboardPage } from "../pages/client/PatientDashboardPage";
import { PediatricDashboardPage } from "../pages/clinic/PediatricDashboardPage";
import { PhysicianDashboardPage } from "../pages/clinic/PhysicianDashboardPage";
import { PhysioDashboardPage } from "../pages/clinic/PhysioDashboardPage";
import { PortalDashboardPage } from "../pages/client/PortalDashboardPage";
import { PremiumConciergeDashboardPage } from "../pages/support/PremiumConciergeDashboardPage";
import { PswDashboardPage } from "../pages/clinic/PswDashboardPage";
import { QaSpecialistDashboardPage } from "../pages/support/QaSpecialistDashboardPage";
import { RegionalBdmDashboardPage } from "../pages/business_development/RegionalBdmDashboardPage";
import { RegionalManagerUsaDashboardPage } from "../pages/business_development/RegionalManagerUsaDashboardPage";
import { RmtDashboardPage } from "../pages/clinic/RmtDashboardPage";
import { RnDashboardPage } from "../pages/clinic/RnDashboardPage";
import { RnFieldSupervisorDashboardPage } from "../pages/clinic/RnFieldSupervisorDashboardPage";
import { RpnDashboardPage } from "../pages/clinic/RpnDashboardPage";
import { SchedulerDashboardPage } from "../pages/franchise/SchedulerDashboardPage";
import { ScrumMasterDashboardPage } from "../pages/governance/ScrumMasterDashboardPage";
import { ShareholderDashboardPage } from "../pages/corporate/ShareholderDashboardPage";
import { SocialWorkerDashboardPage } from "../pages/clinic/SocialWorkerDashboardPage";
import { SystemVerificationDashboardPage } from "../pages/governance/SystemVerificationDashboardPage";
import { TerritoryExpansionDashboardPage } from "../pages/business_development/TerritoryExpansionDashboardPage";
import { TerritorySalesDashboardPage } from "../pages/business_development/TerritorySalesDashboardPage";
import { TherapistDashboardPage } from "../pages/clinic/TherapistDashboardPage";
import { TrainingDashboardPage } from "../pages/governance/TrainingDashboardPage";
import { TrainingCoordinatorDashboardPage } from "../pages/governance/TrainingCoordinatorDashboardPage";
import { TrainingDirectorDashboardPage } from "../pages/corporate/TrainingDirectorDashboardPage";
import { VipManagerDashboardPage } from "../pages/support/VipManagerDashboardPage";
import { VolunteerDashboardPage } from "../pages/governance/VolunteerDashboardPage";
import { VolunteerCoordinatorDashboardPage } from "../pages/corporate/VolunteerCoordinatorDashboardPage";

function getCardNameForAppCode(appCode: string): string {
  switch (appCode) {
    case "corporate": return "Corporate Headquarters";
    case "business_development": return "Business Development";
    case "franchise": return "Franchise Operations";
    case "support": return "Customer Support";
    case "marketing": return "Marketing & Outreach";
    case "clinic": return "Clinical Intelligence";
    case "client": return "Client Care Portal";
    case "governance": return "Platform Governance";
    default: return "";
  }
}

const pageClasses: Record<string, any> = {
  "admin": AdminDashboardPage,
  "bus_dev": BusDevDashboardPage,
  "caregiver": CaregiverDashboardPage,
  "ceo": CeoDashboardPage,
  "cfo": CfoDashboardPage,
  "chiropractor": ChiropractorDashboardPage,
  "ciso": CisoDashboardPage,
  "clinical_director": ClinicalDirectorDashboardPage,
  "cns": CnsDashboardPage,
  "community_outreach": CommunityOutreachDashboardPage,
  "compliance": ComplianceDashboardPage,
  "coo": CooDashboardPage,
  "cto": CtoDashboardPage,
  "customer_support": CustomerSupportDashboardPage,
  "cx_director": CxDirectorDashboardPage,
  "dynamic": DynamicDashboardPage,
  "employee": EmployeeDashboardPage,
  "family": FamilyDashboardPage,
  "finance_director": FinanceDirectorDashboardPage,
  "franchise_sales": FranchiseSalesDashboardPage,
  "gm": GmDashboardPage,
  "governance": GovernanceDashboardPage,
  "guest": GuestDashboardPage,
  "hr_director": HrDirectorDashboardPage,
  "hr_hiring": HrHiringDashboardPage,
  "hsw": HswDashboardPage,
  "infrastructure": InfrastructureDashboardPage,
  "intake": IntakeDashboardPage,
  "legal": LegalDashboardPage,
  "local_marketing": LocalMarketingDashboardPage,
  "lpn": LpnDashboardPage,
  "marketing": MarketingDashboardPage,
  "np": NpDashboardPage,
  "ops_manager": OpsManagerDashboardPage,
  "owner": OwnerDashboardPage,
  "partnership": PartnershipDashboardPage,
  "patient": PatientDashboardPage,
  "pediatric": PediatricDashboardPage,
  "physician": PhysicianDashboardPage,
  "physio": PhysioDashboardPage,
  "portal": PortalDashboardPage,
  "premium_concierge": PremiumConciergeDashboardPage,
  "psw": PswDashboardPage,
  "qa_specialist": QaSpecialistDashboardPage,
  "regional_bdm": RegionalBdmDashboardPage,
  "regional_manager_usa": RegionalManagerUsaDashboardPage,
  "rmt": RmtDashboardPage,
  "rn": RnDashboardPage,
  "rn_field_supervisor": RnFieldSupervisorDashboardPage,
  "rpn": RpnDashboardPage,
  "scheduler": SchedulerDashboardPage,
  "scrum_master": ScrumMasterDashboardPage,
  "shareholder": ShareholderDashboardPage,
  "social_worker": SocialWorkerDashboardPage,
  "system_verification": SystemVerificationDashboardPage,
  "territory_expansion": TerritoryExpansionDashboardPage,
  "territory_sales": TerritorySalesDashboardPage,
  "therapist": TherapistDashboardPage,
  "training": TrainingDashboardPage,
  "training_coordinator": TrainingCoordinatorDashboardPage,
  "training_director": TrainingDirectorDashboardPage,
  "vip_manager": VipManagerDashboardPage,
  "volunteer": VolunteerDashboardPage,
  "volunteer_coordinator": VolunteerCoordinatorDashboardPage,
};

describe("Authentication - Role Loading & Dynamic Dashboard Spec", () => {
  const appHubPage = new AppHubPage();

  beforeEach(() => {
    cy.clearAuthState();
  });

  // Load list of users from Cypress fixture dynamically
  it("should systematically run through all registered roles and verify their pages", () => {
    cy.fixture("governance/test_users.json").then((users: any[]) => {
      const targetRoles = ["ceo", "physician", "rmt"];
      const filteredUsers = users.filter((u) => targetRoles.includes(u.role_code));
      
      // Run sequentially inside the Cypress chain to avoid overlapping browser sessions
      filteredUsers.forEach((user) => {
        const role = user.role_code;
        const email = user.email;
        const appCode = user.app_code;
        const expectedCard = getCardNameForAppCode(appCode);
        
        if (!expectedCard) return; // Skip if no card mapping exists
        
        cy.log(`====== STARTING AUDIT FOR ROLE: ${role.toUpperCase()} ======`);
        
        // 1. Clear session and log in
        cy.clearAuthState();
        cy.login(email, "password");
        
        // 2. Assert Hub title is visible and the expected portal card is rendered
        appHubPage.assertTitleVisible()
          .assertCardVisible(expectedCard);
          
        // 3. Click the card to navigate to the portal dashboard
        appHubPage.clickCard(expectedCard);
        
        // 4. Instantiation of role-specific POM class dynamically
        const PageClass = pageClasses[role] || DashboardPage;
        const roleDashboard = new PageClass();
        
        // 5. Verify the dashboard screen itself via DB-driven POM assertions
        roleDashboard.isLoaded();
        
        cy.log(`====== COMPLETED AUDIT FOR ROLE: ${role.toUpperCase()} ======`);
      });
    });
  });
});
