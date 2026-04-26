import re
with open('lib/main.dart', 'r', encoding='utf-8') as f:
  c = f.read()

c = c.replace('AppTheme.primary', 'PrimeCareColors.slate800')
c = c.replace('AppTheme.secondary', 'PrimeCareColors.slate700')
c = c.replace('AppTheme.background', 'PrimeCareColors.slate50')
c = c.replace('AppTheme.surface', 'PrimeCareColors.white')
c = c.replace('AppTheme.border', 'PrimeCareColors.slate200')

with open('lib/main.dart', 'w', encoding='utf-8') as f:
  f.write(c)
