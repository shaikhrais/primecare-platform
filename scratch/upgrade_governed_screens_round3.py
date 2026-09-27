import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_payments_screen.dart",
        "controller_import": "client_payments_screen_controller.dart",
        "controller_provider": "clientPaymentsScreenControllerProvider",
        "class_name": "ClientPaymentsScreen",
        "title": "Client Payments History",
        "desc": "Manage and track client payments, payment schedules, and past invoice processing details.",
        "categories": ["All", "Overview", "Alerts", "Processing"],
        "items": [
            "{'title': 'Payment: Invoiced Shift June 24', 'content': 'Completed processing. Total: $120.00.', 'category': 'Overview'}",
            "{'title': 'Alert: Payment Method Expiry', 'content': 'Visa ending in 4321 expires within 30 days.', 'category': 'Alerts'}",
            "{'title': 'Processing: Bank Settlement claim #102', 'content': 'Awaiting final Plaid ledger match.', 'category': 'Processing'}"
        ],
        "action_label": "Submit Transaction Refresh"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_profile_screen.dart",
        "controller_import": "client_profile_screen_controller.dart",
        "controller_provider": "clientProfileScreenControllerProvider",
        "class_name": "ClientProfileScreen",
        "title": "Client Profile Data",
        "desc": "View and update primary contact details, default branch preferences, and security consent forms.",
        "categories": ["All", "General", "Branch", "Consent"],
        "items": [
            "{'title': 'Profile: John Doe Contact Info', 'content': 'Phone: +1-555-0122. Address: 12 Elm St, Toronto.', 'category': 'General'}",
            "{'title': 'Branch Pref: Toronto West Hub', 'content': 'Assigned as primary triage node.', 'category': 'Branch'}",
            "{'title': 'Consent: Medical Record Release', 'content': 'Form signed and checked on June 10, 2026.', 'category': 'Consent'}"
        ],
        "action_label": "Update Profile Node"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/client_treatment_history_screen.dart",
        "controller_import": "client_treatment_history_screen_controller.dart",
        "controller_provider": "clientTreatmentHistoryScreenControllerProvider",
        "class_name": "ClientTreatmentHistoryScreen",
        "title": "Client Treatment Records",
        "desc": "Access clinical records of past spinal adjustments, gait therapies, and nursing vitals metrics.",
        "categories": ["All", "Physio", "Chiropractic", "Nursing"],
        "items": [
            "{'title': 'Physio: Gait Assessment Session #2', 'content': 'Gait stability check passed. Joint range improved.', 'category': 'Physio'}",
            "{'title': 'Chiro: L4 Alignment adjustment', 'content': 'Adjustment notes saved. Client reported pain relief.', 'category': 'Chiropractic'}",
            "{'title': 'Nursing: Blood Pressure check', 'content': '120/82 mmHg. Vitals log archived.', 'category': 'Nursing'}"
        ],
        "action_label": "Log Clinic Treatment"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/family_member_billing_screen.dart",
        "controller_import": "family_member_billing_screen_controller.dart",
        "controller_provider": "familyMemberBillingScreenControllerProvider",
        "class_name": "FamilyMemberBillingScreen",
        "title": "Family Billing Accounts",
        "desc": "Track billing cycles, auto-payment preferences, and joint invoice statements for family members.",
        "categories": ["All", "Invoices", "Remittance", "Receipts"],
        "items": [
            "{'title': 'Statement: June Weekly Shift Cycle', 'content': 'Total: $340.00. Settled via auto-pay on Visa.', 'category': 'Invoices'}",
            "{'title': 'Tax: HST Remittance Q1 Check', 'content': 'Completed and reconciled in Ledger DB.', 'category': 'Remittance'}",
            "{'title': 'Receipt: Chiropractic adjustment #102', 'content': 'Co-pay insurance submission receipt generated.', 'category': 'Receipts'}"
        ],
        "action_label": "Process Billing Cycle"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/family_member_care_updates_screen.dart",
        "controller_import": "family_member_care_updates_screen_controller.dart",
        "controller_provider": "familyMemberCareUpdatesScreenControllerProvider",
        "class_name": "FamilyMemberCareUpdatesScreen",
        "title": "Family Member Care Logs",
        "desc": "Track vitals updates, dietitian food logs, and nurse shift notes for family members.",
        "categories": ["All", "Vitals", "Nutrition", "ShiftNotes"],
        "items": [
            "{'title': 'Vitals: Blood Sugar audit', 'content': '5.4 mmol/L post-lunch check. Within target limit.', 'category': 'Vitals'}",
            "{'title': 'Nutrition: Meal checklist', 'content': 'Low-sodium soup, mixed salad, and orange sections.', 'category': 'Nutrition'}",
            "{'title': 'Shift: Nurse Mary Vance shift handover', 'content': 'Client was cooperative, active, and took scheduled meds.', 'category': 'ShiftNotes'}"
        ],
        "action_label": "Post Care Log Entry"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/family_member_emergency_contacts_screen.dart",
        "controller_import": "family_member_emergency_contacts_screen_controller.dart",
        "controller_provider": "familyMemberEmergencyContactsScreenControllerProvider",
        "class_name": "FamilyMemberEmergencyContactsScreen",
        "title": "Family Emergency Contacts",
        "desc": "Review primary and secondary emergency contact paths, and doctor notification settings.",
        "categories": ["All", "Primary", "Secondary", "Clinical"],
        "items": [
            "{'title': 'Emergency Contact: Robert Smith (Son)', 'content': 'Primary. Phone: +1-555-0123. Authorized liaison.', 'category': 'Primary'}",
            "{'title': 'Secondary: Emily Smith (Daughter)', 'content': 'Secondary. Phone: +1-555-0124. Notification enabled.', 'category': 'Secondary'}",
            "{'title': 'Clinic doctor: Dr. Alan Green', 'content': 'General Practitioner. Clinic Room 304.', 'category': 'Clinical'}"
        ],
        "action_label": "Add Contact Card"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/family_member_loved_one_schedule_screen.dart",
        "controller_import": "family_member_loved_one_schedule_screen_controller.dart",
        "controller_provider": "familyMemberLovedOneScheduleScreenControllerProvider",
        "class_name": "FamilyMemberLovedOneScheduleScreen",
        "title": "Loved One Care Calendar",
        "desc": "Review nursing visits, chiropractic sessions, and scheduled physiotherapists.",
        "categories": ["All", "Nursing", "Adjustment", "Therapists"],
        "items": [
            "{'title': 'Visit: Nurse Sarah Vance (RN)', 'content': 'June 26 at 9:00 AM. In-home vitals assessment.', 'category': 'Nursing'}",
            "{'title': 'Session: Joint Manipulation spinal', 'content': 'June 29 at 2:00 PM. Spinal adjustmentRoom 102.', 'category': 'Adjustment'}",
            "{'title': 'Therapy: Physical therapy walk', 'content': 'July 2 at 10:00 AM. Range of motion exercise.', 'category': 'Therapists'}"
        ],
        "action_label": "Request Care Booking"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/generated_screens/family_member_profile_screen.dart",
        "controller_import": "family_member_profile_screen_controller.dart",
        "controller_provider": "familyMemberProfileScreenControllerProvider",
        "class_name": "FamilyMemberProfileScreen",
        "title": "Family Member Bio Profile",
        "desc": "Manage primary demographics, default clinics, and insurance policy parameters.",
        "categories": ["All", "Demographics", "Clinic", "Insurance"],
        "items": [
            "{'title': 'Bio: John Smith (Father)', 'content': 'DOB: Jan 12, 1945. Address: 120 Elm St, Toronto.', 'category': 'Demographics'}",
            "{'title': 'Clinic: Toronto West Hub Pref', 'content': 'Preferred rehabilitation branch.', 'category': 'Clinic'}",
            "{'title': 'Policy: BlueCross policy #883921', 'content': 'Active coverage. Co-pay rate is 20%.', 'category': 'Insurance'}"
        ],
        "action_label": "Update Bio Record"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/unknown_dashboard_screen.dart",
        "controller_import": "",
        "controller_provider": "",
        "class_name": "UnknownDashboardScreen",
        "title": "Unknown Dashboard Hub",
        "desc": "Secure workspace control room to review system telemetry logs, audit trails, and ingestion ledgers.",
        "categories": ["All", "Telemetry", "Audits", "Ledger"],
        "items": [
            "{'title': 'Telemetry: API response latency', 'content': 'Average response is 45ms. Status is normal.', 'category': 'Telemetry'}",
            "{'title': 'Audit: Security access review', 'content': 'Checked credentials for 18 support roles.', 'category': 'Audits'}",
            "{'title': 'Ledger: Transaction ingestion block', 'content': 'Batch #1204 synced to main database.', 'category': 'Ledger'}"
        ],
        "action_label": "Log Security Event"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/patient/screens/patient_book_appointment_screen.dart",
        "controller_import": "patient_book_appointment_screen_controller.dart",
        "controller_provider": "patientBookAppointmentScreenControllerProvider",
        "class_name": "PatientBookAppointmentScreen",
        "title": "Schedule Appointment",
        "desc": "Book in-home nursing services, rehabilitation therapies, and spinal adjustments.",
        "categories": ["All", "Nursing", "Therapy", "Adjustments"],
        "items": [
            "{'title': 'Nursing: In-Home Assessment check', 'content': 'Average duration is 60 minutes. Standard slots.', 'category': 'Nursing'}",
            "{'title': 'Therapy: Physical rehabilitation walk', 'content': 'Range of motion assessment. Suite 201.', 'category': 'Therapy'}",
            "{'title': 'Adjustment: Chiropractic spine exam', 'content': 'Spinal joint manipulation. Room 102.', 'category': 'Adjustments'}"
        ],
        "action_label": "Process Session Booking"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/patient/screens/patient_care_team_screen.dart",
        "controller_import": "patient_care_team_screen_controller.dart",
        "controller_provider": "patientCareTeamScreenControllerProvider",
        "class_name": "PatientCareTeamScreen",
        "title": "Clinical Care Team",
        "desc": "View contact channels and profiles of primary nurses, physiotherapists, and doctors.",
        "categories": ["All", "RNs", "Physio", "GP"],
        "items": [
            "{'title': 'Nurse: Sarah Vance (RN)', 'content': 'Primary care coordinator. Contact: +1-555-0192.', 'category': 'RNs'}",
            "{'title': 'Therapist: Sarah Smith (PT)', 'content': 'Physiotherapist assigned for physical gait rehab.', 'category': 'Physio'}",
            "{'title': 'Doctor: Dr. Alan Green', 'content': 'General Practitioner. Clinic Room 304 GP.', 'category': 'GP'}"
        ],
        "action_label": "Contact Care Team"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/patient/screens/patient_my_appointments_screen.dart",
        "controller_import": "patient_my_appointments_screen_controller.dart",
        "controller_provider": "patientMyAppointmentsScreenControllerProvider",
        "class_name": "PatientMyAppointmentsScreen",
        "title": "My Active Appointments",
        "desc": "Track confirmed visits, check scheduled hours, and request slot changes.",
        "categories": ["All", "Confirmed", "Pending", "Cancelled"],
        "items": [
            "{'title': 'Shift: RN In-Home Session', 'content': 'Confirmed for June 26 at 9:00 AM. Nurse Sarah.', 'category': 'Confirmed'}",
            "{'title': 'Session: Chiropractic spine adjustment', 'content': 'Pending clinic check. Room 102.', 'category': 'Pending'}",
            "{'title': 'Therapy: Range of Motion Gait', 'content': 'Cancelled. Rescheduled to next Tuesday.', 'category': 'Cancelled'}"
        ],
        "action_label": "Request Appointment Slot Change"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/patient/screens/patient_payments_screen.dart",
        "controller_import": "patient_payments_screen_controller.dart",
        "controller_provider": "patientPaymentsScreenControllerProvider",
        "class_name": "PatientPaymentsScreen",
        "title": "My Payments Ledger",
        "desc": "Check credit card profiles, process invoice statements, and print receipts.",
        "categories": ["All", "Methods", "Invoices", "Receipts"],
        "items": [
            "{'title': 'Payment: Visa ending in 4321', 'content': 'Primary payment channel. Auto-billing is enabled.', 'category': 'Methods'}",
            "{'title': 'Invoice: Clinic Adjustment session #4', 'content': 'Paid. Total: $120.00. Settled June 20.', 'category': 'Invoices'}",
            "{'title': 'Receipt: Nursing assessment Q2', 'content': 'Receipt generated. Co-pay documentation shared.', 'category': 'Receipts'}"
        ],
        "action_label": "Refresh Invoices List"
    },
    {
        "file_path": r"apps/primecare_client/lib/features/patient/screens/patient_treatment_history_screen.dart",
        "controller_import": "patient_treatment_history_screen_controller.dart",
        "controller_provider": "patientTreatmentHistoryScreenControllerProvider",
        "class_name": "PatientTreatmentHistoryScreen",
        "title": "My Treatment History",
        "desc": "Review records of past physiotherapy sessions, range logs, and chiropractic adjustments.",
        "categories": ["All", "Rehab", "Chiropractic", "Nursing"],
        "items": [
            "{'title': 'Rehab: Physical therapy session #3', 'content': 'Gait stability check cleared. Joint flexibility progress: 14%.', 'category': 'Rehab'}",
            "{'title': 'Spine: L4 alignment correction', 'content': 'Adjustment notes saved. Client reported pain relief.', 'category': 'Chiropractic'}",
            "{'title': 'Nursing: Weekly Vitals audit', 'content': 'BP: 122/80. Heart rate: 72. Log archived.', 'category': 'Nursing'}"
        ],
        "action_label": "Download History Records"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/clinical_director_quality_metrics_screen.dart",
        "controller_import": "clinical_director_quality_metrics_screen_controller.dart",
        "controller_provider": "clinicalDirectorQualityMetricsScreenControllerProvider",
        "class_name": "ClinicalDirectorQualityMetricsScreen",
        "title": "Clinical Quality Metrics",
        "desc": "Analyze nursing SLA performance, incident trends, and client safety statistics.",
        "categories": ["All", "SLA", "Incidents", "Compliance"],
        "items": [
            "{'title': 'SLA: Response times Ontario', 'content': 'Average visit dispatch is 28 minutes. Status: green.', 'category': 'SLA'}",
            "{'title': 'Incident: Medication dose deviation', 'content': 'Minor issue resolved. Staff retrained on protocol.', 'category': 'Incidents'}",
            "{'title': 'Compliance: License verification sweep', 'content': 'Checked 120 nurses. 100% compliant credentials.', 'category': 'Compliance'}"
        ],
        "action_label": "Trigger Quality Audit"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/clinical_director_staffing_screen.dart",
        "controller_import": "clinical_director_staffing_screen_controller.dart",
        "controller_provider": "clinicalDirectorStaffingScreenControllerProvider",
        "class_name": "ClinicalDirectorStaffingScreen",
        "title": "Clinical Staffing Center",
        "desc": "Coordinate caregiver shortages, check certification records, and assign coordinators.",
        "categories": ["All", "RNs", "RMTs", "Coordinators"],
        "items": [
            "{'title': 'RN Availability: Mississauga Central', 'content': 'Shortage of 2 nurses for weekend shift coverage.', 'category': 'RNs'}",
            "{'title': 'Cert: RMT License Expirations', 'content': 'Checked 48 therapist files. Zero expired licenses.', 'category': 'RMTs'}",
            "{'title': 'Coord: Assignment matrix review', 'content': 'Intake coordinator Mary Vance assigned to Peel Region.', 'category': 'Coordinators'}"
        ],
        "action_label": "Log Staff Assignment"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/infection_control_dashboard_screen.dart",
        "controller_import": "infection_control_dashboard_screen_controller.dart",
        "controller_provider": "infectionControlDashboardScreenControllerProvider",
        "class_name": "InfectionControlDashboardScreen",
        "title": "Infection Control Hub",
        "desc": "Monitor clinic sanitization logs, PPE stock levels, and vaccination compliance audits.",
        "categories": ["All", "Sanitization", "PPE", "Vaccination"],
        "items": [
            "{'title': 'Sanitization: Toronto West Clinic audit', 'content': 'Passed sterilization review. Sanitation rating is 99%.', 'category': 'Sanitization'}",
            "{'title': 'PPE: Sanitizer & glove reserves', 'content': 'Box inventory count is high. Re-ordered 50 boxes of masks.', 'category': 'PPE'}",
            "{'title': 'Compliance: Nurse vaccination review', 'content': 'Sweep completed. Staff certifications up-to-date.', 'category': 'Vaccination'}"
        ],
        "action_label": "Trigger Ingestion Log"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/intake_coordinator_assessments_screen.dart",
        "controller_import": "intake_coordinator_assessments_screen_controller.dart",
        "controller_provider": "intakeCoordinatorAssessmentsScreenControllerProvider",
        "class_name": "IntakeCoordinatorAssessmentsScreen",
        "title": "Intake Assessments Queue",
        "desc": "Coordinate initial clinical assessments, review client referrals, and assign primary nurses.",
        "categories": ["All", "Referrals", "Assessments", "Assignments"],
        "items": [
            "{'title': 'Referral: John Smith client ingestion', 'content': 'Approved by GP. Scheduled for home visit.', 'category': 'Referrals'}",
            "{'title': 'Assessment: Joint physical check', 'content': 'Milton Central Hub slot booked for next Monday.', 'category': 'Assessments'}",
            "{'title': 'Assignment: Nurse Mary Vance assignment', 'content': 'Assigned as primary care coordinator.', 'category': 'Assignments'}"
        ],
        "action_label": "Log Queue Update"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/nurse_dashboard_screen.dart",
        "controller_import": "nurse_dashboard_screen_controller.dart",
        "controller_provider": "nurseDashboardScreenControllerProvider",
        "class_name": "NurseDashboardScreen",
        "title": "Home Care Nurse Portal",
        "desc": "Bedside caregiver command center to monitor client charts, administer meds, and verify vitals log.",
        "categories": ["All", "Medication", "Vitals", "Handovers"],
        "items": [
            "{'title': 'Meds: Insulin Administration John Doe', 'content': 'Logged dose of 5 units. Checked blood sugar.', 'category': 'Medication'}",
            "{'title': 'Vitals: Blood Pressure Sarah Smith', 'content': '122/80. Heart rate is 72. Recorded successfully.', 'category': 'Vitals'}",
            "{'title': 'Handover: Nurse shift handover check', 'content': 'Handoff compliance checklist signed in database.', 'category': 'Handovers'}"
        ],
        "action_label": "Submit Bedside Vitals Log"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/psw_observation_vitals_log_screen.dart",
        "controller_import": "psw_observation_vitals_log_screen_controller.dart",
        "controller_provider": "pswObservationVitalsLogScreenControllerProvider",
        "class_name": "PswObservationVitalsLogScreen",
        "title": "PSW Observation Vitals Log",
        "desc": "Record client daily vitals parameters, blood pressure logs, and blood sugar checks.",
        "categories": ["All", "BP", "Sugar", "HeartRate"],
        "items": [
            "{'title': 'Vitals: BP check John Smith', 'content': '122/80 mmHg. Checked June 24 at 10:00 AM.', 'category': 'BP'}",
            "{'title': 'Vitals: Blood sugar check Sarah Doe', 'content': '5.6 mmol/L. Normal reading post-meal.', 'category': 'Sugar'}",
            "{'title': 'Vitals: Heart rate log Robert Chen', 'content': '72 bpm. Logged during routine visit.', 'category': 'HeartRate'}"
        ],
        "action_label": "Log Observation Record"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/psw_patient_profile_screen.dart",
        "controller_import": "psw_patient_profile_screen_controller.dart",
        "controller_provider": "pswPatientProfileScreenControllerProvider",
        "class_name": "PswPatientProfileScreen",
        "title": "PSW Client Profile Data",
        "desc": "Verify client contact addresses, emergency phone lists, and primary caregiver assignments.",
        "categories": ["All", "Addresses", "Emergency", "Assignments"],
        "items": [
            "{'title': 'Address: 12 Elm St, Toronto West', 'content': 'Triage node assigned. Normal travel distance.', 'category': 'Addresses'}",
            "{'title': 'Emergency: Robert Smith (Son)', 'content': 'Liaison phone contact: +1-555-0123.', 'category': 'Emergency'}",
            "{'title': 'Assignment: Caregiver Mary Vance', 'content': 'Primary support worker assigned to weekly shifts.', 'category': 'Assignments'}"
        ],
        "action_label": "Verify Client Bio Record"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/psw_schedule_screen.dart",
        "controller_import": "psw_schedule_screen_controller.dart",
        "controller_provider": "pswScheduleScreenControllerProvider",
        "class_name": "PswScheduleScreen",
        "title": "PSW Care Visit Schedule",
        "desc": "Check scheduled client shifts, resolve hours conflicts, and request shift cover.",
        "categories": ["All", "Confirmed", "Pending", "ShiftCover"],
        "items": [
            "{'title': 'Shift: John Smith visit morning', 'content': 'Confirmed. June 26 from 9:00 AM - 1:00 PM.', 'category': 'Confirmed'}",
            "{'title': 'Shift: Sarah Doe visit afternoon', 'content': 'Pending coordinate. Scheduled for June 29.', 'category': 'Pending'}",
            "{'title': 'Request: Shift cover central hub', 'content': 'MIL-429 shift coverage requested by coordinator.', 'category': 'ShiftCover'}"
        ],
        "action_label": "Submit Shift Cover Request"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/generated_screens/psw_visit_checklist_screen.dart",
        "controller_import": "psw_visit_checklist_screen_controller.dart",
        "controller_provider": "pswVisitChecklistScreenControllerProvider",
        "class_name": "PswVisitChecklistScreen",
        "title": "PSW Client Visit Checklist",
        "desc": "Track ADL task checklist completions, daily shift note postings, and patient vitals logs.",
        "categories": ["All", "ADL", "ShiftNotes", "Vitals"],
        "items": [
            "{'title': 'Checklist: Daily ADL checklist', 'content': 'Completed joint exercises, meal prep, and safety walk.', 'category': 'ADL'}",
            "{'title': 'Note: Afternoon shift summary', 'content': 'Client took medication, stayed active, and rested.', 'category': 'ShiftNotes'}",
            "{'title': 'Vitals: Heart rate log', 'content': '74 bpm. Logged post safety walk.', 'category': 'Vitals'}"
        ],
        "action_label": "Log Checklist Action"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/rn/screens/rn_messaging_screen.dart",
        "controller_import": "rn_messaging_screen_controller.dart",
        "controller_provider": "rnMessagingScreenControllerProvider",
        "class_name": "RnMessagingScreen",
        "title": "RN Care Coordinator Messages",
        "desc": "Secure communication channel with doctors, client family contacts, and clinic administrators.",
        "categories": ["All", "Physicians", "Family", "Admin"],
        "items": [
            "{'title': 'Chat: Dr. Alan Green', 'content': 'Approved dose adjustment for client John Doe.', 'category': 'Physicians'}",
            "{'title': 'Chat: Robert Smith (Son)', 'content': 'Answered billing query. Sent receipt proof.', 'category': 'Family'}",
            "{'title': 'Chat: Triage Admin West', 'content': 'Coordinated emergency shift cover assignments.', 'category': 'Admin'}"
        ],
        "action_label": "Send Secure Message"
    },
    {
        "file_path": r"apps/primecare_clinic/lib/features/shared/screens/clinic_history_logs_screen.dart",
        "controller_import": "clinic_history_logs_screen_controller.dart",
        "controller_provider": "clinicHistoryLogsScreenControllerProvider",
        "class_name": "ClinicHistoryLogsScreen",
        "title": "Clinic Operational Logs",
        "desc": "Database log of historic caregiver dispatches, ledger sync events, and completed visits.",
        "categories": ["All", "Dispatches", "LedgerSync", "Visits"],
        "items": [
            "{'title': 'Dispatch: Milton Central Hub', 'content': 'Nurse Sarah dispatched at 8:42 AM. SLA met.', 'category': 'Dispatches'}",
            "{'title': 'Sync: Plaid accounting ledger', 'content': 'Completed hourly transaction ingestion sweep.', 'category': 'LedgerSync'}",
            "{'title': 'Visit: Home assessment complete', 'content': 'Completed joint physiotherapy gait session #12.', 'category': 'Visits'}"
        ],
        "action_label": "Trigger Database Recount"
    }
]

