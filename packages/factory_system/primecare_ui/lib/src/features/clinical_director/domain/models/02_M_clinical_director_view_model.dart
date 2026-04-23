// Layer: 02_MODELS
import 'package:equatable/equatable.dart';

class ClinicalDirectorViewModel extends Equatable {
  final String directorName;
  final int activePatients;
  final double qualityScore;
  final List<String> criticalAlerts;

  const ClinicalDirectorViewModel({
    required this.directorName,
    required this.activePatients,
    required this.qualityScore,
    required this.criticalAlerts,
  });

  @override
  List<Object?> get props => [directorName, activePatients, qualityScore, criticalAlerts];
}
