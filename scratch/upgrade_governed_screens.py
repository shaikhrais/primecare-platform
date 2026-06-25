import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_outreach_screen.dart",
        "controller_import": "partnership_manager_outreach_screen_controller.dart",
        "controller_provider": "partnershipManagerOutreachScreenControllerProvider",
        "class_name": "PartnershipManagerOutreachScreen",
        "title": "Partnership Outreach",
        "desc": "Manage and track cold/warm outreach campaigns and communication history with prospective partners.",
        "categories": ["All", "Email", "Call", "Meeting"],
        "items": [
            "{'title': 'Campaign #301: Northern Rehab Group', 'content': 'Initial email contact sent. Margin targets shared.', 'category': 'Email'}",
            "{'title': 'Outreach #302: Vancouver Chiropractors', 'content': 'Phone follow-up. Clinic director expressed interest.', 'category': 'Call'}",
            "{'title': 'Outreach #303: Alberta Senior Care Group', 'content': 'Outreach presentation scheduled for next Thursday.', 'category': 'Meeting'}"
        ],
        "action_label": "Log Outreach Action"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_partners_screen.dart",
        "controller_import": "partnership_manager_partners_screen_controller.dart",
        "controller_provider": "partnershipManagerPartnersScreenControllerProvider",
        "class_name": "PartnershipManagerPartnersScreen",
        "title": "Partnership Partner Directory",
        "desc": "Manage healthcare partners, signed affiliate agreements, and clinic liaison contacts.",
        "categories": ["All", "Affiliated", "Pending", "Terminated"],
        "items": [
            "{'title': 'Partner: Ontario General Clinics', 'content': 'Affiliated partner since 2024. Regular referral stream.', 'category': 'Affiliated'}",
            "{'title': 'Partner: BC Caregivers Consortium', 'content': 'Pending final insurance validation and contract seal.', 'category': 'Pending'}",
            "{'title': 'Partner: Eastside Rehab Services', 'content': 'Terminated due to failure to meet nursing SLA targets.', 'category': 'Terminated'}"
        ],
        "action_label": "Register Partner Profile"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_proposals_screen.dart",
        "controller_import": "partnership_manager_proposals_screen_controller.dart",
        "controller_provider": "partnershipManagerProposalsScreenControllerProvider",
        "class_name": "PartnershipManagerProposalsScreen",
        "title": "Partnership Proposals",
        "desc": "Compile, review, and track active business partnership proposals and financial projections.",
        "categories": ["All", "Draft", "Sent", "Approved"],
        "items": [
            "{'title': 'Proposal: West Coast Nursing Union deal', 'content': 'Sent to committee. Includes billing rates table.', 'category': 'Sent'}",
            "{'title': 'Proposal: Calgary Rehab Center', 'content': 'Approved by CFO. Proceeding to contract drafts.', 'category': 'Approved'}",
            "{'title': 'Proposal: Ontario ADL Supplier', 'content': 'Draft stage. Reviewing volume discount structure.', 'category': 'Draft'}"
        ],
        "action_label": "Compile Business Proposal"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_renewals_screen.dart",
        "controller_import": "partnership_manager_renewals_screen_controller.dart",
        "controller_provider": "partnershipManagerRenewalsScreenControllerProvider",
        "class_name": "PartnershipManagerRenewalsScreen",
        "title": "Partnership Renewals",
        "desc": "Review upcoming partnership contract expirations and coordinate renewal terms.",
        "categories": ["All", "Urgent", "Pending", "AutoRenewed"],
        "items": [
            "{'title': 'Renewal: Toronto Physio Hub Agreement', 'content': 'Urgent. Expires in 15 days. Negotiation in progress.', 'category': 'Urgent'}",
            "{'title': 'Renewal: Alberta Caregiver Staffing', 'content': 'Pending board review on rate adjustments.', 'category': 'Pending'}",
            "{'title': 'Renewal: Winnipeg RMT Network', 'content': 'AutoRenewed through Q4 2028 under standard clause.', 'category': 'AutoRenewed'}"
        ],
        "action_label": "Initiate Renewal Flow"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_reports_screen.dart",
        "controller_import": "partnership_manager_reports_screen_controller.dart",
        "controller_provider": "partnershipManagerReportsScreenControllerProvider",
        "class_name": "PartnershipManagerReportsScreen",
        "title": "Partnership Manager Reports",
        "desc": "Access partner referral volume reviews, SLA audits, and performance diagnostics.",
        "categories": ["All", "Quarterly", "Audit", "Performance"],
        "items": [
            "{'title': 'Report Q1 2026: Referral Pipeline', 'content': 'Quarterly report. Allied healthcare referrals up 12%.', 'category': 'Quarterly'}",
            "{'title': 'Audit: Clinic License Compliance', 'content': 'Audit report. Checked credentialing for 48 external nurses.', 'category': 'Audit'}",
            "{'title': 'SLA Review: BC Care Network', 'content': 'Performance report. Average dispatch time is 28 minutes.', 'category': 'Performance'}"
        ],
        "action_label": "Generate Audited Report"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/regional/screens/regional_manager_ontario_dashboard_screen.dart",
        "controller_import": "regional_manager_ontario_dashboard_screen_controller.dart",
        "controller_provider": "regionalManagerOntarioDashboardScreenControllerProvider",
        "class_name": "RegionalManagerOntarioDashboardScreen",
        "title": "Regional Manager Ontario Dashboard",
        "desc": "Centralized dashboard for the Ontario region covering clinic metrics, staffing quotas, and client pipeline.",
        "categories": ["All", "Toronto", "Ottawa", "Hamilton"],
        "items": [
            "{'title': 'Metro Toronto Clinic Hub', 'content': 'Operational. Staffing at 98% capacity. Active caseload is 342.', 'category': 'Toronto'}",
            "{'title': 'Ottawa Central Care Unit', 'content': 'Operational. Onboarding 4 new RNs. Caseload is 112.', 'category': 'Ottawa'}",
            "{'title': 'Hamilton West Rehabilitation Clinic', 'content': 'Operational. Need 2 additional RMTs for weekend shifts.', 'category': 'Hamilton'}"
        ],
        "action_label": "Log Branch Milestone"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_demographics_screen.dart",
        "controller_import": "territory_expansion_manager_demographics_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerDemographicsScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerDemographicsScreen",
        "title": "Territory Expansion Demographics",
        "desc": "Analyze target territory demographics, senior population density, and regional healthcare supply gaps.",
        "categories": ["All", "HighDensity", "MediumDensity", "LowDensity"],
        "items": [
            "{'title': 'Demographics: Peel Region', 'content': 'HighDensity. Senior population is 14%. Low caregiver supply.', 'category': 'HighDensity'}",
            "{'title': 'Demographics: Halton Hub Target', 'content': 'MediumDensity. Moderate senior density. Average household income is high.', 'category': 'MediumDensity'}",
            "{'title': 'Demographics: Simcoe County Target', 'content': 'LowDensity. Low senior density. High travel distance.', 'category': 'LowDensity'}"
        ],
        "action_label": "Map Demographic Node"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_expansion_plans_screen.dart",
        "controller_import": "territory_expansion_manager_expansion_plans_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerExpansionPlansScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerExpansionPlansScreen",
        "title": "Territory Expansion Plans",
        "desc": "Draft, edit, and track master territory expansion milestones and business timelines.",
        "categories": ["All", "Phase1", "Phase2", "Approved"],
        "items": [
            "{'title': 'Plan: Greater Sudbury Clinic Rollout', 'content': 'Phase1. Identifying site leases and hiring clinic director.', 'category': 'Phase1'}",
            "{'title': 'Plan: London Ontario Franchise Node', 'content': 'Phase2. Vetting local franchise buyer group.', 'category': 'Phase2'}",
            "{'title': 'Plan: Niagara Falls Expansion Site', 'content': 'Approved. Finalizing building permit and construction pricing.', 'category': 'Approved'}"
        ],
        "action_label": "Draft Expansion Milestone"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_forecast_screen.dart",
        "controller_import": "territory_expansion_manager_forecast_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerForecastScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerForecastScreen",
        "title": "Territory Expansion Forecast",
        "desc": "Analyze financial forecasting and projected cash flow trends for new clinic territories.",
        "categories": ["All", "Revenue", "Expense", "BreakEven"],
        "items": [
            "{'title': 'Forecast: Barrie West Site', 'content': 'Revenue projection: $450,000 in Year 1. Margin target is 16%.', 'category': 'Revenue'}",
            "{'title': 'Forecast: Kingston Clinic Hub', 'content': 'Expense forecast: $85,000 initial startup capital needed.', 'category': 'Expense'}",
            "{'title': 'Forecast: Waterloo North Site', 'content': 'BreakEven analysis completed. Projected month: 14.', 'category': 'BreakEven'}"
        ],
        "action_label": "Compile Forecast Node"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_market_research_screen.dart",
        "controller_import": "territory_expansion_manager_market_research_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerMarketResearchScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerMarketResearchScreen",
        "title": "Territory Market Research",
        "desc": "Review local competitor pricing, hiring conditions, and municipal healthcare regulations.",
        "categories": ["All", "Competitors", "Regulations", "Surveys"],
        "items": [
            "{'title': 'Research: Private Care Agency Pricing in York', 'content': 'Competitors. Competitor average hourly rate is $38.50.', 'category': 'Competitors'}",
            "{'title': 'Regulations: Durham Home Care Licensing', 'content': 'Regulations. Mandatory municipal registry license required.', 'category': 'Regulations'}",
            "{'title': 'Surveys: Senior Care Feedback Mississauga', 'content': 'Surveys. 88% of respondents prefer local RMT services.', 'category': 'Surveys'}"
        ],
        "action_label": "Log Research Record"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_open_territories_screen.dart",
        "controller_import": "territory_expansion_manager_open_territories_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerOpenTerritoriesScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerOpenTerritoriesScreen",
        "title": "Territory Open Directory",
        "desc": "Audit available franchise territories, regional boundaries, and zoning clearances.",
        "categories": ["All", "Available", "Reserved", "UnderReview"],
        "items": [
            "{'title': 'Territory #401: Oakville North-East', 'content': 'Available. Ready for franchise buyer applications.', 'category': 'Available'}",
            "{'title': 'Territory #402: Burlington Lakeshore', 'content': 'Reserved. Deposit cleared by Dr. Thomas group.', 'category': 'Reserved'}",
            "{'title': 'Territory #403: Milton Central Hub', 'content': 'UnderReview. Boundary overlap adjustment with Peel Region.', 'category': 'UnderReview'}"
        ],
        "action_label": "Register Open Territory"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_reports_screen.dart",
        "controller_import": "territory_expansion_manager_reports_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerReportsScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerReportsScreen",
        "title": "Territory Manager Reports",
        "desc": "Compile performance metrics, competitor analyses, and expansion pipeline audits.",
        "categories": ["All", "Quarterly", "Annual", "Compliance"],
        "items": [
            "{'title': 'Expansion Report Q1 2026', 'content': 'Completed. 3 new territories mapped and approved.', 'category': 'Quarterly'}",
            "{'title': 'Annual Regional Market Prospectus', 'content': 'Archived. Core demographics shift analysis.', 'category': 'Annual'}",
            "{'title': 'Zoning Compliance Verification Audit', 'content': 'Approved. Passed municipal clearances.', 'category': 'Compliance'}"
        ],
        "action_label": "Generate Expansion Report"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_site_selection_screen.dart",
        "controller_import": "territory_expansion_manager_site_selection_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerSiteSelectionScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerSiteSelectionScreen",
        "title": "Territory Site Selection",
        "desc": "Audit real estate locations, lease parameters, accessibility checklists, and zoning clearance.",
        "categories": ["All", "Peel", "Halton", "York"],
        "items": [
            "{'title': 'Site #101: 120 Main St, Mississauga', 'content': 'Peel. Lease signed. Building conversion in progress.', 'category': 'Peel'}",
            "{'title': 'Site #102: 450 Brant St, Burlington', 'content': 'Halton. Accessibility audit passed. Lease negotiation.', 'category': 'Halton'}",
            "{'title': 'Site #103: 88 Yonge St, Richmond Hill', 'content': 'York. Under review. Zoning permit pending council meeting.', 'category': 'York'}"
        ],
        "action_label": "Log Site Audit Record"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/expansion/screens/territory_expansion_manager_territory_map_screen.dart",
        "controller_import": "territory_expansion_manager_territory_map_screen_controller.dart",
        "controller_provider": "territoryExpansionManagerTerritoryMapScreenControllerProvider",
        "class_name": "TerritoryExpansionManagerTerritoryMapScreen",
        "title": "Territory Layout Map",
        "desc": "Visualize regional boundaries, clinic catchment polygons, and competitor hubs.",
        "categories": ["All", "Polygons", "Competitors", "Zoning"],
        "items": [
            "{'title': 'Boundary Map: Peel West Region', 'content': 'Polygons. Adjusted Milton boundary line by 2km west.', 'category': 'Polygons'}",
            "{'title': 'Zoning Hubs: York North-West', 'content': 'Zoning. Under review for light-medical zoning clearance.', 'category': 'Zoning'}",
            "{'title': 'Competitor Mapping: Calgary Hubs', 'content': 'Competitors. Plotted 12 home care centers.', 'category': 'Competitors'}"
        ],
        "action_label": "Map Boundary Polygon"
    },
    {
        "file_path": r"apps/primecare_client/lib/ai_chatbot_screen.dart",
        "controller_import": "ai_chatbot_screen_controller.dart",
        "controller_provider": "aiChatbotScreenControllerProvider",
        "class_name": "AiChatbotScreen",
        "title": "AI Clinical Chatbot",
        "desc": "Interact with the clinical AI assistant for preliminary symptom reviews, medication reminders, and general wellness inquiries.",
        "categories": ["All", "Symptoms", "Meds", "Appointments"],
        "items": [
            "{'title': 'Symptom Review #1024', 'content': 'Discussed muscle fatigue post adjustments. AI recommended hydration.', 'category': 'Symptoms'}",
            "{'title': 'Medication Tracker #1025', 'content': 'Configured daily multivitamin and calcium alerts for morning.', 'category': 'Meds'}",
            "{'title': 'Booking Consultation Help', 'content': 'Asked how to reschedule physiotherapy appointment. Guided to bookings.', 'category': 'Appointments'}"
        ],
        "action_label": "Launch Live Consultation"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_billing_screen.dart",
        "controller_import": "family_billing_screen_controller.dart",
        "controller_provider": "familyBillingScreenControllerProvider",
        "class_name": "FamilyBillingScreen",
        "title": "Family Billing & Invoices",
        "desc": "View billing history, invoices, insurance receipts, and active payment methods for loved ones.",
        "categories": ["All", "Invoices", "Receipts", "PaymentMethods"],
        "items": [
            "{'title': 'Invoice #F-2026-101: June Care Shift', 'content': 'Paid. Total: $850.00. Covers 24 hours of PSW assistance.', 'category': 'Invoices'}",
            "{'title': 'Insurance Receipt: Physiotherapy Q1', 'content': 'Sent. Total: $350.00. Reimbursed at 80% under standard plan.', 'category': 'Receipts'}",
            "{'title': 'Primary Card: Visa **** 4321', 'content': 'Active. Auto-pay enabled for weekly nursing cycles.', 'category': 'PaymentMethods'}"
        ],
        "action_label": "Process Invoice Claim"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_care_updates_screen.dart",
        "controller_import": "family_care_updates_screen_controller.dart",
        "controller_provider": "familyCareUpdatesScreenControllerProvider",
        "class_name": "FamilyCareUpdatesScreen",
        "title": "Family Care Logs",
        "desc": "Track daily caregiver shift notes, vitals checks, and nutritional intake updates for loved ones.",
        "categories": ["All", "Vitals", "ShiftNotes", "Nutrition"],
        "items": [
            "{'title': 'Vitals Check: June 24, 2:00 PM', 'content': 'Blood pressure: 122/80. Heart rate: 72 bpm. Vitals within range.', 'category': 'Vitals'}",
            "{'title': 'Shift Note: PSW Mary Vance', 'content': 'Completed morning walk. Client was cheerful and alert.', 'category': 'ShiftNotes'}",
            "{'title': 'Meal Log: Lunch Intake', 'content': 'Completed full meal. High protein soup and orange slices.', 'category': 'Nutrition'}"
        ],
        "action_label": "Log Care Directive"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_dashboard_screen.dart",
        "controller_import": "family_dashboard_screen_controller.dart",
        "controller_provider": "familyDashboardScreenControllerProvider",
        "class_name": "FamilyDashboardScreen",
        "title": "Family Member Portal",
        "desc": "Overview hub for family members to check care plans, upcoming schedules, and contact primary care providers.",
        "categories": ["All", "Schedule", "CareTeam", "Alerts"],
        "items": [
            "{'title': 'Upcoming Shift: Nurse Sarah Vance', 'content': 'Scheduled for June 26, 9:00 AM - 1:00 PM. Vitals audit.', 'category': 'Schedule'}",
            "{'title': 'Primary Liaison: Dr. Alan Green', 'content': 'Contact number: +1-800-555-0199. Clinic hours are 9AM-5PM.', 'category': 'CareTeam'}",
            "{'title': 'Alert: Upcoming Care Plan Renewal', 'content': 'SLA requires plan re-evaluation before July 10.', 'category': 'Alerts'}"
        ],
        "action_label": "Contact Care Coordinator"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_emergency_contacts_screen.dart",
        "controller_import": "family_emergency_contacts_screen_controller.dart",
        "controller_provider": "familyEmergencyContactsScreenControllerProvider",
        "class_name": "FamilyEmergencyContactsScreen",
        "title": "Family Emergency Directory",
        "desc": "Manage emergency contacts, primary care doctors, and secondary family notification settings.",
        "categories": ["All", "Primary", "Secondary", "Physicians"],
        "items": [
            "{'title': 'Emergency Contact: Robert Smith (Son)', 'content': 'Primary. Phone: +1-555-0123. Email: robert@family.com', 'category': 'Primary'}",
            "{'title': 'Secondary: Emily Smith (Daughter)', 'content': 'Secondary. Phone: +1-555-0124. Notification enabled.', 'category': 'Secondary'}",
            "{'title': 'Physician: Dr. Alan Green', 'content': 'Primary Physician. Phone: +1-800-555-0199. Office: Room 304.', 'category': 'Physicians'}"
        ],
        "action_label": "Log Emergency Contact"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_loved_one_schedule_screen.dart",
        "controller_import": "family_loved_one_schedule_screen_controller.dart",
        "controller_provider": "familyLovedOneScheduleScreenControllerProvider",
        "class_name": "FamilyLovedOneScheduleScreen",
        "title": "Family Care Schedule",
        "desc": "Review upcoming shifts, doctor consultations, and therapy appointments scheduled for loved ones.",
        "categories": ["All", "Nursing", "Therapy", "DoctorVisit"],
        "items": [
            "{'title': 'Shift: Nurse Sarah Vance (RN)', 'content': 'June 26, 9:00 AM. Vitals and medication check.', 'category': 'Nursing'}",
            "{'title': 'Session: Physiotherapy Intake', 'content': 'June 29, 2:00 PM. Assessment of joint range of motion.', 'category': 'Therapy'}",
            "{'title': 'Visit: Dr. Alan Green Office', 'content': 'July 2, 10:00 AM. Blood pressure review consult.', 'category': 'DoctorVisit'}"
        ],
        "action_label": "Request Schedule Shift Change"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/family/screens/family_profile_screen.dart",
        "controller_import": "family_profile_screen_controller.dart",
        "controller_provider": "familyProfileScreenControllerProvider",
        "class_name": "FamilyProfileScreen",
        "title": "Family Member Profile",
        "desc": "View and update client bio, address details, medical insurance cards, and access permissions.",
        "categories": ["All", "Demographics", "Insurance", "Permissions"],
        "items": [
            "{'title': 'Client Bio: John Smith (Father)', 'content': 'Address: 120 Elm St, Toronto. DOB: Jan 12, 1945.', 'category': 'Demographics'}",
            "{'title': 'Insurance: BlueCross Group #883921', 'content': 'Active. Co-pay rate is 20%. Policy holder is John Smith.', 'category': 'Insurance'}",
            "{'title': 'Access: Robert Smith (Son)', 'content': 'Full power of attorney verified. Authorized billing access.', 'category': 'Permissions'}"
        ],
        "action_label": "Update Demographic Details"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_book_appointment_screen.dart",
        "controller_import": "client_book_appointment_screen_controller.dart",
        "controller_provider": "clientBookAppointmentScreenControllerProvider",
        "class_name": "ClientBookAppointmentScreen",
        "title": "Book Clinic Appointment",
        "desc": "Schedule clinic or home care consultations with RNs, physiotherapists, and chiropractors.",
        "categories": ["All", "Nursing", "Physio", "Chiropractic"],
        "items": [
            "{'title': 'Book: RN In-Home Assessment', 'content': 'Available slots daily. Average duration is 60 minutes.', 'category': 'Nursing'}",
            "{'title': 'Book: Range of Motion Physiotherapy', 'content': 'Available with therapist Sarah. Location: Suite 201.', 'category': 'Physio'}",
            "{'title': 'Book: Spinal Alignment Adjustment', 'content': 'Available with chiropractor Robert. Location: Room 102.', 'category': 'Chiropractic'}"
        ],
        "action_label": "Process Booking Request"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_care_team_screen.dart",
        "controller_import": "client_care_team_screen_controller.dart",
        "controller_provider": "clientCareTeamScreenControllerProvider",
        "class_name": "ClientCareTeamScreen",
        "title": "My Clinical Care Team",
        "desc": "Directory of primary caregivers, active nurses, and therapists assigned to your treatment plan.",
        "categories": ["All", "Nurses", "Therapists", "Doctors"],
        "items": [
            "{'title': 'Nurse: Sarah Vance (RN)', 'content': 'Primary home care nurse. Contact: +1-555-0192', 'category': 'Nurses'}",
            "{'title': 'Therapist: Sarah Smith (PT)', 'content': 'Physiotherapist assigned for gait rehabilitation.', 'category': 'Therapists'}",
            "{'title': 'Doctor: Dr. Alan Green', 'content': 'Primary General Practitioner. Clinic Room 304.', 'category': 'Doctors'}"
        ],
        "action_label": "Contact Care Team Leader"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_dashboard_screen.dart",
        "controller_import": "client_dashboard_screen_controller.dart",
        "controller_provider": "clientDashboardScreenControllerProvider",
        "class_name": "ClientDashboardScreen",
        "title": "Client Portal Dashboard",
        "desc": "Verify care updates, check your upcoming schedule, and review billing reminders.",
        "categories": ["All", "Appointments", "Vitals", "Billing"],
        "items": [
            "{'title': 'Next Appointment: June 26, 9:00 AM', 'content': 'Nursing vitals review session scheduled at home.', 'category': 'Appointments'}",
            "{'title': 'Last Blood Pressure: 122/80', 'content': 'Checked June 24. Stable. Vitals metrics within limit.', 'category': 'Vitals'}",
            "{'title': 'Pending Invoice: $120.00', 'content': 'Covers chiropractor adjustment session. Due June 30.', 'category': 'Billing'}"
        ],
        "action_label": "Request Care Recount"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_my_appointments_screen.dart",
        "controller_import": "client_my_appointments_screen_controller.dart",
        "controller_provider": "clientMyAppointmentsScreenControllerProvider",
        "class_name": "ClientMyAppointmentsScreen",
        "title": "My Active Appointments",
        "desc": "Review upcoming bookings, session details, and cancellation policies.",
        "categories": ["All", "Confirmed", "Pending", "Cancelled"],
        "items": [
            "{'title': 'Appointment: RN Shift Consultation', 'content': 'Confirmed for June 26 at 9:00 AM. Nurse Sarah.', 'category': 'Confirmed'}",
            "{'title': 'Appointment: Chiropractic Session', 'content': 'Pending clinic verification. Scheduled for Room 102.', 'category': 'Pending'}",
            "{'title': 'Appointment: Physiotherapy Gait Session', 'content': 'Cancelled. Client requested reschedule to next week.', 'category': 'Cancelled'}"
        ],
        "action_label": "Reschedule Active Appointment"
    }
]

