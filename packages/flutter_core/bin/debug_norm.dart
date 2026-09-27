// Governance - Category: service | Purpose: Core implementation file for the Debug Norm platform logic.
void main() {
  String normalize(String fileName, String suffix) {
    return fileName
        .replaceAll('03_V_', '')
        .replaceAll('04_A_', '')
        .replaceAll('05_U_', '')
        .replaceAll('_dashboard', '')
        .replaceAll(suffix, '');
  }

  final fileName = 'volunteer_coordinator_dashboard_intent.dart';
  final suffix = '_intent.dart';
  print('Normalized: "' + normalize(fileName, suffix) + '"');
}
