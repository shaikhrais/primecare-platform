import re

with open('test/dashboard_smoke_test.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('OwnerDashboard()', 'OwnerDashboardScreen()')
content = content.replace('franchise_owner_dash.OwnerDashboard,', 'franchise_owner_dash.OwnerDashboardScreen,')

content = content.replace('ClientDashboard()', 'ClientDashboardScreen()')
content = content.replace('patient_dash.ClientDashboard,', 'patient_dash.ClientDashboardScreen,')

content = content.replace('FamilyDashboard()', 'FamilyDashboardScreen()')
content = content.replace('family_member_dash.FamilyDashboard,', 'family_member_dash.FamilyDashboardScreen,')

with open('test/dashboard_smoke_test.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Updated dashboard_smoke_test.dart")
