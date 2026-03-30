class FormRegistry {
  static const String dailyEntry = 'form_daily_entry';
  static const String incidentReport = 'form_incident_report';
  static const String vitals = 'form_vitals';
  static const String intake = 'form_intake';
  
  static final Map<String, String> _schemaMappings = {
    dailyEntry: '/api/v1/schemas/daily_entry',
    incidentReport: '/api/v1/schemas/incident_report',
    vitals: '/api/v1/schemas/vitals',
    intake: '/api/v1/schemas/intake',
  };

  static String getSchemaEndpoint(String formId) {
    return _schemaMappings[formId] ?? '/api/v1/schemas/fallback';
  }
}