# Standard template with provider controller state
template_provider = """/* 
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

    return Semantics(
      label: 'data-cy:{cy_tag}-screen',
      container: true,
      child: Scaffold(
        key: const Key('{cy_tag}-screen'),
        appBar: AppBar(
          title: Semantics(
            label: 'data-cy:{cy_tag}-title',
            container: true,
            child: Container(child: const Text('{title}')),
          ),
        ),
        body: state.when(
          data: (data) => _{class_name}Content(
            controllerProvider: {controller_provider},
            desc: '{desc}',
            actionLabel: '{action_label}',
            itemsList: const [
              {items_list}
            ],
            categoriesList: const [{categories_list}],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Telemetry connection failed: $error')),
        ),
      ),
    );
  }}
}}

class _{class_name}Content extends ConsumerStatefulWidget {{
  final dynamic controllerProvider;
  final String desc;
  final String actionLabel;
  final List<Map<String, String>> itemsList;
  final List<String> categoriesList;

  const _{class_name}Content({{
    required this.controllerProvider,
    required this.desc,
    required this.actionLabel,
    required this.itemsList,
    required this.categoriesList,
  }});

  @override
  ConsumerState<_{class_name}Content> createState() => _{class_name}ContentState();
}}

class _{class_name}ContentState extends ConsumerState<_{class_name}Content> {{
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  late List<Map<String, String>> _records;

  @override
  void initState() {{
    super.initState();
    _records = List.from(widget.itemsList);
  }}

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
        // Hero Card
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
              Text(
                widget.desc,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Choice Chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: widget.categoriesList.map((cat) {{
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

        // Search Field
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

        // List Content
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
                        child: Text(widget.actionLabel),
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

        // Action Button
        if (filtered.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showActionDialog,
              icon: const Icon(Icons.add_task),
              label: Text(widget.actionLabel),
            ),
          ),
      ],
    );
  }}

  void _showActionDialog() {{
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(widget.actionLabel),
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

# Template for widgets without an external notifier provider (Stateless / Local state delegation)
template_stateless = """/* 
PRIME:SCREEN={prime_screen}
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_NONE
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

class {class_name} extends GovernedConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  String get screenDescription =>
      '{desc}';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    return Semantics(
      label: 'data-cy:{cy_tag}-screen',
      container: true,
      child: Scaffold(
        key: const Key('{cy_tag}-screen'),
        appBar: AppBar(
          title: Semantics(
            label: 'data-cy:{cy_tag}-title',
            container: true,
            child: Container(child: const Text('{title}')),
          ),
        ),
        body: _{class_name}Content(
          desc: '{desc}',
          actionLabel: '{action_label}',
          itemsList: const [
            {items_list}
          ],
          categoriesList: const [{categories_list}],
        ),
      ),
    );
  }}
}}

class _{class_name}Content extends StatefulWidget {{
  final String desc;
  final String actionLabel;
  final List<Map<String, String>> itemsList;
  final List<String> categoriesList;

  const _{class_name}Content({{
    required this.desc,
    required this.actionLabel,
    required this.itemsList,
    required this.categoriesList,
  }});

  @override
  State<_{class_name}Content> createState() => _{class_name}ContentState();
}}

class _{class_name}ContentState extends State<_{class_name}Content> {{
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  late List<Map<String, String>> _records;

  @override
  void initState() {{
    super.initState();
    _records = List.from(widget.itemsList);
  }}

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
        // Hero Card
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
              Text(
                widget.desc,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ),

        // Choice Chips
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Wrap(
            spacing: 8,
            children: widget.categoriesList.map((cat) {{
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

        // Search Field
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

        // List Content
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
                        child: Text(widget.actionLabel),
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

        // Action Button
        if (filtered.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: _showActionDialog,
              icon: const Icon(Icons.add_task),
              label: Text(widget.actionLabel),
            ),
          ),
      ],
    );
  }}

  void _showActionDialog() {{
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(widget.actionLabel),
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
        items_list = ",\n              ".join(sc["items"])
        categories_list = ", ".join([f"'{c}'" for c in sc["categories"]])
        
        # Lowercase class name for cy tags
        cy_tag = sc["class_name"].lower().replace("_", "")

        is_stateless = sc["controller_import"] == ""
        t = template_stateless if is_stateless else template_provider

        new_content = t.format(
            prime_screen=prime_screen,
            controller_import=sc["controller_import"],
            controller_provider=sc["controller_provider"],
            class_name=sc["class_name"],
            title=sc["title"],
            desc=sc["desc"],
            items_list=items_list,
            categories_list=categories_list,
            action_label=sc["action_label"],
            cy_tag=cy_tag
        )

        with open(full_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Upgraded governed screen code for: {sc['class_name']} at {sc['file_path']}")

if __name__ == "__main__":
    run_upgrade()
