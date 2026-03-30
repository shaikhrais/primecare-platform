import 'dart:convert';

class FormSchemaLoader {
  static Future<Map<String, dynamic>> loadSchema(String formId) async {
    // In production, this actively queries the worker-api.
    // For scaffolding, we mock the SDUI endpoints based on formId.
    
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate latency
    
    if (formId == 'psw_shifts') {
      return {
        "title": "Shift Check-in",
        "description": "Log your time and travel accurately.",
        "fields": [
          {"id": "clockIn", "type": "time", "label": "Clock In Time", "required": true},
          {"id": "clockOut", "type": "time", "label": "Clock Out Time", "required": true},
          {"id": "mileage", "type": "number", "label": "Travel Distance (km)", "required": false},
          {"id": "notes", "type": "textarea", "label": "Shift Notes", "required": false}
        ]
      };
    } else if (formId == 'rn_vitals') {
      return {
        "title": "Patient Vitals Triage",
        "description": "Critical vitals tracker.",
        "fields": [
          {"id": "bp", "type": "text", "label": "Blood Pressure (e.g., 120/80)", "required": true},
          {"id": "hr", "type": "number", "label": "Heart Rate (bpm)", "required": true},
          {"id": "glucose", "type": "number", "label": "Blood Glucose (mmol/L)", "required": false},
          {"id": "urgent", "type": "checkbox", "label": "Flag as Urgent Review", "required": false}
        ]
      };
    } else if (formId == 'rn_incidents') {
      return {
        "title": "Clinical Incident Report",
        "description": "File an incident review.",
        "fields": [
          {
            "id": "type",
            "type": "dropdown",
            "label": "Incident Origin",
            "options": ["Slip/Fall", "Medication Error", "Behavioral", "Equipment Failure"],
            "required": true
          },
          {"id": "details", "type": "textarea", "label": "Comprehensive Description", "required": true},
          {"id": "severity", "type": "slider", "label": "Severity Scale (1-10)", "min": 1, "max": 10, "required": true}
        ]
      };
    }

    return {
      "title": "Generic Fallback Form",
      "description": "No localized mapping found for schema: \$formId",
      "fields": []
    };
  }
}
