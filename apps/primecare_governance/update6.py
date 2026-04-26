import re
with open('lib/screens/governance/governance_data_entry_screen.dart', 'r', encoding='utf-8') as f:
  c = f.read()

c = c.replace('Colors.white', 'PrimeCareColors.white')
c = c.replace('Colors.grey', 'PrimeCareColors.slate500')

with open('lib/screens/governance/governance_data_entry_screen.dart', 'w', encoding='utf-8') as f:
  f.write(c)
