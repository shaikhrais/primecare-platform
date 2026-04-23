// Layer: 02_MODELS
import 'package:equatable/equatable.dart';

class IntakeCoordinatorViewModel extends Equatable {
  final int newReferrals;
  final int pendingAssessments;
  final double conversionRate;

  const IntakeCoordinatorViewModel({
    required this.newReferrals,
    required this.pendingAssessments,
    required this.conversionRate,
  });

  @override
  List<Object?> get props => [newReferrals, pendingAssessments, conversionRate];
}
