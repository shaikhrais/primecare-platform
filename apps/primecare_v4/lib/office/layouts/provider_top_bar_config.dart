class ProviderTopBarConfig {
  /// Base actions available to all clinical providers
  static const List<String> commonQuickActions = [
    'New Client',
    'New Appointment',
    'New Note',
    'Upload File',
    'Create Invoice'
  ];

  /// Role-specific items appended to the Quick Add dropdown
  static const Map<String, List<String>> roleSpecificQuickActions = {
    'RMT': ['SOAP Note', 'Homecare Plan'],
    'RN': ['Nursing Note', 'Care Plan', 'Incident Report'],
    'Physio': ['Assessment', 'Exercise Plan', 'Progress Note'],
    'Chiro': ['Spinal Exam', 'Treatment Note', 'Care Plan']
  };

  /// Floating shortcut chips displayed below or inside the top bar for quick status checks
  static const Map<String, List<String>> roleExtraChips = {
    'RMT': ['Today\'s clients', 'Treatment notes pending', 'Insurance receipts'],
    'RN': ['High-risk alerts', 'Pending assessments', 'Care plan reviews'],
    'Physio': ['Initial assessments', 'Reassessment due', 'Exercise program updates'],
    'Chiro': ['Re-exams due', 'X-ray/report review', 'Treatment plans pending']
  };

}