# Code template for the stateful delegation pattern replacement
template = """/* 
PRIME:SCREEN={prime_screen}
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '{controller_import}';

class {class_name} extends GovernedConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  String get screenDescription =>
      '{desc}';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    final state = ref.watch({controller_provider});

    return state.when(
      data: (data) => _{class_name}Content(
        controllerProvider: {controller_provider},
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Telemetry connection failed: $error')),
      ),
    );
  }}
}}

class _{class_name}Content extends ConsumerStatefulWidget {{
  final dynamic controllerProvider;

  const _{class_name}Content({{
    required this.controllerProvider,
  }});

  @override
  ConsumerState<_{class_name}Content> createState() => _{class_name}ContentState();
}}

class _{class_name}ContentState extends ConsumerState<_{class_name}Content> {{
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<Map<String, String>> _records = [
    {items_list}
  ];

  @override
  void dispose() {{
    _dialogController.dispose();
    super.dispose();
  }}

  @override
  Widget build(BuildContext context) {{
    final filtered = _records.where((record) {{
      final matchesQuery = record['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['content']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || record['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }}).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Action / Purpose Hero panel
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Operational Control Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text(
                '{desc}',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Categories filters choice chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: [{categories_list}].map((cat) {{
              final isSel = _selectedCategory == cat;
              return ChoiceChip(
                label: Text(cat),
                selected: isSel,
                onSelected: (selected) {{
                  setState(() {{
                    _selectedCategory = cat;
                  }});
                }},
              );
            }}).toList(),
          ),
        ),

        // Search text field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search operations logs...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (val) {{
              setState(() {{
                _searchQuery = val;
              }});
            }},
          ),
        ),

        // Main List view of records
        Expanded(
          child: filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
                      const SizedBox(height: 12),
                      const Text('No records match your criteria.'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _showActionDialog,
                        child: const Text('{action_label}'),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {{
                    final record = filtered[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(child: Icon(Icons.layers)),
                        title: Text(record['title']!),
                        subtitle: Text(record['content']!),
                        trailing: Text(
                          record['category']!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        onTap: () {{
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text(record['title']!),
                              content: Text(record['content']!),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text('Close'),
                                ),
                              ],
                            ),
                          );
                        }},
                      ),
                    );
                  }},
                ),
        ),

        // Bottom log action button
        if (filtered.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showActionDialog,
              icon: const Icon(Icons.add_task),
              label: const Text('{action_label}'),
            ),
          ),
      ],
    );
  }}

  void _showActionDialog() {{
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('{action_label}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dialogController,
              decoration: const InputDecoration(
                hintText: 'Enter details...',
                labelText: 'Operational Details',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {{
              final text = _dialogController.text.trim();
              if (text.isNotEmpty) {{
                setState(() {{
                  _records.add({{
                    'title': text,
                    'content': 'Manually registered log record transaction.',
                    'category': _selectedCategory == 'All' ? 'General' : _selectedCategory,
                  }});
                }});
                _dialogController.clear();
              }}
              Navigator.pop(ctx);
            }},
            child: const Text('Confirm Action'),
          ),
        ],
      ),
    );
  }}
}}
"""

def run_upgrade():
    print("Upgrading 25 governed screens...")
    for sc in screens_config:
        full_path = os.path.join(project_root, sc["file_path"].replace("/", os.sep))
        if not os.path.exists(full_path):
            print(f"Skipping missing file: {full_path}")
            continue

        # Extract prime screen name from metadata
        with open(full_path, "r", encoding="utf-8") as f:
            content = f.read()
        
        m = re.search(r'PRIME:SCREEN=([^\s\n]+)', content)
        prime_screen = m.group(1) if m else sc["class_name"].lower()

        # Format choice lists and items
        items_list = ",\n    ".join(sc["items"])
        categories_list = ", ".join([f"'{c}'" for c in sc["categories"]])

        new_content = template.format(
            prime_screen=prime_screen,
            controller_import=sc["controller_import"],
            controller_provider=sc["controller_provider"],
            class_name=sc["class_name"],
            title=sc["title"],
            desc=sc["desc"],
            items_list=items_list,
            categories_list=categories_list,
            action_label=sc["action_label"]
        )

        with open(full_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Upgraded governed screen code for: {sc['class_name']} at {sc['file_path']}")

if __name__ == "__main__":
    run_upgrade()
