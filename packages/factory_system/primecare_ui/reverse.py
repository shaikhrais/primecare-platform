import re

with open('lib/src/features/features_view.dart', 'r', encoding='utf-8') as f:
    content = f.read()

# We have pairs of View and ViewModel. Let's find each _buildContent and its parameter.
# Wait, I just ran a script to change specific types to dynamic vm. I can just reverse it!

replacements = [
    ('dynamic vm,', 'BillingAdminDashboardViewModel vm,'),
    ('dynamic vm,', 'CeoDashboardModel vm,'),
    ('dynamic vm)', 'ClientViewModel vm)'),
    ('dynamic vm,', 'ClientDashboardViewModel vm,'),
    ('dynamic vm)', 'ClinicalDirectorViewModel vm)'),
    ('dynamic vm,', 'ClinicalDirectorDashboardViewModel vm,'),
    ('dynamic vm,', 'ClinicDashboardModel vm,'),
    ('dynamic vm,', 'CommunityOutreachDashboardViewModel vm,'),
    ('dynamic vm,', 'CorporateGovernanceDashboardViewModel vm,'),
    ('dynamic vm)', 'IntakeCoordinatorViewModel vm)'),
    ('dynamic vm,', 'PatientDashboardViewModel vm,'),
    ('dynamic vm)', 'PswViewModel vm)'),
    ('dynamic vm)', 'RnViewModel vm)'),
    ('dynamic vm)', 'RpnViewModel vm)'),
    ('dynamic vm)', 'ShareholderIntelligenceViewModel vm)'),
]

# Wait, if I just replace 'dynamic vm,' with the first one, it will replace ALL 'dynamic vm,' with 'BillingAdminDashboardViewModel vm,'.
# I should use regex to match the class name to get the correct type.
