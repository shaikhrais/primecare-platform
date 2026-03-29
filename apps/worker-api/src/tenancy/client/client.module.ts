import { OpenAPIHono } from '@hono/zod-openapi';
import { Bindings, Variables } from '../../bindings';
import { requireAuth } from '../../_shared/middleware/auth';
import homeRoutes from './home/home.routes';
import bookingRoutes from './bookings/bookings.routes';
import carePlanRoutes from './carePlan/carePlan.routes';
import serviceRoutes from './services/services.routes';
import relationshipRoutes from './relationship/relationship.routes';
import engagementRoutes from './client_engagement.routes';
import familyRoutes from './family/family.routes';
import billingRoutes from './billing/billing.routes';
import feedbackRoutes from './feedback/feedback.routes';
import portalRoutes from './portal/portal.routes';
import paymentRoutes from './payments/payments.routes';
import inboxRoutes from './inbox/messages.routes';
import careTeamRoutes from './careTeam/careTeam.routes';
import pulseRoutes from './pulse/pulse.routes';

import clinicsRoutes from './clinics/clinics.routes';
import patientsRoutes from './patients/patients.routes';
import financialsRoutes from './financials/financials.routes';

import familyAppointmentsList from './family/appointments.routes';
import familyCarePlansList from './family/carePlans.routes';
import familyMessagesList from './family/messages.routes';

import intakeQueueList from './intake/queue.routes';
import intakeReferralsList from './intake/referrals.routes';
import intakeUpcomingList from './intake/upcoming.routes';

import hrOpeningsList from './hr/openings.routes';
import hrCandidatesList from './hr/candidates.routes';
import hrInterviewsList from './hr/interviews.routes';

import billingInvoicesList from './billing/invoices.routes';
import billingClaimsList from './billing/claims.routes';
import billingReportsList from './billing/reports.routes';

import opsFacilitiesList from './ops/facilities.routes';
import opsStaffList from './ops/staff.routes';
import opsIssuesList from './ops/issues.routes';

import qaIncidentsList from './qa/incidents.routes';
import qaAuditsList from './qa/audits.routes';
import qaSatisfactionList from './qa/satisfaction.routes';

import bdDealsList from './bd/deals.routes';
import bdAccountsList from './bd/accounts.routes';
import bdPerformanceList from './bd/performance.routes';

import marketingCampaignsList from './marketing/campaigns.routes';
import marketingAnalyticsList from './marketing/analytics.routes';
import marketingContentList from './marketing/content.routes';

import clinicalAdmissionsList from './clinical/admissions.routes';
import clinicalScheduleList from './clinical/schedule.routes';
import clinicalFranchiseList from './clinical/franchise.routes';

import supportTicketsList from './support/tickets.routes';
import supportSatisfactionList from './support/satisfaction.routes';
import supportSystemList from './support/system.routes';

import trainingProgramsList from './training/programs.routes';
import trainingFacilitatorsList from './training/facilitators.routes';
import trainingComplianceList from './training/compliance.routes';

import franchiseRevenueList from './franchise/revenue.routes';
import franchiseClinicsList from './franchise/clinics.routes';
import franchiseAppointmentsList from './franchise/appointments.routes';

import outreachEventsList from './outreach/events.routes';
import outreachParticipantsList from './outreach/participants.routes';
import outreachBudgetsList from './outreach/budgets.routes';

import franchiseNetworkList from './franchise-man/network.routes';
import franchiseFinancesList from './franchise-man/finances.routes';
import franchiseActivitiesList from './franchise-man/activities.routes';

import localAnalyticsList from './local-marketing/analytics.routes';
import localCampaignsList from './local-marketing/campaigns.routes';
import localContentList from './local-marketing/content.routes';

import supportAgentsList from './support-desk/agents.routes';
import supportVolumeList from './support-desk/volume.routes';
import supportFeedbackList from './support-desk/feedback.routes';

import clientTrendsList from './client-side/trends.routes';
import clientClinicsList from './client-side/clinics.routes';
import clientDemographicsList from './client-side/demographics.routes';

import healthnetRevenueList from './healthnet/revenue.routes';
import healthnetEfficiencyList from './healthnet/efficiency.routes';
import healthnetNetworkList from './healthnet/network.routes';

import schedulerTrendsList from './scheduler/trends.routes';
import schedulerRosterList from './scheduler/roster.routes';
import schedulerFacilityList from './scheduler/facility.routes';

const client = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Client module-level middleware
client.use('*', async (c, next) => {
    const middleware = requireAuth(c.env.JWT_SECRET);
    return await middleware(c, next);
});

