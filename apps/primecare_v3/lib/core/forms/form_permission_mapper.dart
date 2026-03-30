class FormPermissionMapper {
  static final Map<String, List<String>> _roleFormAccess = {
    'psw': ['form_daily_entry', 'form_incident_report'],
    'rn': ['form_daily_entry', 'form_incident_report', 'form_vitals', 'form_care_plan_assessment'],
    'client': ['form_intake', 'form_satisfaction_survey'],
    'family_member': ['form_satisfaction_survey', 'form_incident_inquiry'],
    'territory_sales_manager': ['form_lead_generation', 'form_contract_initiation'],
  };

  /// Validates if the given [roleCode] is authorized to load the [formId].
  static bool canAccessForm(String roleCode, String formId) {
    if (!_roleFormAccess.containsKey(roleCode)) return false;
    return _roleFormAccess[roleCode]!.contains(formId);
  }

  /// Returns a clean UI array of authorized schema routes for the Master Navigation engine.
  static List<String> getAuthorizedEndpoints(String roleCode) {
    if (!_roleFormAccess.containsKey(roleCode)) return [];
    return _roleFormAccess[roleCode]!;
  }
}
