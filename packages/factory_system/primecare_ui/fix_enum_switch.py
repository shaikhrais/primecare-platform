with open('lib/src/shared/src/registry/primecare_form_enum.dart', 'r', encoding='utf-8') as f:
    content = f.read()

replacement = '''
      case PrimeCareForm.itAdminDashboard:
        return 'IT_ADMIN_DASHBOARD';
      case PrimeCareForm.trainingDirectorCertificate:
        return 'TRAINING_DIRECTOR_CERTIFICATE';
      case PrimeCareForm.systemDashboard:
        return 'SYSTEM_DASHBOARD';
      case PrimeCareForm.systemVerificationDashboard:
        return 'SYSTEM_VERIFICATION_DASHBOARD';
      case PrimeCareForm.systemHealthDashboard:
        return 'SYSTEM_HEALTH_DASHBOARD';
    }
  }
'''

content = content.replace("      case PrimeCareForm.itAdminDashboard:\n        return 'IT_ADMIN_DASHBOARD';\n    }\n  }", replacement)

with open('lib/src/shared/src/registry/primecare_form_enum.dart', 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated switch")