// Routes
client.route('/home', homeRoutes); // stats at /home/stats, profile at /home/profile
client.route('/bookings', bookingRoutes);
client.route('/care-plan', carePlanRoutes);
client.route('/', serviceRoutes);
client.route('/', relationshipRoutes); // support/feedback at /support/feedback
client.route('/engagement', engagementRoutes); // feed at /engagement/feed
client.route('/family', familyRoutes);
client.route('/billing', billingRoutes);
client.route('/feedback', feedbackRoutes);
client.route('/payments', paymentRoutes);
client.route('/inbox', inboxRoutes);
client.route('/care-team', careTeamRoutes);
client.route('/pulse', pulseRoutes);

client.route('/clinics', clinicsRoutes); // Connected DB Route
client.route('/patients', patientsRoutes); // Linked API Payload
client.route('/financials', financialsRoutes); // Linked DB History Payload

// Family Portal Extensions (Phase 2)
client.route('/family-appointments', familyAppointmentsList);
client.route('/family-care-plans', familyCarePlansList);
client.route('/family-messages', familyMessagesList);

// Intake Coordinator Extensions (Phase 3)
client.route('/intake/queue', intakeQueueList);
client.route('/intake/referrals', intakeReferralsList);
client.route('/intake/upcoming', intakeUpcomingList);

// HR Extensions (Phase 4)
client.route('/hr/openings', hrOpeningsList);
client.route('/hr/candidates', hrCandidatesList);
client.route('/hr/interviews', hrInterviewsList);

// Billing Extensions (Phase 5)
client.route('/billing/invoices', billingInvoicesList);
client.route('/billing/claims', billingClaimsList);
client.route('/billing/reports', billingReportsList);

// Operations Extensions (Phase 6)
client.route('/ops/facilities', opsFacilitiesList);
client.route('/ops/staff', opsStaffList);
client.route('/ops/issues', opsIssuesList);

// QA Compliance Extensions (Phase 7)
client.route('/qa/incidents', qaIncidentsList);
client.route('/qa/audits', qaAuditsList);
client.route('/qa/satisfaction', qaSatisfactionList);

// Territory BD Extensions (Phase 8)
client.route('/bd/deals', bdDealsList);
client.route('/bd/accounts', bdAccountsList);
client.route('/bd/performance', bdPerformanceList);

// Marketing Growth Extensions (Phase 9)
client.route('/marketing/campaigns', marketingCampaignsList);
client.route('/marketing/analytics', marketingAnalyticsList);
client.route('/marketing/content', marketingContentList);

// Clinical Team Hub Extensions (Phase 10 Finale)
client.route('/clinical/admissions', clinicalAdmissionsList);
client.route('/clinical/schedule', clinicalScheduleList);
client.route('/clinical/franchise', clinicalFranchiseList);

// Support Team Extensions (Phase 11)
client.route('/support/tickets', supportTicketsList);
client.route('/support/satisfaction', supportSatisfactionList);
client.route('/support/system', supportSystemList);

// Training Coordinator Extensions (Phase 12)
client.route('/training/programs', trainingProgramsList);
client.route('/training/facilitators', trainingFacilitatorsList);
client.route('/training/compliance', trainingComplianceList);

// Franchise Owner Extensions (Phase 13)
client.route('/franchise/revenue', franchiseRevenueList);
client.route('/franchise/clinics', franchiseClinicsList);
client.route('/franchise/appointments', franchiseAppointmentsList);

// Community Outreach Extensions (Phase 14)
client.route('/outreach/events', outreachEventsList);
client.route('/outreach/participants', outreachParticipantsList);
client.route('/outreach/budgets', outreachBudgetsList);

// Franchise Management Extensions (Phase 15)
client.route('/franchise-man/network', franchiseNetworkList);
client.route('/franchise-man/finances', franchiseFinancesList);
client.route('/franchise-man/activities', franchiseActivitiesList);

// Local Marketing Hub (Phase 16)
client.route('/local-marketing/analytics', localAnalyticsList);
client.route('/local-marketing/campaigns', localCampaignsList);
client.route('/local-marketing/content', localContentList);

// Customer Support Desk Hub (Phase 17)
client.route('/support-desk/agents', supportAgentsList);
client.route('/support-desk/volume', supportVolumeList);
client.route('/support-desk/feedback', supportFeedbackList);

// Client Side Hub (Phase 18)
client.route('/client-side/trends', clientTrendsList);
client.route('/client-side/clinics', clientClinicsList);
client.route('/client-side/demographics', clientDemographicsList);

// Client HealthNet Hub (Phase 19)
client.route('/healthnet/revenue', healthnetRevenueList);
client.route('/healthnet/efficiency', healthnetEfficiencyList);
client.route('/healthnet/network', healthnetNetworkList);

// Scheduler Hub (Phase 20)
client.route('/scheduler/trends', schedulerTrendsList);
client.route('/scheduler/roster', schedulerRosterList);
client.route('/scheduler/facility', schedulerFacilityList);

client.route('/', portalRoutes);

export default client;
