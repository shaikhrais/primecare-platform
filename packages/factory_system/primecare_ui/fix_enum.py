import re

with open('lib/src/shared/src/registry/primecare_form_enum.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace(
    "case PrimeCareForm.hudProfilePreview:\n        return 'HUD_PROFILE_PREVIEW';",
    "case PrimeCareForm.hudProfilePreview:\n        return 'HUD_PROFILE_PREVIEW';\n      case PrimeCareForm.incidentReports:\n        return 'INCIDENT_REPORTS';"
)

with open('lib/src/shared/src/registry/primecare_form_enum.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Added incidentReports")
